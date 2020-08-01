class CreateAppSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :app_settings do |t|
      t.string :title
      t.boolean :status
      t.text :value
      t.timestamps
    end
    add_index :app_settings, :title, unique: true
  end
end
