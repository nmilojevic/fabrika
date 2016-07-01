module RestrictRefineryToRefineryUsers

  def restrict_refinery_to_refinery_users
    return if current_user && current_user.admin?
    redirect_to main_app.root_path #this user is not a refinery user because they have no refinery roles.
    return false
  end

end