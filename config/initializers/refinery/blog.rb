Refinery::Blog.configure do |config|
  # config.validate_source_url = false

   config.comments_per_page = 10

   config.posts_per_page = 2

  # config.post_teaser_length = 250

  config.share_this_key = "62a3bd80-4c61-4abf-966b-a59ae6305290"

  config.page_url = "/blog"

  # If you're grafting onto an existing app, change this to your User class
  Refinery::Blog.user_class = "User"
end