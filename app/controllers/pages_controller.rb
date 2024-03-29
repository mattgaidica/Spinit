class PagesController < ApplicationController
  def index
    @page = Page.find(params[:page_id])
  end

  def play
    @page = Page.find(params[:page_id])
    if current_user
      if Taker.find_by_user_id_and_page_id(current_user.id, @page.id).nil?
        Taker.create(:user_id => current_user.id, :page_id => @page.id, :status => 0)
        user_html = render_to_string(:partial => "pages/user", :locals => { :user => current_user })

        Pusher['page-' + params[:page_id]].trigger('new_user', {
          :user_id => current_user.id,
          :user_html => user_html
        })
        @status = 0
      else
        @status = Taker.find_by_user_id_and_page_id(current_user.id, @page.id).status
      end
    end
  end

  def splash

  end

  def add_user
    if Taker.find_by_user_id_and_page_id(params[:user_id], params[:page_id]).nil?
      Taker.create(:user_id => params[:user_id], :page_id => params[:page_id], :status => 0)
    end
    user = User.find(params[:user_id])
    user_html = render_to_string(:partial => "pages/user", :locals => { :user => user })

    Pusher['page-' + params[:page_id]].trigger('new_user', {
      :user_id => current_user.id,
      :user_html => user_html
    })
    #push new message if user is brand new
    render :text => 'thanks', :status => 200
  end
end
