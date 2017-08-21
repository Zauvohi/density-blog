# README

This exercise tries to simulate a blog with live comments. For the comments we'll use ActionCable.
There's no user authentication, so basically any user can create and delete posts/comments.

Things this exercise do:

* A user can create a post.

* A user can comment in any post.

* A user can delete the comments in a post.

* These comments are updated live, any new comment and deletion will be reflected on the other clients viewing that post.


## Known issues

* Sometimes the comments are saved/deleted but the view won't update properly in one or all the clients, the user have to refresh and it'll work properly.

* Posts and comments don't have a proper formatting, everything is a single paragraph.
