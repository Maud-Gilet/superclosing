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
    if @d_document.document_type == 'subscription_bunds'
      @user = User.find(params[:user_id])
    end
    @operation = @d_document.operation

    @capital_augmentation = capital_augmentation
    @total_of_shares = total_of_shares_number
    @nominal = @operation.company.share_nominal_value_cents / 100

    @total_of_investments = total_of_investments
    @emit_prime = (@total_of_investments / @total_of_shares) - @nominal
    @global_price = @nominal + @emit_prime

    render pdf: "file_nam", layout: "document", formats: :html, encoding: 'utf8'
  end

  def capital_augmentation
    array = []
    @operation.investments.each do |investment|
      array << investment.share_premium_cents
    end
    @capital_augmentation = (array.sum) / 10
  end


  def total_of_shares_number
    array_of_shares = []

    @operation.investments.each do |investment|
      array_of_shares << investment.number_of_shares
    end
    @total_of_shares = array_of_shares.sum
  end

  def total_of_investments
    array_of_shares = []

    @operation.investments.each do |investment|
      array_of_shares << investment.share_premium_cents
    end
    @total_of_investments = (array_of_shares.sum )/ 10
  end

  def create_documents
    @operation = Operation.find(params[:id])
    DDocument.destroy_all

    @d_document = DDocument.new(title: "PV d'Assemblée Générale de #{@operation.company.name}", document_type: 'pv_closing', operation: @operation)
    @d_document.save!

    @d_document = DDocument.new(title: "PV de sortie", document_type: 'pv_closing', operation: @operation)
    @d_document.save!

    @operation.investments.each do |investment|
      @user = investment.user
      @d_document = DDocument.new(title: "Bon de souscription / #{investment.user.last_name} ", document_type: 'subscription_bund', operation: @operation, user: @user)
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
end
