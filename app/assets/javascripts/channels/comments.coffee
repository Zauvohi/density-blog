App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    @followCurrentPost()

  disconnected: ->
    @perform 'unsubscribe'

  received: (data) ->
    @appendPost(data)

  post: (comment, name) ->
    @perform 'post', comment: comment, name: name

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
      <p>#{data['name'] || 'Anon'} said: #{data['comment']}</p>
    </div>
    """

$(document).on 'keypress', '[data-behavior~=post_comment]', (event) ->
  name = document.querySelector('[name=commenter]')
  comment = event.target
  if event.keyCode is 13
    App.comments.post comment.value, name.value
    comment.value = ''
    name.value = ''
    event.preventDefault()

$(document).on 'click', '#post_btn', (event) ->
  comment = $('[data-behavior~=post_comment]')
  App.comments.post comment.val()
  comment.val('')
  event.preventDefault()
