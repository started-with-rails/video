class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.belongs_to :category, index: true
      t.belongs_to :resource, index: true
      t.timestamps
    end
  end
end
