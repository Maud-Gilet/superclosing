class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      Role.create(user: current_user, company_id: @company.id, category: "Associe")

      redirect_to company_path(@company)
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :address, :siren, :legal_form, :number_of_shares, :logo_url, :share_nominal_value_cents, :share_nominal_value_currency, :creation_date, :fiscal_date)
  end
end
