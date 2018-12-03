class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.references :company, foreign_key: true
      t.string :category
      t.monetize :target_amount
      t.date :expected_closing_date
      t.string :status
      t.monetize :premoney

      t.timestamps
    end
  end
end
