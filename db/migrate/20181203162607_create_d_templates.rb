class CreateDTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :d_templates do |t|
      t.string :category
      t.string :version

      t.timestamps
    end
  end
end
