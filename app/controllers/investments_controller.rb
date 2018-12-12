class InvestmentsController < ApplicationController
  before_action :set_investment, only: [:show, :edit, :update, :destroy]

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
    @shares_values = 0
    @operation.investments.each do |invest|
      @shares_values += invest.number_of_shares * (@operation.company.share_nominal_value + invest.share_premium)
    end
    @s_document = SDocument.new
    @d_document = DDocument.new
  end
end
