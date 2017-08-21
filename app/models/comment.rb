class Comment < ApplicationRecord
  belongs_to :post
  validates :body, presence: true
  after_create_commit { CommentBroadcastJob.perform_later self, 'created' }
  after_destroy { CommentBroadcastJob.perform_later self, 'destroyed' }
end
