class Project < ActiveRecord::Base
  belongs_to :user
  has_many :topics, dependent: :destroy

  validates :user, :name, presence: true
end
