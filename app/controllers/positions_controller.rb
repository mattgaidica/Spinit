class PositionsController < ApplicationController

  def update
    if current_user
      position = Position.find_or_create_by_user_id(current_user.id)
      position.update_attributes(:latitude => params[:latitude], :longitude => params[:longitude])
      render :text => 'Position updated.', :status => 200
      #update map?
      Pusher['presence' + params[:page_id]].trigger('update_position', {
        :user_id => current_user.id,
        :latitude => params[:latitude],
        :longitude => params[:longitude]
      })
    end
  end

end
