class AddShareNominalValueToInvestments < ActiveRecord::Migration[5.2]
  def change
    add_monetize :investments, :share_nominal_value, amount: { null: false, default: 0 }
  end
end
