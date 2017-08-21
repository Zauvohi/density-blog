class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    CommentsChannel.broadcast_to comment.post, comment: render_comment(comment)
  end

  private

  def render_comment(comment)
    ApplicationController.renderer.render(
      partial: 'comments/comment', locals: { comment: comment }
    )
  end
end
