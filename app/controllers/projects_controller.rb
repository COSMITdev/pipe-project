class ProjectsController < ApplicationController
  before_action :check_permission, only: [:show, :edit, :update]

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(params[:id])
    @topics = @project.topics
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(permitted_params)

    if @project.valid? && @project.save
      redirect_to @project, alert: 'Seu projeto foi criado com sucesso!'
    else
      flash[:alert] = 'Por favor, confira os erros do formulário'
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.valid? && @project.save
      redirect_to @project, alert: 'Seu projeto foi editado com sucesso!'
    else
      flash[:alert] = 'Por favor, confira os erros do formulário'
      render :edit
    end
  end

  protected

  def permitted_params
    params.require(:project).permit([:user_id, :name])
  end

  private

  def check_permission
    if Project.find(params[:id]).user != current_user
      flash[:alert] = 'Você não tem permissão para acessar este projeto.'
      redirect projects_path
    end
  end
end
