class InvitationMailer < ApplicationMailer
  def invite_new_user(project, invitation)
    @project = project
    mail to: invitation.email
  end

  def invite_registered_user(project, invitation)
    @project = project
    mail to: invitation.email
  end
end
