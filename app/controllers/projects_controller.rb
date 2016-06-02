class ProjectsController < ApplicationController
  before_action :check_permission, except: [:index, :new, :create]

  def index
    @projects = current_user.own_projects + current_user.projects
  end

  def show
    @project = Project.find(params[:id])
    @topics = @project.topics
  end

  def new
    @project = current_user.own_projects.build
  end

  def create
    @project = current_user.own_projects.build(permitted_params)

    if @project.valid? && @project.save
      redirect_to @project, alert: 'Seu projeto foi criado com sucesso!'
    else
      flash[:alert] = 'Por favor, confira os erros do formulário'
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.valid? && @project.save
      redirect_to @project, alert: 'Seu projeto foi editado com sucesso!'
    else
      flash[:alert] = 'Por favor, confira os erros do formulário'
      render :edit
    end
  end

  def invitations
    @project = Project.find(params[:project_id])
    @invitation = @project.invitations.build
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

      redirect_to @project, alert: 'Convite enviado com sucesso!'
    else
      flash[:alert] = 'Por favor, confira os erros do formulário'
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
    owner   = Project.find(params[:id]).user
    members = Project.find(params[:id]).users

    unless owner == current_user || members.include?(current_user)
      flash[:alert] = 'Você não tem permissão para acessar este projeto.'
      redirect_to projects_path
    end
  end
end
