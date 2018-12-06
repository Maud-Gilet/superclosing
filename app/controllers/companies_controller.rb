class CompaniesController < ApplicationController
  before_action :set_company, only: [:show]

  def index
    @companies = Company.all
  end

  def show
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

  def create_nominal
    @company = Company.find(params[:company_id])
    @company.share_nominal_value_cents = params[:share_nominal_value_cents]
    @company.save

    respond_to do |format|
      format.html {
        render :new_captable,
        notice: "La valeur nominal de l'action a été fixée à #{@company.share_nominal_value_cents}"
      }
      format.js  # <-- will render `app/views/companies/create_nominal.js.erb`
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address, :siren, :legal_form, :number_of_shares, :logo_url, :share_nominal_value_cents, :share_nominal_value_currency, :creation_date, :fiscal_date)
  end
end
