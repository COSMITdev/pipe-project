class InvitationMailerPreview < ActionMailer::Preview
  def invite_new_user
    InvitationMailer.invite_new_user
  end

  def invite_registered_user
    InvitationMailer.invite_registered_user
  end
end
