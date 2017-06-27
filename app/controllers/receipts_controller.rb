class ReceiptsController < ApplicationController
  def index
    @receipts = Receipt.all
  end
  
  def show
    @receipt = Receipt.find(params[:id])
  end
  
  def new
    @receipt = Receipt.new
  end
  
  def create
    @receipt = Receipt.new(receipt_params)
    @receipt.chef = Chef.first
    if @receipt.save
      flash[:success] = "Receipt was created successfuly!"
      redirect_to receipt_path(@receipt)
    else
      render 'new'
    end
  end
  
  private
  
    def receipt_params
      params.require(:receipt).permit(:name, :description)
    end
end