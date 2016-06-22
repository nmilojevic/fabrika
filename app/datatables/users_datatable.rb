class UsersDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= %w(User.email User.role User.status User.created_at)
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= %w(User.email User.role User.status User.created_at)
  end

private

  def data
    records.map do |user|
      [
        user.email,
        view.render(:partial => "users/user", :formats => "html", :locals => { :user => user}),
        user.status,
        (I18n.l user.created_at),
        ''#view.render(:partial => "users/links", :formats => "html", :locals => { :user => user})
      ]
    end
  end

  def get_raw_records
    User.all
  end
  
  private 

    # ==== Insert 'presenter'-like methods below if necessary
end
