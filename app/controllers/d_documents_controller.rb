class DDocumentsController < ApplicationController
  before_action :set_d_document, only: [:show]

  def index
    @operation = Operation.find(params[:operation_id])
    @d_documents = @operation.d_documents
  end

  def show
    @d_document = DDocument.find(params[:id])
    render pdf: "file_name", layout: "document"
  end

  def show_souscription
    @d_document = DDocument.find(params[:id])
    render pdf: "file_name",
          layout: "document"  # Excluding ".pdf" extension.
  end

  def create_documents
    @operation = Operation.find(params[:id])
    @d_document = DDocument.new(title: "Mon titre", operation: @operation, d_template: DTemplate.first)
    @d_document.save!

    redirect_to operation_d_documents_path(@operation)
  end

  def create
  end

  private

  def set_d_document
    @d_document = DDocument.find(params[:id])
  end
end
