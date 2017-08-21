class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data, status)
    if status == 'failed'
      # data = Post object
      CommentsChannel.broadcast_to data,
        status: status,
        errors: "Message's body can't be blank."
    else
      # data = Comment object
      CommentsChannel.broadcast_to data.post,
        comment: render_comment(data, status),
        status: status,
        comment_id: data.id
    end
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
