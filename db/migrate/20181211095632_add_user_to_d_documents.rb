class AddUserToDDocuments < ActiveRecord::Migration[5.2]
  def change
     add_reference :d_documents, :user, foreign_key: true
  end
end
