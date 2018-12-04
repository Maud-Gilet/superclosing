class DDocumentsController < ApplicationController
  before_action :set_d_document, only: [:show]

  def index
    @operation = Operation.find(params[:operation_id])
    @d_documents = DDocument.where(operation: @operation)
  end

  def show
    @d_document = DDocument.find(params[:id])
  end

  private

  def set_d_document
    @d_document = DDocument.find(params[:id])
  end
end
