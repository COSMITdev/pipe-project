class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  validates :user_id, :topic_id, :body, presence: true
end
