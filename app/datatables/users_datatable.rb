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
    p 'recordssize', records.size
    records.map do |user|
      [
        "#{user.name}<br><small>#{user.email}</small>".html_safe,
        view.render(:partial => "users/user", :formats => "html", :locals => { :user => user}),
        I18n.t("users.status.#{user.status}"),
        view.render(:partial => "users/membership", :formats => "html", :locals => { :user => user}),
        (I18n.l user.created_at.to_date),
        view.render(:partial => "users/links", :formats => "html", :locals => { :user => user})
      ]
    end
  end

  def get_raw_records
    filter_user_status = params["users-filter"]
    if filter_user_status.present?
      users = User.where(status: User.statuses[filter_user_status])
    else 
      users = User.all
    end
    users
  end
  
  private 

    # ==== Insert 'presenter'-like methods below if necessary
end
