class RolesController < ApplicationController

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    @role.save

    redirect_to company_path(company)
  end

  private

  def role_params
    params.require(:role).permit(:category, :user_id, :company_id)
  end

end
