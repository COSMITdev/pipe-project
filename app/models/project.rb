class Project < ActiveRecord::Base
  belongs_to :user
  has_many :topics, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :project_users
  has_many :users, through: :project_users

  validates :user, :name, presence: true
end
