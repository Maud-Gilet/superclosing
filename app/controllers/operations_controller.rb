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

  private

  def operation_params
    params.require(:operation).permit(:name, :category, :target_amount_cents, :expected_closing_date)
  end
end
