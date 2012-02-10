class PositionsController < ApplicationController

  def update
    if current_user
      position = Position.find_or_create_by_user_id(current_user.id)
      position.update_attributes(:latitude => params[:latitude], :longitude => params[:longitude])
      render :text => 'Position updated.', :status => 200
    end
  end

end
