class RecordsController < InheritedResources::Base

  belongs_to :domain
  respond_to :xml, :json, :js

  before_action :restrict_token_movements, :except => [:create, :update, :destroy]

  rescue_from AuthToken::Denied do
    render :text => t(:message_token_not_authorized), :status => 403
  end

  def create
    @record = parent.send( "#{records_params[:type].downcase}_records".to_sym ).new( records_params )

    if current_token && !current_token.allow_new_records? &&
        !current_token.can_add?( @record )
      render :text => t(:message_token_not_authorized), :status => 403
      return
    end

    create! do
      if @record.persisted?
        # Give the token the right to undo what it just did
        if current_token
          current_token.can_change @record
          current_token.remove_records = true
          current_token.save
        end
      end
    end
  end

  def update
    if current_token && !current_token.can_change?( resource )
      render :text => t(:message_token_not_authorized), :status => 403
      return
    end

    update!
  end

  def destroy
    if current_token && !current_token.can_remove?( resource )
      render :text => t(:message_token_not_authorized), :status => 403
      return
    end

    destroy! do |format|
      format.html { redirect_to parent }
    end
  end

  # Non-CRUD methods
  def update_soa
    @domain = parent
    @domain.soa_record.update( soa_params )
  end
  
  protected

  def parent
    if token_user?
      if current_token.domain_id != params[:domain_id]
        raise AuthToken::Denied
      end
      current_token.domain
    else
      Domain.user( current_user ).find( params[:domain_id] )
    end
  end

  def collection
    parent.records
  end

  def resource
    collection.find( params[:id] )
  end

  def restrict_token_movements
    return true unless current_token

    render :text => t(:message_token_not_authorized), :status => 403
    return false
  end
  
  private
  
  def records_params
    params.require(:record).permit(:type, :name, :prio, :primary_ns, :contact, :refresh, :retry, :expire, :minimum, :shortname, :ttl, :content, :domain, :id)
  end

  def soa_params
    params.require(:soa).permit(:primary_ns, :contact, :refresh, :retry, :expire, :minimum)
  end

  def build_resource_params
    [params.fetch(:record, {}).permit(:type, :name, :prio, :primary_ns, :contact, :refresh, :retry, :expire, :minimum, :shortname, :ttl, :content, :domain, :id)]
  end

end
