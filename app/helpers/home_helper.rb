module HomeHelper

  def negotiate(user_id, post_requirement_id)
       Negotiate.find_by_user_id_and_post_requirement_id(user_id, post_requirement_id)
  end

  def find_user(id)
     User.find(id)
  end

  def find_service
    Service.find_by_service_type('Food Sharing').service_type
  end

end
