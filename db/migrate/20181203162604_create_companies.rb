class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :siren
      t.string :legal_form
      t.date :fiscal_date
      t.date :creation_date
      t.string :logo_url
      t.integer :number_of_shares
      t.monetize :share_nominal_value

      t.timestamps
    end
  end
end
