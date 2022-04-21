class MacroStepsController < InheritedResources::Base

  belongs_to :macro
  respond_to :xml, :json, :js

  def create
    # Check for any previous macro steps
    position = if parent.macro_steps.any?
      # Check for the parameter
      unless macro_step_params[:position].blank?
        macro_step_params.delete(:position)
      else
        parent.macro_steps.size + 1
      end
    else
      1
    end

    @macro_step = parent.macro_steps.create( macro_step_params )

    @macro_step.insert_at( position.to_i ) if position && !@macro_step.new_record?

    parent.save
    @macro = parent

    respond_to do |format|
      format.js
    end
  end

  def update
    position = macro_step_params.delete(:position)

    @macro_step = parent.macro_steps.find( params[:id] )
    @macro_step.update_attributes( macro_step_params )

    @macro_step.insert_at( position.to_i ) if position

    @macro = parent

    respond_to do |wants|
      wants.js
    end
  end

  def destroy
    @macro_step = parent.macro_steps.find( params[:id] )
    @macro_step.destroy

    flash[:info] = t :message_macro_step_removed
    redirect_to macro_path( parent )
  end

  protected

  def parent
    Macro.user( current_user ).find( params[:macro_id] )
  end

  def collection
    parent.macro_steps
  end

  def resource
    collection.find( params[:id] )
  end
  
  private
  
  def macro_step_params
    params.require(:macro_step).permit(:macro_id, :position, :action, :record_type, :name, :ttl, :prio, :content)
  end

end
