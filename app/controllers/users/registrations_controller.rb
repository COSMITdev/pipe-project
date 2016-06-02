class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        associate_user_with_invitations_for_projects(resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def associate_user_with_invitations_for_projects(user)
    projects = Invitation.where(email: user.email).pluck(:project_id)
    projects.each do |project_id|
      ProjectUser.create(project_id: project_id, user: user)
      Invitation.find_by(email: user.email, project_id: project_id).destroy
    end
  end

  def after_sign_up_path_for(resource)
    projects_path
  end
end
