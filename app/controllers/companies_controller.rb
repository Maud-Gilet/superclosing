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
      redirect_to company_path(@company), notice: 'Complétez les informations de votre société !'
    else
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to company_path(@company), notice: 'Les modifications ont bien été prises en compte'
    else
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :address, :siren, :legal_form, :number_of_shares, :logo_url, :share_nominal_value_cents, :share_nominal_value_currency, :creation_date, :fiscal_date)
  end
end
