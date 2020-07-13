class UsersDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= %w(User.name User.role User.status User.membership_updated_at User.created_at)
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= %w(User.email User.name User.role User.status)
  end

private

  def data
    records.map do |user|
      [
        "<div><div class='align-this'>#{ActionController::Base.helpers.image_tag(thumbnail(user), class: 'image', width: 32, height: 32)}"+
        "</div><div class='product-info align-this'>" + 
        "<strong>#{user.name}</strong><br><small>#{user.email}</small>" +
        "</div></div>".html_safe,
        view.render(:partial => "users/user", :formats => "html", :locals => { :user => user}),
        ActionController::Base.helpers.image_tag("imgs/#{user.status}.png", class: 'icon'),#I18n.t("users.status.#{user.status}"),
        view.render(:partial => "users/membership", :formats => "html", :locals => { :user => user}),
        (I18n.l user.created_at.to_date, format: :short),
        view.render(:partial => "users/links", :formats => "html", :locals => { :user => user})
      ]
    end
  end

  def thumbnail(user)
    if user.admin?
      'imgs/admin1.png'
    elsif user.coach?
      'imgs/coach.png'
    else
      'imgs/user.png'
    end
  end

  def get_raw_records
    filter_user_status = params["users-filter"]
    if filter_user_status.present?
      if %w(admin user coach).include?(filter_user_status)
        users = User.where(role: User.roles[filter_user_status])
      else 
        users = User.where(status: User.statuses[filter_user_status])
      end
    else 
      users = User.all
    end
    users
  end
  
  private 

    # ==== Insert 'presenter'-like methods below if necessary
end
