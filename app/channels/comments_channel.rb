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
    comment.save!
  end
end
