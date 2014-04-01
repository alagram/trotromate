class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :find_ticket

  def create
    @comment = @ticket.comments.build(comment_params.merge!(user: current_user))

    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      # @comments = @ticket.comments.reload
      flash.now[:alert] = "Comment has not been created."
      render :template => 'tickets/show'
    end
  end


  private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end