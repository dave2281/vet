module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!  
    before_action :authorize_admin
    
    def index
      @users = User.all
    end

    private

    def authorize_admin
      redirect_to(unauthenticated_root_path, alert: 'Access denied!') unless current_user&.admin?
    end
  end
end