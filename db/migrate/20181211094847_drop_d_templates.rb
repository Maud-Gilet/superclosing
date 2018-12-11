class DropDTemplates < ActiveRecord::Migration[5.2]
  def change
    drop_table :d_templates
  end
end
