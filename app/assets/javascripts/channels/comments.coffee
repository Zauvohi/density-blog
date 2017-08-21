App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    @followCurrentPost()

  disconnected: ->
    @perform 'unsubscribe'

  received: (data) ->
    if data['status'] is 'created'
      $('#comments').append(data['comment'])
    else if data['status'] is 'destroyed'
      $(".comment[data-comment-id=#{data['comment_id']}]").remove()
    else
      @appendErrorMsg(data['errors'])

  post: (comment, name) ->
    @perform 'post', comment: comment, name: name

  delete: (commentId) ->
    @perform 'delete', commentId: commentId

  followCurrentPost: ->
    if postId = $('.comment-form').data('post-id')
      @perform 'subscribe', post_id: postId
    else
      @perform 'unsubscribe'

  createErrorAlert: (msg) ->
    """
    <div class="alert alert-danger" role="alert">#{msg}</div>
    """

  appendErrorMsg: (msg) ->
    html = @createErrorAlert(msg)
    $('#error_alerts').append(html)

$(document).on 'click', '#post_btn', (event) ->
  $('#error_alerts').html('')
  comment = document.querySelector('[data-behavior~=post_comment]')
  name = document.querySelector('[name=commenter]')
  App.comments.post comment.value, name.value
  comment.value = ''
  name.value = ''
  event.preventDefault()

$(document).on 'click', '.comment-delete', (event) ->
  commentId = event.target.dataset.commentId
  App.comments.delete commentId
  event.preventDefault()
