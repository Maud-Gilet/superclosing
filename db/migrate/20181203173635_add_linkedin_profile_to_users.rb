class AddLinkedinProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :linkedin_profile, :string
  end
end
