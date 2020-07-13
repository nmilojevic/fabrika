# This migration comes from refinery_page_images (originally 20101014230042)
class AddCaptionToImagePages < ActiveRecord::Migration[4.2]
  def change
    add_column Refinery::ImagePage.table_name, :caption, :text
  end
end
