class TemplatesController < InheritedResources::Base

  defaults :resource_class => ZoneTemplate, :collection_name => 'zone_templates', :instance_name => 'zone_template'
  respond_to :html, :xml, :json

  def zone_template_params
    params.require(:zone_template).permit!
  end

  def create
    @zone_template = ZoneTemplate.new(zone_template_params)
    @zone_template.user = current_user unless current_user.admin?

    create! { zone_template_path( @zone_template ) }
  end

  protected

  def collection
    @zone_templates = ZoneTemplate.user(current_user).all
  end

end
