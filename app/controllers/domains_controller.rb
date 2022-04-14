class DomainsController < InheritedResources::Base

  # Keep token users in line
  before_filter :restrict_token_movements, :except => :show

  custom_actions :resource => :apply_macro
  respond_to :xml, :json, :js, :html

  def domains_params
    params.require(:domain).permit(:name, :zone_template_id, :type, :master, :primary_ns, :contact, :refresh, :retry, :expire, :minimum, :ttl)
  end
  
  def apply_params
    params.permit(:macro_id, :id)
  end

  protected

  def collection
    per_page = params[:per_page] == '-1' ? Domain.count : params[:per_page]
    @domains = Domain.user( current_user ).paginate( page: params[:page], per_page: per_page ).to_a
  end

  def resource
    @domain = Domain.all.includes(:records)

    if current_user
      @domain = @domain.user( current_user ).find( params[:id] )
    else
      @domain = @domain.find( current_token.domain_id )
    end
    @domain
  end

  def restrict_token_movements
    redirect_to domain_path( current_token.domain ) if current_token
  end

  private

  def build_resource_params
    [params.fetch(:domain, {}).permit(:name, :zone_template_id, :type, :master, :primary_ns, :contact, :refresh, :retry, :expire, :minimum, :ttl, :macro_id)]
  end

  public

  def show
    if current_user && current_user.admin?
      @users = User.active_owners
    end

    show!
  end

  def create
    @domain = Domain.new( domains_params )

    unless @domain.slave?
      @zone_template = ZoneTemplate.find(domains_params[:zone_template_id]) unless domains_params[:zone_template_id].blank?
      @zone_template ||= ZoneTemplate.find_by(name: params[:domain][:zone_template_name]) unless domains_params[:zone_template_name].blank?

      if @zone_template.present?
        begin
          @domain = @zone_template.build( domains_params[:name] )
        rescue ActiveRecord::RecordInvalid => e
          @domain.attach_errors(e)

          render :action => :new
          return
        end
      end
    end

    @domain.user = current_user unless current_user.admin?

    create!
  end

  # Non-CRUD methods
  def update_note
    resource.update_attribute( :notes, domains_params[:notes] )
  end

  def change_owner
    resource.update_attribute( :user_id, domains_params[:user_id] )

    respond_to do |wants|
      wants.js
    end
  end

  # GET: list of macros to apply
  # POST: apply selected macro
  def apply_macro
    @domain = resource

    if request.get?
      @macros = Macro.user(current_user)

      respond_to do |format|
        format.html
        format.json
        format.xml
      end

    else
      @macro = Macro.user( current_user ).find( apply_params[:macro_id] )
      @macro.apply_to( resource )

      respond_to do |format|
        format.html {
          flash[:notice] = t(:message_domain_macro_applied)
          redirect_to resource
        }
        format.json { render :status => 202 }
        format.xml { render :status => 202 }
      end

    end

  end

end
