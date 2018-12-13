class DDocumentsController < ApplicationController
  before_action :set_d_document, only: [:show]

  def index
    @operation = Operation.find(params[:operation_id])
    @subscription_bunds = @operation.d_documents.select do |d_d|
      d_d.title.include? "souscription"
    end
    @users = @operation.users

    @other_documents = @operation.d_documents.select do |d_d|
      !d_d.title.include?("souscription")
    end
  end

  def show
    @d_document = DDocument.find(params[:id])
    @operation = @d_document.operation
    if @d_document.document_type == 'subscription_bund'
      @user = User.find(params[:user_id])
      @user_investment = @user.investments.where(operation_id: @operation.id).last
      @pv_opening = DDocument.where(operation: @operation, document_type: "pv_opening")
    end

    @nominal = @operation.company.share_nominal_value
    @total_of_shares = total_of_shares_number
    @capital_augmentation = @total_of_shares * @nominal

    list_shareholders

    render pdf: "file_nam", layout: "document", formats: :html, encoding: 'utf8'
  end


  def total_of_shares_number
    array_of_shares = []

    @operation.investments.each do |investment|
      array_of_shares << investment.number_of_shares
    end
    @total_of_shares = array_of_shares.sum
  end

  def total_of_investments
    array_of_investments = []

    @operation.investments.each do |investment|
      array_of_shares << investment.share_premium
    end
    @total_of_investments = array_of_investments.sum
  end

  def create_documents
    @operation = Operation.find(params[:id])
    DDocument.destroy_all

    @d_document = DDocument.new(title: "PV d'Assemblée Générale de #{@operation.company.name}", document_type: 'pv_opening', operation: @operation, status: 'unsigned')
    @d_document.save!

    @pv_opening = DDocument.where(operation_id: @operation.id, document_type: "pv_opening")

    @d_document = DDocument.new(title: "PV de sortie", document_type: 'pv_closing', operation: @operation, status: 'unsigned')
    @d_document.save!

    @operation.investments.each do |investment|
      @user = investment.user
      @d_document = DDocument.new(title: "Bon de souscription / #{investment.user.last_name} #{investment.user.first_name} ", document_type: 'subscription_bund', operation: @operation, user: @user, status: 'unsigned')
      @d_document.save!
    end

    redirect_to operation_d_documents_path(@operation)
  end

  def create
  end

  private

  def set_d_document
    @d_document = DDocument.find(params[:id])
  end

  def list_shareholders
    @investments = Investment.joins(operation: :company).where('companies.id = ? AND operations.status = ?', @operation.company.id, 'completed')
    @shareholders = {}
    @operation.company.number_of_shares = 0
    @investments.each do |invest|
      if @shareholders.key?(invest.user_id)
        @shareholders[invest.user_id] += invest.number_of_shares
      else
        @shareholders[invest.user_id] = invest.number_of_shares
      end
      @operation.company.number_of_shares += invest.number_of_shares
    end
    @shareholders
  end
end
