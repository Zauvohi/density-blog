class Post < ApplicationRecord
  has_many :comments, dependent: :delete_all
  validates :content, :title, presence: true
end
