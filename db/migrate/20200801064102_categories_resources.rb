class CategoriesResources < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_resources, id: false do |t|
      t.belongs_to :category
      t.belongs_to :resource
    end
    add_index :categories_resources, [:category_id, :resource_id]
  end
end
