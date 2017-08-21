class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment, status)
    CommentsChannel.broadcast_to comment.post,
     comment: render_comment(comment, status),
     status: status,
     comment_id: comment.id
  end

  private

  def render_comment(comment, status)
    if status == 'created'
    ApplicationController.renderer.render(
      partial: 'comments/comment', locals: { comment: comment }
    )
    else
      nil
    end
  end
end
