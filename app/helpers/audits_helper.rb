module AuditsHelper

  def parenthesize( text )
    "(#{text})"
  end

  def link_to_domain_audit( audit )
    caption = "#{audit.version} #{audit.action} by "
    caption << audit_user( audit )
    link_to caption, '#', onclick: "toggleDomainAudit(#{audit.id}); return false;"
  end

  def link_to_record_audit( audit )
    caption = audit.audited_changes['type']
    caption ||= (audit.auditable.nil? ? '[UNKNOWN]' : audit.auditable.class.to_s )
    unless audit.audited_changes['name'].nil?
      name = audit.audited_changes['name'].is_a?( Array ) ? audit.audited_changes['name'].pop : audit.audited_changes['name']
      caption += " (#{name})"
    end
    caption += " #{audit.version} #{audit.action} by "
    caption += audit_user( audit )
    link_to caption, '#', onclick: "toggleRecordAudit(#{audit.id}); return false;"
  end

  def display_hash( hash )
    hash ||= {}
    hash.map do |k,v|
      if v.nil?
        nil # strip out non-values
      else
        if v.is_a?( Array )
          v = "From <em>#{v.shift}</em> to <em>#{v.shift}</em>"
        end

        "<em>#{k}</em>: #{v}"
      end
    end.compact.join('<br />')
  end

  def sort_audits_by_date( collection )
    collection.sort_by(&:created_at).reverse
  end

  def audit_user( audit )
    if audit.user.is_a?( User )
      audit.user.login
    else
      audit.username || 'UNKNOWN'
    end
  end

end
