class CreateSDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :s_documents do |t|
      t.references :operation, foreign_key: true
      t.string :title
      t.string :category
      t.date :date

      t.timestamps
    end
  end
end
