App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    @followCurrentPost()

  disconnected: ->
    @perform 'unsubscribe'

  received: (data) ->
    @appendPost(data)

  post: (comment) ->
    @perform 'post', comment: comment

  followCurrentPost: ->
    if postId = $('.comment-form').data('post-id')
      @perform 'subscribe', post_id: postId
    else
      @perform 'unsubscribe'

  appendPost: (data) ->
    html = @createPost(data)
    $('#comments').append(html)

  createPost: (data) ->
    """
    <div>
      <p>#{data['comment']}</p>
    </div>
    """

$(document).on 'keypress', '[data-behavior~=post_comment]', (event) ->
  if event.keyCode is 13
    App.comments.post event.target.value
    event.target.value = ''
    event.preventDefault()

$(document).on 'click', '#post_btn', (event) ->
  comment = $('[data-behavior~=post_comment]')
  App.comments.post comment.val()
  comment.val('')
  event.preventDefault()
