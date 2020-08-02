class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :slug
      t.boolean :allow_download
      t.boolean :auto_play
      t.string :excerpt
      t.string :description
      t.string :resource_type
      t.text :embed_code
      t.string :resource_url
      t.integer :user_id
      t.boolean :status
      t.boolean :featured
      t.timestamps
    end
    add_index :resources, :user_id
    add_index :resources, :slug, unique: true
  end
end
