# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Outputs a page title with +@page_title+ appended
  def page_title
    title = t(:layout_main_title)
    title << ' - ' + @page_title unless @page_title.nil?
    title
  end

  # Output the flashes if they exist
  def show_flash
    html = ''
    [ :alert, :notice, :info, :warning, :error ].each do |f|
      options = { :id => "flash-#{f}", :class => "flash-#{f}" }
      options.merge!( :style => 'display:none' ) if flash[f].nil?
      html << content_tag( 'div', options ) { flash[f] || '' }
    end
    html.html_safe
  end

  # Link to Zytrax
  def dns_book( text, link )
    link_to text, "http://www.zytrax.com/books/dns/#{link}", :target => '_blank'
  end

  # Add a cancel link for shared forms. Looks at the provided object and either
  # creates a link to the index or show actions.
  def link_to_cancel( object )
    path = object.class.name.tableize
    path = if object.new_record?
             send( path.pluralize + '_path' )
           else
             send( path.singularize + '_path', object )
           end
    link_to "Cancel", path
  end

  def help_icon( dom_id )
    image_tag('help.png', :id => "help-icn-#{dom_id}", :class => 'help-icn', "data-help" => dom_id )
  end

  def info_icon( image, dom_id )
    image_tag( image , :id => "help-icn-#{dom_id}", :class => 'help-icn', "data-help" => dom_id )
  end
  
  def font_icon(icon,dom_id,text,_class="")
    fa_icon(icon, text: text, id: "help-icn-#{dom_id}", class: "fa-2x sub #{_class}", "data-help": dom_id)
  end

  # Convert ttl in seconds to a more human readable format
  def human_readable_ttl( seconds )
    seconds = seconds.to_i
    minute  = 60
    hour    = minute*60
    day     = hour*24
    week    = day*7

    out = []
    if seconds >= week
      out << t(:x_ttl_weeks, :count => (seconds/week))
      seconds %= week
    end

    if seconds >= day
      out << t(:x_ttl_days, :count => (seconds/day))
      seconds %= day
    end

    if seconds >= hour
      out << t(:x_ttl_hours, :count => (seconds/hour))
      seconds %= hour
    end

    if seconds >= minute
      out << t(:x_ttl_minutes, :count => (seconds/minute))
      seconds %= minute
    end
    out.join(' ')
  end

end
