class Task < ActiveRecord::Base
  belongs_to :project

  validates :project_id, :description, presence: true

  scope :unfinished, -> { where(finished: false) }

  def check
    update_attributes(finished: true)
  end

  def uncheck
    update_attributes(finished: false)
  end
end
