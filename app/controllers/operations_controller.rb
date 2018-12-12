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
    @operation.status = "pending"

    if @operation.save!
      redirect_to operation_path(@operation)
    else
      render :new
    end
  end

  def show
    @operation = Operation.find(params[:id])
    @s_document = SDocument.new
    @d_document = DDocument.new

    @shares_values = 0
    @operation.investments.each do |invest|
      @shares_values += invest.number_of_shares * (@operation.company.share_nominal_value + invest.share_premium)
    end
  end

  private

  def operation_params
    params.require(:operation).permit(:name, :category, :target_amount, :expected_closing_date, :premoney)
  end

  def investor_params
    params.require(:operation).permit(:name, :category, :target_amount, :expected_closing_date)
  end
end
