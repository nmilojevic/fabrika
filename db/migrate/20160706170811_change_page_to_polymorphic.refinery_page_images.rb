# This migration comes from refinery_page_images (originally 20110527052435)
class ChangePageToPolymorphic < ActiveRecord::Migration[4.2]
  def change
    add_column Refinery::ImagePage.table_name, :page_type, :string, :default => "page"
  end
end
