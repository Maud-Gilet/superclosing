class AddBirthPlaceToUsers < ActiveRecord::Migration[5.2]
  def change
     add_column :users, :birth_place, :string
  end
end
