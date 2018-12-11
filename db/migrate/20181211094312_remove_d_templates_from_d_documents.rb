class RemoveDTemplatesFromDDocuments < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :d_documents, :d_templates
  end
end
