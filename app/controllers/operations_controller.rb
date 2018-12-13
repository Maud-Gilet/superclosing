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

    variables_for_charts
  end

  private

  def operation_params
    params.require(:operation).permit(:name, :category, :target_amount, :expected_closing_date, :premoney)
  end

  def investor_params
    params.require(:operation).permit(:name, :category, :target_amount, :expected_closing_date)
  end

  def variables_for_charts
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

    # Defines the list of shareholders (dynamic captable with current investments of the operation)
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

    @shareholders_with_pourcent = @shareholders.map { |k, value| [k, "#{k} - #{(value.to_f / @total_number_of_shares_company.to_f * 100).to_i}%"] }.to_h

    # Totals from the operation
    @total_number_of_shares_operation = 0
    new_investments.each do |invest|
      @total_number_of_shares_operation += invest.number_of_shares
    end
  end
end
