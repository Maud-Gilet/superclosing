class CaptablesController < ApplicationController
  before_action :set_company, only: [:show, :new, :create]

  def show
    @investments = Investment.joins(operation: :company).where('companies.name = ? AND operations.status = ?', @company.name, 'completed')
    @captable = {}
    @investments.each do |invest|
      if @captable.key?(invest.user_id)
        @captable[invest.user_id] = number_of_shares
      else
        @captable[invest.user_id] += number_of_shares
      end
    end
  end

  def new
  end

  def create
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
      format.js  # <-- will render `app/views/captable/create.js.erb`
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
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
