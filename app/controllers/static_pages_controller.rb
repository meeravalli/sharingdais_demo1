class StaticPagesController < ApplicationController
	
	def aboutus
	  @title = "Sharingdais connecting neighbourhood"
	end
	
	def ourteam
	end
	
	def legal_terms
	end
	
	def hygiene_factor
	end
	
	def benefits
	end

	def digital_market
	  render :layout => false
	end

	def choc_cake
	  render :layout => false
	end

	def home_food
	  render :layout => false
	end

	def ecomm_shop
	  render :layout => false
	end

	def marketing_stratgy
	  render :layout => false
	end
   
	
end