module Refinery
  class PagesController < ::ApplicationController
    include Pages::RenderOptions
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper

    before_action :find_page, :set_canonical, except:[:create]
    before_action :error_404, :unless => :current_user_can_view_page?

    # Save whole Page after delivery
    after_action :write_cache?

    # This action is usually accessed with the root path, normally '/'
    def home
      render_with_templates?
    end

    def create
      @contact = Contact.new(params[:contact])
      @page = Refinery::Page.friendly.find_by_view_template('contact')
   
      @contact.request = request
      if @contact.deliver
        flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      else
        flash.now[:error] = 'Cannot send message.'
        render_with_templates?
      end
    end

    # This action can be accessed normally, or as nested pages.
    # Assuming a page named "mission" that is a child of "about",
    # you can access the pages with the following URLs:
    #
    #   GET /pages/about
    #   GET /about
    #
    #   GET /pages/mission
    #   GET /about/mission
    #
    def show
      if should_skip_to_first_child?
        redirect_to refinery.url_for(first_live_child.url) and return
      elsif page.link_url.present?
        redirect_to page.link_url and return
      elsif should_redirect_to_friendly_url?
        redirect_to refinery.url_for(page.url), :status => 301 and return
      end

      render_with_templates?
    end

  protected

    def requested_friendly_id
      if ::Refinery::Pages.scope_slug_by_parent
        # Pick out last path component, or id if present
        "#{params[:path]}/#{params[:id]}".split('/').last
      else
        # Remove leading and trailing slashes in path, but leave internal
        # ones for global slug scoping
        params[:path].to_s.gsub(%r{\A/+}, '').presence || params[:id]
      end
    end

    def should_skip_to_first_child?
      page.skip_to_first_child && first_live_child
    end

    def should_redirect_to_friendly_url?
      requested_friendly_id != page.friendly_id || (
        ::Refinery::Pages.scope_slug_by_parent &&
        params[:path].present? && params[:path].match(page.root.slug).nil?
      )
    end

    def current_user_can_view_page?
      page.live? || authorisation_manager.allow?(:plugin, "refinery_pages")
    end

    def first_live_child
      page.children.order('lft ASC').live.first
    end

    def find_page(fallback_to_404 = true)
      content_el = "body"
      @page ||= case action_name
                when "home"
                  content_el = "box1"
                  Refinery::Page.find_by(link_url: '/')
                when "show"
                  page = Refinery::Page.friendly.find_by_path_or_id(params[:path], params[:id])
                  if page.view_template == 'contact'
                    @contact = Contact.new
                  end
                  page
                end
        if @page.present?
          title = @page.title
          
          description = truncate(strip_tags(@page.content_for(content_el)), {
             :length => 200
            })
          image = "#{ActionController::Base.helpers.asset_path('imgs/mali_logo.png')}"

          image  = "#{Rails.application.config.fabrika_url}#{@page.images.first.try(:thumbnail, geometry: "1200x630#c").try(:url)}" if @page.images.first.present?

          defaults = {
            title: title,
            image: image,
            description: description,
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
              type: 'website'
            }
          }

        set_meta_tags defaults
      end
      @page || (error_404 if fallback_to_404)
    end

    alias_method :page, :find_page

    def set_canonical
      @canonical = refinery.url_for @page.canonical if @page.present?
    end

    def write_cache?
      # Don't cache the page with the site bar showing.
      if Refinery::Pages.cache_pages_full && !authorisation_manager.allow?(:read, :site_bar)
        cache_page(response.body, File.join('', 'refinery', 'cache', 'pages', request.path).to_s)
      end
    end
  end
end
