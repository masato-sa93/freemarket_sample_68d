class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment =Comment.create(comment_params)
    redirect_to item_path(@comment.item_id)

  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end