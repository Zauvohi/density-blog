class Comment < ApplicationRecord
  belongs_to :post, dependent: :destroy
  after_create_commit { CommentBroadcastJob.perform_later self, 'created' }
  after_destroy { CommentBroadcastJob.perform_later self, 'destroyed' }
end
