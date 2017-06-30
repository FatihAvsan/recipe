class PagesController < ApplicationController
  def home
    redirect_to receipts_path if logged_in?
  end

end