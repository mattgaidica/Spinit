class MessagesController < ApplicationController
  def add
    message = Message.new(:body => params[:body], :page_id => params[:page_id])
    if !params[:user_id].nil?
      message.user_id = params[:user_id]
    end
    
    if message.save
      if message.user_id
        render :partial => "messages/from_user", :locals => { :message => message }
      else
        render :partial => "messages/announcement", :locals => { :message => message }
      end
    end
  end
end
