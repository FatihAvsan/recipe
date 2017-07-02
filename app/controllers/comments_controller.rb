class CommentsController < ApplicationController
  before_action :require_user
  
  
  def create
    @receipt = Receipt.find(params[:receipt_id])
    @comment = @receipt.comments.build(comment_params)
    @comment.chef = current_chef
    if @comment.save
      flash[:success] = "Comment was created successfuly"
      redirect_to receipt_path(@receipt)
    else
      flash[:danger] = "Comment was not created"
      redirect_to :back
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:description)
  end

end