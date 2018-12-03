class CreateInvestments < ActiveRecord::Migration[5.2]
  def change
    create_table :investments do |t|
      t.references :user, foreign_key: true
      t.references :operation, foreign_key: true
      t.integer :number_of_shares
      t.monetize :share_premium
      t.string :status

      t.timestamps
    end
  end
end
