class AddDocumentTypeToDDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :d_documents, :document_type, :string
  end
end
