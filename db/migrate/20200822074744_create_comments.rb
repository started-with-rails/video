class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text    :content
      t.bigint  :commentable_id
      t.string  :commentable_type
      t.boolean :status, :default => true
      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
