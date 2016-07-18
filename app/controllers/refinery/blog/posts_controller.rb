module Refinery
  module Blog
    class PostsController < BlogController
      include Refinery::Blog::PostsHelper
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::SanitizeHelper
      before_filter :find_all_blog_posts, :except => [:archive]
      before_filter :find_blog_post, :only => [:show, :comment, :update_nav]
      before_filter :find_tags
      respond_to :html, :js, :rss
 
      def index
        prepare_meta_tags title: "Factory Blog"

        if request.format.rss?
          @posts = if params["max_results"].present?
            # limit rss feed for services (like feedburner) who have max size
            Post.recent(params["max_results"])
          else
            Post.newest_first.live.includes(:comments, :categories)
          end
        end
        respond_with (@posts) do |format|
          format.html
          format.rss { render :layout => false }
        end
      end

      def show
        prepare_meta_tags title: "Factory Blog: #{@post.title}"
        @comment = Comment.new

        @canonical = refinery.url_for(:locale => Refinery::I18n.current_frontend_locale) if canonical?

        @post.increment!(:access_count, 1)
        title = @post.title
        description = ''
        if @post.respond_to?(:custom_teaser) && @post.custom_teaser.present?
         description = strip_tags(@post.custom_teaser.html_safe)
        else
         description = truncate(strip_tags(@post.body.html_safe), {
           :length => Refinery::Blog.post_teaser_length
          })
        end
        image = "#{ActionController::Base.helpers.asset_path('imgs/mali_logo.png')}"
        image = "#{Rails.application.config.fabrika_url}#{@post.image.try(:thumbnail, geometry: "1200x630#c").try(:url)}" if @post.image.present?

        defaults = {
          title: title,
          image: image,
          author: "#{@post.author.try(:username)}",
          description: description,
          article:{
            author: "#{@post.author.try(:username)}",
          },
          twitter: {
            site: '@fabrika_018',
            card: 'summary',
            description: description,
            image: image
          },
          og: {
            title: title,
            image: image,
            description: description,
            author: "#{@post.author.try(:username)}",
            type: 'website'
          }
        }

        set_meta_tags defaults

        respond_with (@post) do |format|
          format.html { present(@post) }
          format.js { render :partial => 'post', :layout => false }
        end
      end

      def comment
        @comment = @post.comments.create(comment_params)
        if @comment.valid?
          if Comment::Moderation.enabled? or @comment.ham?
            begin
              CommentMailer.notification(@comment, request).deliver_now
            rescue
              logger.warn "There was an error delivering a blog comment notification.\n#{$!}\n"
            end
          end

          if Comment::Moderation.enabled?
            flash[:notice] = t('thank_you_moderated', :scope => 'refinery.blog.posts.comments')
            redirect_to refinery.blog_post_url(params[:id])
          else
            flash[:notice] = t('thank_you', :scope => 'refinery.blog.posts.comments')
            redirect_to refinery.blog_post_url(params[:id],
                                      :anchor => "comment-#{@comment.to_param}")
          end
        else
          render :show
        end
      end

      def archive
        if params[:month].present?
          date = "#{params[:month]}/#{params[:year]}"
          archive_date = Time.parse(date)
          @date_title = ::I18n.l(archive_date, :format => '%B %Y')
          @posts = Post.live.by_month(archive_date).page(params[:page])
        else
          date = "01/#{params[:year]}"
          archive_date = Time.parse(date)
          @date_title = ::I18n.l(archive_date, :format => '%Y')
          @posts = Post.live.by_year(archive_date).page(params[:page])
        end
        respond_with (@posts)
      end

      def tagged
        @tag = ActsAsTaggableOn::Tag.find(params[:tag_id])
        @tag_name = @tag.name
        @posts = Post.live.newest_first.uniq.tagged_with(@tag_name).page(params[:page])
      end

    private

      def comment_params
        params.require(:comment).permit(:name, :email, :message)
      end

    protected
      def canonical?
        Refinery::I18n.default_frontend_locale != Refinery::I18n.current_frontend_locale
      end
    end
  end
end
