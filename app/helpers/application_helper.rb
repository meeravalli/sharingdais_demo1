module ApplicationHelper

  def agree_button
    if current_user
      "Your contact details will be shared. If the food provider accepts your request"
    else
      "You need to sign in or sign up before continuing."
    end
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def render_title
  return @title if defined?(@title)
  "Sharingdais an online platform for peer to peer sharing"
end

end