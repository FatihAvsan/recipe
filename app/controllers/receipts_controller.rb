class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update] 
  
  def index
    @receipts = Receipt.all
  end
  
  def show
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
  
  def edit
  end
  
  def update
    if @receipt.update(receipt_params)
      flash[:success] = "Receipt was updated successfuly!"
      redirect_to receipt_path(@receipt)
    else 
      render 'edit'
    end
  end
  
  def destroy
    Receipt.find(params[:id]).destroy
    flash[:success] = "Receipt deleted successfuly"
    redirect_to receipts_path
  end
  
  private
  
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end
  
    def receipt_params
      params.require(:receipt).permit(:name, :description)
    end
end