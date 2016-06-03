class ProjectsController < ApplicationController
  before_action :check_permission, except: [:index, :new, :create]
  before_action :authenticate_user!
  before_action :load_sidebar

  def index
    @projects = current_user.own_projects + current_user.projects
    @projects = @projects.sort_by {|p| p[:created_at]}
  end

  def show
    @project = Project.find(params[:id])
    @topics  = @project.topics.order(updated_at: :desc).limit(3)
    @tasks   = @project.tasks.unfinished.order(finished: :asc, created_at: :desc).limit(6)
  end

  def new
    @project = current_user.own_projects.build
  end

  def create
    @project = current_user.own_projects.build(permitted_params)

    if @project.valid? && @project.save
      redirect_to @project, notice: 'Your project was successfully created!'
    else
      flash[:alert] = 'Please, check errors in the form'
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.valid? && @project.update_attributes(permitted_params)
      redirect_to @project, notice: 'Your project was successfully edited!'
    else
      flash[:alert] = 'Please, check errors in the form'
      render :edit
    end
  end

  def invitations
    @project = Project.find(params[:project_id])
    @invitation = Invitation.new(project: @project)
  end

  def send_invitation
    @project = Project.find(params[:project_id])
    @invitation = @project.invitations.build(permitted_invitation_params)

    if @invitation.valid?
      if User.where(email: @invitation.email).any?
        ProjectUser.create(project: @project, user: User.find_by(email: @invitation.email))
        InvitationMailer.invite_registered_user(@project, @invitation).deliver_now
      else
        @invitation.save
        InvitationMailer.invite_new_user(@project, @invitation).deliver_now
      end
      redirect_to project_invitation_path, notice: 'Invitation has been sent!'
    else
      flash[:alert] = 'Please, check errors in the form'
      render :invitations
    end
  end

  protected

  def permitted_params
    params.require(:project).permit([:user_id, :name])
  end

  def permitted_invitation_params
    params.require(:invitation).permit([:project_id, :email])
  end

  private

  def check_permission
    # Check if user is owner of project or if it belong to members
    project = Project.find(params[:id] || params[:project_id])
    owner   = project.user
    members = project.users

    unless owner == current_user || members.include?(current_user)
      flash[:alert] = 'You do not have permission to access this Project'
      redirect_to projects_path
    end
  end

  def load_sidebar
    @projects = current_user.own_projects + current_user.projects
    @projects = @projects.first(6).sort_by {|p| p[:created_at]}.uniq{|p| p.id}
  end
end
