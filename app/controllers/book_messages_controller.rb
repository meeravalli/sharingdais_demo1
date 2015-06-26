class BookMessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    location = Location.find(params[:location_id])
    @negotiate = BookNegotiate.create(:book_post_requirement_id => params[:book_post_requirement_id], :user_id => current_user.id, :nego_id => params[:user_id]).valid?
    if @negotiate
      message = BookMessage.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => params[:user_id], :book_post_requirement_id => params[:book_post_requirement_id], :location_id => params[:location_id], :read => false, :order_status => true, :accepted => false, :trashed => false)
      provider = User.find(params[:user_id])
      seeker = current_user
      UserMailer.new_book_order_for_provider(provider,message.id, seeker).deliver
      
      contact_details = User.find(params[:user_id])
      UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    render :json => @negotiate.to_json    
  end

  def read
    @message = BookMessage.find(params[:id])
    @message.update_attribute(:read, true)
  end

  def agree_share
    @message_posted_to = User.find(params[:user_id])    
    BookMessage.update(params[:id], :accepted => true)        
    @order = BookOrder.create(:user_id => params[:user_id], :order_date => Time.now, :provider_id => current_user.id, :book_post_requirement_id => params[:book_post_requirement_id])
    BookActivity.create(:user_id => @message_posted_to.id, :contact_id => current_user.id,:seeked_shared => true, :book_order_id => @order.id, :book_post_requirement_id => params[:book_post_requirement_id])
    BookActivity.create(:user_id => current_user.id, :contact_id => @message_posted_to.id, :seeked_shared => false, :book_order_id => @order.id, :book_post_requirement_id => params[:book_post_requirement_id])
    
    seeker_message = BookMessage.create(:subject => "Your order was confirmed", :content => "Order Confirmed: OrderID ##{@order.id}", :user_id => current_user.id, :posted_to => @message_posted_to.id, :book_post_requirement_id => params[:book_post_requirement_id], :read => false, :book_order_id => @order.id, :order_status => true, :accepted => false, :trashed => false)
    seeker = User.find(@message_posted_to.id)
    provider = current_user
    
    UserMailer.book_address_info_seeker(seeker, seeker_message.id, provider).deliver
    
    provider_message = BookMessage.create(:subject => "New order accepted",:content => "Order Accepted: Order ID ##{@order.id}", :user_id => @message_posted_to.id, :posted_to => current_user.id, :book_post_requirement_id => params[:book_post_requirement_id], :read => false, :book_order_id => @order.id, :order_status => true, :accepted => false, :trashed => false)
    provider = current_user
    seeker = User.find(@message_posted_to.id)
    UserMailer.book_address_info_provider(provider, provider_message.id, seeker).deliver
    redirect_to messages_path
  end

  def destroy
    @message = BookMessage.find(params[:id])
    if session[:message_action].eql?('trash')
      @message.destroy
    else
      @message.update_attribute(:trashed, true)
    end
    if session[:message_action].eql?('trash')
      redirect_to trash_messages_path
    elsif session[:message_action].eql?('sent')
      redirect_to sent_messages_path
    elsif session[:message_action].eql?('unread')
      redirect_to unread_messages_path
    elsif session[:message_action].eql?('index')
      redirect_to messages_path
    end        
  end

  def cancel
    @message_posted_to = User.find(params[:user_id])    
    @negotiate = BookNegotiate.find_by_user_id_and_book_post_requirement_id(params[:book_negotiate_id], params[:book_post_requirement_id])    
    if !@negotiate.nil?
      @negotiate.destroy
      BookOrderCancel.create(:book_order_id => params[:book_order_id], :cancel_date =>  Time.now)  
      BookMessage.create(:subject => "Order Cancellation", :content => "Order cancelled. The Order No. is ##{params[:book_order_id]}", :user_id => current_user.id, :posted_to => @message_posted_to.id, :read => false, :book_order_id => params[:book_order_id])
    end
    redirect_to profile_home_path
  end


end