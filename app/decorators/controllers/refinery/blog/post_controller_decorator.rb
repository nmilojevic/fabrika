Refinery::Blog::Admin::PostsController.class_eval do
  protected
  def post_params
    p "Slicicaaaa"*100
    params.require(:post).permit(:title, :body, :custom_teaser, :image_id, :tag_list, :draft, :published_at, :custom_url, :user_id, :browser_title, :meta_description, :source_url, :source_url_title, :category_ids => [])
  end
end