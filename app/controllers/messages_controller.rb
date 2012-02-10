class MessagesController < ApplicationController
  def add
    message = Message.new(:body => params[:body], :page_id => params[:page_id])
    if !params[:user_id].nil?
      message.user_id = params[:user_id]
    end
    
    if message.save
      if message.user_id
        message_html = render_to_string(:partial => "messages/from_user", :locals => { :message => message })
      else
        message_html = render_to_string(:partial => "messages/announcement", :locals => { :message => message })
      end
    end

    Pusher['page-' + params[:page_id]].trigger('add_message', {
      :message_html => message_html
    })

    render :text => message_html, :status => 200
  end
end
