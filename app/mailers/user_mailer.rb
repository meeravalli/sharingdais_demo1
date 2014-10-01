class UserMailer < ActionMailer::Base
  default from: "admin@sharingdais.com"
    
  def new_order_for_provider(provider, message_id, seeker)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = provider
    @seeker = seeker
    @message = Message.find(message_id)
    mail(:to => @user.email, :subject => "Sharingdais.com | New Order" )
   end

   def new_book_order_for_provider(provider, message_id, seeker)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = provider
    @seeker = seeker
    @message = BookMessage.find(message_id)
    @location =Location.where("id=?",@message.location_id)
    mail(:to => @user.email, :subject => "Sharingdais.com | New Order" )
   end

  def address_info_seeker(seeker, seeker_message_id, provider)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = seeker
    @provider = provider
    @message = Message.find(seeker_message_id)
    p '**************'
    p @message
    mail(:to => seeker.email, :subject => "Sharingdais.com | Contact Information" )
 end

 def book_address_info_seeker(seeker, seeker_message_id, provider)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = seeker
    @provider = provider
    @message = BookMessage.find(seeker_message_id)
    p '**************'
    p @message
    mail(:to => seeker.email, :subject => "Sharingdais.com | Contact Information" )
 end

  def address_info_provider(provider, provider_message_id, seeker)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = provider
    @seeker = seeker
    @message = Message.find(provider_message_id)
    p '????????????*********'
    p @message
    mail(:to => provider.email, :subject => "Sharingdais.com | Contact Information" )
  end

  def book_address_info_provider(provider, provider_message_id, seeker)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = provider
    @seeker = seeker
    @message = BookMessage.find(provider_message_id)
    p '????????????*********'
    p @message
    mail(:to => provider.email, :subject => "Sharingdais.com | Contact Information" )
  end

  def mail_book_contact_info_provider(provider, contact_details, seeker)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = provider
    @seeker = seeker
    @message = contact_details.name
    p '????????????*********'
    p @message
    mail(:to => seeker.email, :subject => "Sharingdais.com | Contact Information" )
  end
  
  def mail_contact_info_provider(provider, contact_details, seeker)
    #@url = "http://www.sharingdais.com/main/messages"
    @url = "http://www.sharingdais.com/main/home/profile"
    @login_url = "http://sharingdais.com/users/sign_in"
    @user = provider
    @seeker = seeker
    @message = contact_details.name
    p '????????????*********'
    p @message
    mail(:to => seeker.email, :subject => "Sharingdais.com | Contact Information" )
  end

  def feed_email(data)
    @data = data
    @name = @data[:name]
    @email = @data[:email]
    @phon = @data[:phon]
    @message = @data[:message]
    mail(to: "support@sharingdais.com", :subject => 'Sharingdais.com | Feedback Mail')
    #mail(to: "rox.shahid@gmail.com", :subject => 'Feedback Mail')
  end
end