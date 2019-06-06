# rake apply_macro domain_id=152 user_id=1 macro_id=4
desc "apply macro to domain"
task :apply_macro => :environment do
  domain_id = ENV['domain_id'] || nil
  user_id   = ENV['user_id']   || 1
  macro_id  = ENV['macro_id']  || nil
  
  if macro_id == nil
    puts "macro_id is missing"
    exit 1
  end
  
  current_user = User.find(user_id)
  if domain_id == nil
    Domain.all.each do |domain|
      if domain.type == "MASTER"
        puts "apply macro to domain '#{domain.name}'"
        macro  = Macro.user( current_user ).find( macro_id )
        macro.apply_to( domain )
      else
        puts "domain '#{domain.name}' is not of type MASTER"
      end
    end
  else
    domain = Domain.find(domain_id)
    if domain.type == "MASTER"
      puts "apply macro to domain '#{domain.name}'"
      macro  = Macro.user( current_user ).find( macro_id )
      macro.apply_to( domain )
    else
      puts "domain '#{domain.name}' is not of type MASTER"
    end
  end
end