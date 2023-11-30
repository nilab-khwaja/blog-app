class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def update_post_counter_user
    author.update(post_counter: author.posts.count)
  end

  def five_recent_comments_post
    comments.order(created_at: :desc).limit(5)
  end
end
