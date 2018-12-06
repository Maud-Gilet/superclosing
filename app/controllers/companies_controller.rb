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
  
  def new_captable
    @company = Company.find(params[:company_id])
  end

  def create_captable
    @company = Company.find(params[:company_id])
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @category = params[:category]
    @number_of_shares = params[:number_of_shares]

    check_user

    create_initialize_captable_operation unless initialize_captable_operation_exist?

    create_user_investment unless user_investment_operation_exist?

    respond_to do |format|
      format.html { render :new_captable }
      format.js  # <-- will render `app/views/companies/create_captable.js.erb`
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

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address, :siren, :legal_form, :number_of_shares, :logo_url, :share_nominal_value_cents, :share_nominal_value_currency, :creation_date, :fiscal_date)
  end

  def user_role_exist?
    !@user.roles.where(category: @category, company: @company).empty?
  end

  def create_role
    Role.create!( user: @user,
                  company: @company,
                  category: @category)
  end

  def check_user
    if @user = User.find_by(email: @email)

      create_role unless user_role_exist?
    else
      @user = User.invite!(email: @email)
      @user.update(first_name: @first_name, last_name: @last_name)
      create_role
    end
  end

  def user_investment_operation_exist?
    @operation = @company.operations.where(category: 'initialize-captable').first
    !@operation.investments.where(user: @user).empty?
  end

  def create_user_investment
    @operation = @company.operations.where(category: 'initialize-captable').first
    Investment.create!( user: @user,
                        operation: @operation,
                        share_premium_cents: 0,
                        number_of_shares: @number_of_shares,
                        status: 'completed')
  end

  def initialize_captable_operation_exist?
    !@company.operations.where(category: 'initialize-captable').empty?
  end

  def create_initialize_captable_operation
    Operation.create!(company: @company,
                      category: 'initialize-captable',
                      status: 'initialize',
                      name: 'Initialisation de la table de capitalisation')
  end
end
