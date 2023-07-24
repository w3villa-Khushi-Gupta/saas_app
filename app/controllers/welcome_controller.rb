class WelcomeController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]

  def index
    if current_user
      @user = current_user
      @tenant = current_tenant
      @projects = Project.by_plan_and_tenant(@tenant.id)
      params[:tenant_id] = @tenant.id
    end
  end
end
