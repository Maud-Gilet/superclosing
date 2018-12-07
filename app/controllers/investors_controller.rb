class InvestorsController < ApplicationController
  before_action :set_operation, only: [:index, :new]

  def index
    @company = @operation.company
  end

  def new
  end

  def create
    @operation = Operation.find(params[:operation_id])
    @company = @operation.company
    @email = params[:email]
    # Attention aux arrondis
    @price_per_share_operation = @operation.premoney / @company.number_of_shares
    @share_premium = @price_per_share_operation - @company.share_nominal_value

    @number_of_shares = (params[:amount].to_i / @price_per_share_operation.to_f).round(0)
    @final_amount = @number_of_shares * @price_per_share_operation

    if @user = User.find_by(email: @email)

      create_role_investor unless user_role_exist?

    # Edit a mail to the Investor
    else
      @user = User.invite!(email: @email)
      create_role_investor
    end
    if investment_exist?
      respond_to do |format|
        format.html { redirect_to operation_path(@operation), alert: 'Cet investisseur a déjà été ajouté à cette opération' }
        format.js # <-- will render `app/views/investors/create.js.erb`
      end
    else
      create_investment
      respond_to do |format|
        format.html { redirect_to operation_path(@operation), alert: 'Cet investisseur a été ajouté à cette opération' }
        format.js  # <-- will render `app/views/investors/create.js.erb`
      end
    end
  end

  private

  def set_operation
    @operation = Operation.find(params[:operation_id])
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
    @investment = Investment.create!( user: @user,
                        operation: @operation,
                        share_premium: @share_premium,
                        share_nominal_value: @company.share_nominal_value,
                        number_of_shares: @number_of_shares,
                        status: 'pending')
  end

  def investment_exist?
    !@operation.investments.where(user: @user).empty?
  end
end
