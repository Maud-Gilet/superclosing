class CompaniesController < ApplicationController

  def show
    @company = company.current_user
  end
end
