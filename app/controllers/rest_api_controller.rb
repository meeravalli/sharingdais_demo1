class RestApiController < ApplicationController

  def provider_food_login
  	render :json => {:status => "Thank you for rating"}
  end

  def provider_book_login
  end

  def provider_skill_login
  end
=begin  
  def provider_ride_login
  end
=end
  def provider_food_new_user
  end

  def provider_book_new_user
  end

  def provider_skill_new_user
  end
=begin
  def provider_ride_new_user
  end
=end
 
  def seeker_food_login
  end

  def seeker_book_login
  end

  def seeker_skill_login
  end
=begin  
  def seeker_ride_login
  end
=end
  def seeker_food_new_user
  end

  def seeker_book_new_user
  end

  def seeker_skill_new_user
  end
=begin  
  def seeker_ride_new_user
  end
=end
end
