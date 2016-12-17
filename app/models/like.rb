class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
end
#, counter_cache: :likes_count
