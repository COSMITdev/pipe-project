class Invitation < ActiveRecord::Base
  belongs_to :project

  validates :project_id, :email, presence: true
  validate :email_already_invited

  protected

  def email_already_invited
    if project.invitations.where(email: self.email).any? ||
       project.users.where(email: self.email).any?

      errors.add(:email, 'Este email já foi convidado')
    end
  end
end
