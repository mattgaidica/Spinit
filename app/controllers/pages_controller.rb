class PagesController < ApplicationController
  def index
    @page = Page.find(params[:page_id])
  end

  def play
    @page = Page.find(params[:page_id])
  end

  def splash

  end

  def add_user
    #add taker
    if Taker.find_by_user_id_and_page_id(params[:user_id], params[:page_id]).nil?
      Taker.create(:user_id => params[:user_id], :page_id => params[:page_id], :status => 0)
    end
    user = User.find(params[:user_id])
    user_html = render_to_string(:partial => "pages/user", :locals => { :user => user })

    Pusher['presence' + params[:page_id]].trigger('new_user', {
      :user_id => current_user.id,
      :latitude => user.position.latitude,
      :longitude => user.position.longitude,
      :user_html => user_html
    })
    render :text => 'thanks', :status => 200
  end
end
