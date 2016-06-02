class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, dependent: :destroy
  has_many :project_users
  has_many :projects, through: :project_users
  has_many :own_projects, dependent: :destroy, class_name: 'Project'
  has_many :comments, dependent: :destroy

  validates :name, presence: true
end
