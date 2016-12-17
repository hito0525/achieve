class Blog < ActiveRecord::Base
  validates :title,:content, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes
  #, dependent: :destroy
  #has_many :linking_user, through: :likes, source: :user
  # def like_user(user_id)
  #    likes.find_by(user_id: user_id)
  #   end
end
