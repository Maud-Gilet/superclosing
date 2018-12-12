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
    @price_per_share_operation = (@operation.premoney / @company.number_of_shares.to_i).round(2)
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

      refresh_values_for_ajax

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

  def refresh_values_for_ajax
    @shares_values = 0
    @operation.investments.each do |invest|
      @shares_values += invest.number_of_shares * (@operation.company.share_nominal_value + invest.share_premium)
    end
    @s_document = SDocument.new
    @d_document = DDocument.new

    ## Historic shareholders
    investments = Investment.joins(operation: :company).where('companies.id = ? AND operations.status = ?', @operation.company.id, 'completed')
    @shareholders = {}
    investments.each do |invest|
      if @shareholders.key?(invest.user_id)
        @shareholders[invest.user_id] += invest.number_of_shares
      else
        @shareholders[invest.user_id] = invest.number_of_shares
      end
    end
    ## New shareholders
    if @operation.status != 'completed'
      new_investments = Investment.joins(:operation).where("operations.id = 5 AND (investments.status = 'confirmed' OR investments.status = 'pending')")
      new_investments.each do |invest|
        if @shareholders.key?(invest.user_id)
          @shareholders[invest.user_id] += invest.number_of_shares
        else
          @shareholders[invest.user_id] = invest.number_of_shares
        end
      end
    end
    ## Sort hash by number_of_shares
    @shareholders = @shareholders.transform_keys{ |key| "#{User.find(key).last_name} #{User.find(key).first_name}" }.sort_by { |_k, v| v }.reverse.to_h
  end
end
