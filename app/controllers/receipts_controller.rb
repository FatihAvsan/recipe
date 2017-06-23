class ReceiptsController < ApplicationController
  def index
    @receipts = Receipt.all
  end
end