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

    if @operation.save!
      redirect_to operation_path(@operation)
    else
      render :new
    end
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

    if @user = User.find_by(email: @email)

      create_role_investor unless user_role_exist?

    # Edit a mail to the Investor
    else
      @user = User.invite!(email: @email)
      create_role_investor
    end
    if investment_exist?
      redirect_to operation_path(@operation), alert: 'Cet investisseur a déjà été ajouté à cette opération'
    else
      create_investment
      redirect_to operation_path(@operation)
    end
  end

  private

  def operation_params
    params.require(:operation).permit(:name, :category, :target_amount_cents, :expected_closing_date)
  end

  def investor_params
    params.require(:operation).permit(:name, :category, :target_amount_cents, :expected_closing_date)
  end

  def user_role_exist?
    !@user.roles.where(category: 'Investisseur', company: @company).empty?
  end

  def create_role_investor
    Role.create!( user: @user,
                  company: @company,
                  category: 'Investisseur')
  end

  def create_investment
    Investment.create!( user: @user,
                        operation: @operation,
                        share_premium_cents: @share_premium_cents,
                        number_of_shares: @number_of_shares,
                        status: 'pending')
  end

  def investment_exist?
    !@operation.investments.where(user: @user).empty?
  end
end
