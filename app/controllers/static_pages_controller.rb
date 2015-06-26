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

	
   def veg_thali
   	 render :layout => false
   end
   
   def veg_biryani
   	 render :layout => false
   end
   def stuffed_parantha
   	 render :layout => false
   end
   def khadi_chawal
   	 render :layout => false
   end
   def bake
   	 render :layout => false
   end
   def photography
   	 render :layout => false
   end
   def yoga
   	 render :layout => false
   end
   def gmat_official_edition
   	 render :layout => false
   end
   def revolution_2020
   	 render :layout => false
   end
   def winning_way
   	 render :layout => false
   end
   def fifty_shades_grey
   	 render :layout => false
   end
   def event_management
       render :layout => false
   end
   def tax_consultant
       render :layout => false
   end
   def doctors_dentists
       render :layout => false
   end
   def beauty_baby_care
       render :layout => false
   end


	
end