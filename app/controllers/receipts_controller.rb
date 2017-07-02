class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy] 
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @receipts = Receipt.paginate(page: params[:page], per_page: 5)
  end
  
  def show
    @comment = Comment.new
    @comments = @receipt.comments.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @receipt = Receipt.new
  end
  
  def create
    @receipt = Receipt.new(receipt_params)
    @receipt.chef = current_chef
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
      params.require(:receipt).permit(:name, :description, ingredient_ids: [])
    end
    
    def require_same_user
      if current_chef != @receipt.chef and !current_chef.admin?
        flash[:danger] = "You can only edit or delete your own receipts"
        redirect_to receipts_path
      end
    end
end