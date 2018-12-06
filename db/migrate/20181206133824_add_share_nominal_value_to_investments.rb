class AddShareNominalValueToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_column :investments, :share_nominal_value, :monetize
  end
end
