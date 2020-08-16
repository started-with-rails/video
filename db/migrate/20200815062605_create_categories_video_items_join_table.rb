class CreateCategoriesVideoItemsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_video_items, id: false do |t|
      t.bigint :category_id
      t.bigint :video_item_id
    end
    add_index :categories_video_items, [:category_id, :video_item_id], :unique => true
  end
end
