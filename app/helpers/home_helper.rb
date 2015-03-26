module HomeHelper

  def negotiate(user_id, post_requirement_id)
       Negotiate.find_by_user_id_and_post_requirement_id(user_id, post_requirement_id)
  end
  def negotiate_skill(user_id, skill_post_requirement_id)
       Negotiate.find_by_user_id_and_skill_post_requirement_id(user_id, skill_post_requirement_id)
  end

 def negotiate_ride(user_id, rider_post_requirement_id)
       Negotiate.find_by_user_id_and_rider_post_requirement_id(user_id, rider_post_requirement_id)
  end

  def negotiate_book(user_id, book_post_requirement_id)
       BookNegotiate.find_by_user_id_and_book_post_requirement_id(user_id, book_post_requirement_id)
  end
  def negotiate_peer(user_id, peer_service_post_requirement_id)
       PeerNegotiate.find_by_user_id_and_peer_service_post_requirement_id(user_id, peer_service_post_requirement_id)
  end

  def find_user(id)
     User.find(id)
  end

  def find_service
    Service.find_by_service_type('Food Sharing').service_type
  end

  def rate(rated_id, rated_no, post_requirement_id)
    Rate.where("rated_id=? AND rated_no=? AND post_requirement_id=?",rated_id, rated_no, post_requirement_id)
  end

  def rate_book(rated_id, rated_no, book_post_requirement_id)
    Rate.where("rated_id=? AND rated_no=? AND book_post_requirement_id=?",rated_id, rated_no, book_post_requirement_id)
  end
  def rate_peer(rated_id, rated_no, peer_service_post_requirement_id)
    Rate.where("rated_id=? AND rated_no=? AND peer_service_post_requirement_id=?",rated_id, rated_no, peer_service_post_requirement_id)
  end

end
