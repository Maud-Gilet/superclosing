class CompaniesController < ApplicationController
  before_action :set_company, only: [:show]

  def index
    @companies = Company.all
  end

  def show
    display_captable
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      Role.create(user: current_user, company_id: @company.id, category: params[:role])
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
    @company.share_nominal_value = params[:share_nominal_value]
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
    params.require(:company).permit(:name, :address, :siren, :legal_form, :number_of_shares, :logo_url, :share_nominal_value, :share_nominal_value_currency, :creation_date, :fiscal_date)
  end

  def display_captable
    @investments = Investment.joins(operation: :company).where('companies.id = ? AND operations.status = ?', @company.id, 'completed')
    @shareholders = {}
    @company.number_of_shares = 0
    @investments.each do |invest|
      if @shareholders.key?(invest.user_id)
        @shareholders[invest.user_id] += invest.number_of_shares
      else
        @shareholders[invest.user_id] = invest.number_of_shares
      end
      @company.number_of_shares += invest.number_of_shares
      @company.save
    end

    # Sort hash by number_of_shares
    @shareholders = @shareholders.transform_keys{ |key| "#{User.find(key).last_name} #{User.find(key).first_name}" }.sort_by { |_k, v| v }.reverse.to_h
  end
end
