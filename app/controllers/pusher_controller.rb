class PusherController < ApplicationController
  protect_from_forgery :except => [:guest, :user] # stop rails CSRF protection for this action
  
  def guest
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
      :user_id => 0,
      :user_info => {}
    })
    render :json => response
  end

  def user
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => current_user.id, # => required
        :user_info => { # => optional - for example
          :name => current_user.name,
          :image => current_user.image,
          :latitude => current_user.position.latitude,
          :longitude => current_user.position.longitude,
        }
      })
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end
