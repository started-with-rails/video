class CreateVideoItems < ActiveRecord::Migration[6.0]
  def change
    create_table :video_items do |t|
      t.string :title
      t.string :slug
      t.boolean :allow_download
      t.boolean :auto_play
      t.string :excerpt
      t.string :description
      t.string :video_type
      t.text :embed_code
      t.string :video_url
      t.integer :user_id
      t.boolean :status, :default => true
      t.boolean :featured, :default => true
      t.timestamps
    end
    add_index :video_items, :slug, unique: true
    add_index :video_items, :user_id
  end
end
