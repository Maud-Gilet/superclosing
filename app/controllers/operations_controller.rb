class OperationsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @operations = Operation.where(company: @company)
  end

  def new
    @company = Company.find(params[:company_id])
    @operation = Operation.new
  end

  def create
    @operation = Operation.new(operation_params)
    @operation.company = Company.find(params[:company_id])
    @operation.status = "Pending"
    @operation.save!
    redirect_to operation_path(@operation)
  end

  def show
    @operation = Operation.find(params[:id])
  end

  def new_investor
    @operation = Operation.find(params[:operation_id])
  end

  def create_investor
    @operation = Operation.find(params["/new_investor"][:operation_id])
    @company = @operation.company
    @email = params["/new_investor"][:email]

    # Attention aux arrondis
    @price_per_share_operation = @operation.premoney_cents / @company.number_of_shares
    @share_premium_cents = @price_per_share_operation - @company.share_nominal_value_cents

    @number_of_shares = (params["/new_investor"][:amount].to_i / @price_per_share_operation).round(0)
    @final_amount = @number_of_shares * @price_per_share_operation

    if user_exist?
      @user = User.where(email: @email).first

      create_role_investor if user_role_exist? == false
      create_investment

      # Edit a mail to the Investor
    else
      render :new_investor
    end
  end

  private

  def operation_params
    params.require(:operation).permit(:name, :category, :target_amount_cents, :expected_closing_date)
  end

  def investor_params
    params.require(:operation).permit(:name, :category, :target_amount_cents, :expected_closing_date)
  end

  def user_exist?
    User.where(email: @email).length != 0
  end

  def user_role_exist?
    @user.roles.each do |role|
      return true if role[:category] == 'Investisseur' && role[:company_id] == @company
    end
  end

  def create_role_investor
    Role.create(user_id: @user,
                company_id: @company,
                category: 'Investisseur')
  end

  def create_investment
    Investment.create(user_id: @user,
                      operation_id: @operation,
                      share_premium_cents: @share_premium_cents,
                      number_of_shares: @number_of_shares,
                      status: 'pending')
  end
end
