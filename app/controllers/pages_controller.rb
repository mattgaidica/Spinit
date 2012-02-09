class PagesController < ApplicationController
  def index
    @page = params[:page_id]
  end

  def play
    @page = params[:page_id]
  end

  def splash

  end
end
