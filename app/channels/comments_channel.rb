class CommentsChannel < ApplicationCable::Channel
  def subscribe(data)
    post_id = data['post_id'].to_i
    @post = Post.find(post_id)
    stream_for @post
  end

  def unsubscribe
    stop_all_streams
  end

  def post(data)
    comment = Comment.new(name: data['name'], body: data['comment'], post: @post)
    if comment.valid?
      comment.save!
    else
      CommentBroadcastJob.perform_later @post, 'failed'
    end
  end

  def delete(data)
    id = data['commentId'].to_i
    comment = Comment.find(id)
    comment.destroy
  end
end
