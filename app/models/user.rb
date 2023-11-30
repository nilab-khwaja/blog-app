class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'comment_id'
  has_many :likes, foreign_key: 'like_id'

  validates :name, presence: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
