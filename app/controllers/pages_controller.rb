class PagesController < ApplicationController
  def index
    @page = Page.find(params[:page_id])
  end

  def play
    @page = Page.find(params[:page_id])
  end

  def splash

  end
end
