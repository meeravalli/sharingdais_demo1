class MessagesController < ApplicationController
before_filter :authenticate_user!

  def index
    @messages = current_user.messages_in.where(:trashed => false)
    @book_messages = current_user.book_messages_in.where(:trashed => false)
    session[:message_action] = 'index'
  end

  def create
    if !params[:food_type_id].nil?
      food_type = FoodType.find(params[:food_type_id]).name
    end
    location = Location.find(params[:location_id]).location_name
    @negotiate = Negotiate.create(:post_requirement_id => params[:post_requirement_id],:skill_post_requirement_id => params[:skill_post_requirement_id], :user_id => current_user.id, :nego_id => params[:user_id]).valid?
    if @negotiate
      message = Message.create(:subject => "New Order", :content => "You have received a new order from #{current_user.name}. Please confirm the order", :user_id => current_user.id, :posted_to => params[:user_id], :post_requirement_id => params[:post_requirement_id], :skill_post_requirement_id => params[:skill_post_requirement_id], :food => food_type, :location => location, :read => false, :order_status => true)
      provider = User.find(params[:user_id])
      seeker = current_user
      if !params[:post_requirement_id].blank?
        UserMailer.new_order_for_provider(provider,message.id, seeker).deliver             
        else
       UserMailer.new_order_for_skill_provider(provider,message.id, seeker).deliver             
       end
      contact_details = User.find(params[:user_id])
      UserMailer.mail_contact_info_provider(provider,contact_details,seeker).deliver
    end
    render :json => @negotiate.to_json    
  end

  def read
    @message = Message.find(params[:id])
    @message.update_attribute(:read, true)
  end

  def unread
    @unread_messages = current_user.messages_in.where(:read => false, :trashed => false)
    @book_unread_messages = current_user.book_messages_in.where(:read => false, :trashed => false)
    session[:message_action] = 'unread'
  end

  def sent
    @sent_messages = current_user.messages_out.where(:trashed => false)
    @book_sent_messages = current_user.book_messages_out.where(:trashed => false)
    session[:message_action] = 'sent'
  end

  def trash
    @messages_1 = current_user.messages_in.where(:trashed => true)
    @book_messages_1 = current_user.book_messages_in.where(:trashed => true)
    @messages_2 = current_user.messages_out.where(:trashed => true)
    @book_messages_2 = current_user.book_messages_out.where(:trashed => true)
    @trash_messages = @messages_1 + @messages_2
    @book_trash_messages = @book_messages_1 + @book_messages_2
    session[:message_action] = 'trash'
  end

  def agree_share
    @message_posted_to = User.find(params[:user_id])    
    Message.update(params[:id], :accepted => true)        
    @order = Order.create(:user_id => params[:user_id], :order_date => Time.now, :provider_id => current_user.id, :post_requirement_id => params[:post_requirement_id])
    Activity.create(:user_id => @message_posted_to.id, :contact_id => current_user.id,:seeked_shared => true, :order_id => @order.id, :post_requirement_id => params[:post_requirement_id])
    Activity.create(:user_id => current_user.id, :contact_id => @message_posted_to.id, :seeked_shared => false, :order_id => @order.id, :post_requirement_id => params[:post_requirement_id])
    
    seeker_message = Message.create(:subject => "Your order was confirmed", :content => "Order Confirmed: OrderID ##{@order.id}", :user_id => current_user.id, :posted_to => @message_posted_to.id, :post_requirement_id => params[:post_requirement_id], :read => false, :order_id => @order.id)
    seeker = User.find(@message_posted_to.id)
    provider = current_user
    
    UserMailer.address_info_seeker(seeker, seeker_message.id, provider).deliver
    
    provider_message = Message.create(:subject => "New order accepted",:content => "Order Accepted: Order ID ##{@order.id}", :user_id => @message_posted_to.id, :posted_to => current_user.id, :post_requirement_id => params[:post_requirement_id], :read => false, :order_id => @order.id)
    provider = current_user
    seeker = User.find(@message_posted_to.id)
    UserMailer.address_info_provider(provider, provider_message.id, seeker).deliver
    redirect_to messages_path
  end

  def destroy
    @message = Message.find(params[:id])
    if session[:message_action].eql?('trash')
      @message.destroy
    else
      @message.update_attribute(:trashed, true)
    end
    redirect_to :action => session[:message_action]
  end

  def cancel
    @message_posted_to = User.find(params[:user_id])    
    @negotiate = Negotiate.find_by_user_id_and_post_requirement_id(params[:negotiate_id], params[:post_requirement_id])    
    if !@negotiate.nil?
      @negotiate.destroy
      OrderCancel.create(:order_id => params[:order_id], :cancel_date =>  Time.now)  
      Message.create(:subject => "Order Cancellation", :content => "Order cancelled. The Order No. is ##{params[:order_id]}", :user_id => current_user.id, :posted_to => @message_posted_to.id, :read => false, :order_id => params[:order_id])
    end
    redirect_to profile_home_path
  end


end