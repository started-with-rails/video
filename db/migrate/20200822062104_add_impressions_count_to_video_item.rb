class AddImpressionsCountToVideoItem < ActiveRecord::Migration[6.0]
  def change
    add_column :video_items, :impressions_count, :int, default: 0
  end
end
