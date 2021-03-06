class AuditsController < ApplicationController

  before_filter do
    unless current_user.admin?
      redirect_to root_url
    end
  end

  def index
    @audits = Audit.order("created_at desc").limit(50)
  end

  # Retrieve the audit details for a domain
  def domain
    @domain = Domain.user( current_user ).find( params[:id] )
  end

end
