class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user_id, :project_id, :title, :body, presence: true
end
