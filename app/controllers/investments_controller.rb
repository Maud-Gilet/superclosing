class InvestmentsController < ApplicationController
  before_action :set_investment, only: [:show, :edit, :update, :destroy, :confirm_invest]

  def index
    @operation = Operation.find(params[:operation_id])
    @investments = investment.where(operation: @operation)
  end

  def show
    @investment = Investment.find(params[:id])
  end

  def new
    @investment = Investment.new
  end

  def create
    @investment = Investment.new(investment_params)
    @investment.operation = Operation.find(params[:operation_id])
    # @investment.user = current_user
    @investment.status = "pending"
    if @investment.save!
      redirect_to company_investment_path(params[:company_id], @investment.id)
    else
      render :new
    end
  end

  def edit
  end

  def confirm_invest
    @investment.update(status: 'confirmed')
    redirect_to root_path, notice: 'Votre investissement est confirmé!'
  end

  def update
    set_new_status

    set_new_amount

    if @investment.update(@changes)
      redirect_to investment_path(@investment), notice: 'Votre investissement a bien été mis à jour.'
    else
      render :edit
    end
  end

  def destroy
    # Protection for Operations with 'Completed' status
    @investment.destroy if @investment.operation.status != 'completed' || @investment.operation.category == 'initialize-captable'

    refresh_values_for_ajax
  end

  private

  def set_investment
    @investment = Investment.find(params[:id])
  end

  def investment_params
    params.require(:operation).permit(:number_of_shares,
                                      :share_premium,
                                      :share_premium_currency,
                                      :share_nominal_value,
                                      :status,
                                      :user_id,
                                      :operation_id)
  end

  def set_new_status
    if params[:investment][:status] == "Non confirmé"
      @changes = { status: "pending" }
    elsif params[:investment][:status] == "Confirmé"
      @changes = { status: "confirmed" }
    elsif params[:investment][:status] == "Refusé"
      @changes = { status: "refused" }
    end
  end

  def set_new_amount
    number_of_shares = (params[:amount].to_i / (@investment.share_premium.to_f + @investment.share_nominal_value.to_f)).round(0)
    @changes[:number_of_shares] = number_of_shares
  end

  def refresh_values_for_ajax
    @operation = @investment.operation

    # Defines the total amount of the operation (progression chart)
    ## Confirmed + Invited
    @shares_values = 0
    @price_per_share_operation = 0
    investments_unconfirmed = Investment.joins(:operation).where("operations.id = ? AND (investments.status = 'confirmed' OR investments.status = 'pending')", @operation.id)
    investments_unconfirmed.each do |invest|
      @price_per_share_operation = (invest.share_nominal_value + invest.share_premium)
      @shares_values += (invest.number_of_shares * @price_per_share_operation)
    end

    @shares_values_confirmed = 0
    investments_confirmed = Investment.joins(:operation).where("operations.id = ? AND investments.status = 'confirmed'", @operation.id)
    investments_confirmed.each do |invest|
      @shares_values_confirmed += (invest.number_of_shares * @price_per_share_operation)
    end

    @s_document = SDocument.new
    @d_document = DDocument.new

   ## Historic shareholders
    investments = Investment.joins(operation: :company).where("companies.id = ? AND operations.status = 'completed'", @operation.company.id)
    @shareholders = {}
    @total_number_of_shares_company = 0
    investments.each do |invest|
      if @shareholders.key?(invest.user_id)
        @shareholders[invest.user_id] += invest.number_of_shares
      else
        @shareholders[invest.user_id] = invest.number_of_shares
      end
      @total_number_of_shares_company += invest.number_of_shares
    end
    ## New shareholders
    new_investments = Investment.joins(:operation).where("operations.id = ? AND (investments.status = 'confirmed' OR investments.status = 'pending')", @operation.id)
    if @operation.status != 'completed'
      new_investments.each do |invest|
        if @shareholders.key?(invest.user_id)
          @shareholders[invest.user_id] += invest.number_of_shares
        else
          @shareholders[invest.user_id] = invest.number_of_shares
        end
        @total_number_of_shares_company += invest.number_of_shares
      end
    end
    ## Sort hash by number_of_shares
    @shareholders = @shareholders.transform_keys{ |key| "#{User.find(key).last_name} #{User.find(key).first_name}" }.sort_by { |_k, v| v }.reverse.to_h

    @shareholders_with_pourcent = @shareholders.map { |k, value| [k, "#{k} - #{(value.to_f / @total_number_of_shares_company.to_f * 100).round(0)}%"] }.to_h

    # Totals from the operation
    @total_number_of_shares_operation = 0
    new_investments.each do |invest|
      @total_number_of_shares_operation += invest.number_of_shares
    end
  end
end
