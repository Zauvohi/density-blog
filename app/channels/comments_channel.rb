class CommentsChannel < ApplicationCable::Channel
  def subscribe(data)
    #puts "POST ID: #{data['post_id']}"
    post_id = data['post_id'].to_i
    @post = Post.find(post_id)
    stream_for @post
  end

  def unsubscribe
      stop_all_streams
  end

  def post(data)
    CommentsChannel.broadcast_to @post, comment: data['comment'], name: data['name']
  end
end
