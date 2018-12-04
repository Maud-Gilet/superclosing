class SDocumentsController < ApplicationController
  before_action :set_s_document, only: [:show, :edit, :update]

  def index
    @operation = Operation.find(params[:operation_id])
    @s_documents = SDocument.all.where(operation: @operation)
  end

  def show
  end

  def new
    @s_document = SDocument.new
  end

  def create
    @s_document = SDocument.new(s_document_params)
    @s_document.operation = Operation.find(params[:operation_id])

    if @s_document.save
      redirect_to current_user_dashboard_path, notice: 'Votre template a bien été créé.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @s_document.update(s_document_params)
    if @s_document.update(s_document_params)
      redirect_to current_user_dashboard_path, notice: 'Votre template a bien été mis à jour.'
    else
      render :edit
    end
  end

  private

  def set_s_documents
    @s_document = SDocument.find(params[:id])
  end

  def s_document_params
    params.require(:s_document).permit(:title, :category, :date, :operation_id)
  end
end
