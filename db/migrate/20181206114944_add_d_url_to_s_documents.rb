class AddDUrlToSDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :s_documents, :d_url, :string
  end
end
