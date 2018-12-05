class InvestmentsController < ApplicationController
  before_action :set_investement, only: [:show, :edit, :update]

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
    @investment.status = "Pending"
    if @investment.save!
      redirect_to company_investment_path(params[:company_id], @investment.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @investment.update(investment_params)
    if @investment.update(investment_params)
      redirect_to current_user_dashboard_path, notice: 'Votre investissement a bien été mis à jour.'
    else
      render :edit
    end
  end

  private

  def set_investment
    @investment = Investment.find(params[:id])
  end

  def investment_params
    params.require(:operation).permit(:number_of_shares,
                                      :share_premium_cents,
                                      :share_premium_currency,
                                      :status,
                                      :user_id,
                                      :operation_id)
  end
end
