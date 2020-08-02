class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.boolean :status
      t.timestamps
    end
    add_index :categories, :title,                unique: true
    add_index :categories, :slug,                unique: true
  end
end