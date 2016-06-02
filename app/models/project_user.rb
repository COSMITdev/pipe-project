class ProjectUser < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :project_id, :user_id, presence: true
end
