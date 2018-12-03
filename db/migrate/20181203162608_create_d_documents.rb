class CreateDDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :d_documents do |t|
      t.references :operation, foreign_key: true
      t.references :d_template, foreign_key: true
      t.string :title
      t.date :date
      t.string :status

      t.timestamps
    end
  end
end
