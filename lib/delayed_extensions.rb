module DelayedExtensions
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      before_destroy :process_axfr_notification
      before_save    :process_axfr_notification
      private
      def self.send_axfr_notification(args={})
        session = ::Rundeck::Session.new(ENV['RUNDECK_URL'], ENV['RUNDECK_TOKEN'])
        job = ::Rundeck::Job.find(session, ENV['RUNDECK_JOB_UUID'])
        job.execute!(args)
      end
    end
  end
  
  module InstanceMethods
    def process_axfr_notification
      RequestStore.store[:domain_lock] = (self.class == Domain && RequestStore.store[:domain_lock].to_i == 0 ? 1 : RequestStore.store[:domain_lock])
      unless self.class == SOA
        if RequestStore.store[:domain_lock] == 1 && self.class == Domain
          RequestStore.store[:domain_lock] += 1
          self.class.delay(run_at: 2.minutes.from_now).send_axfr_notification
        elsif RequestStore.store[:domain_lock].to_i == 0
          self.class.delay(run_at: 2.minutes.from_now).send_axfr_notification
        end
      end
    end
  end # InstanceMethods
  
end

