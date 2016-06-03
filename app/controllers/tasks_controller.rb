class TasksController < ApplicationController
  before_action :check_permission
  before_action :authenticate_user!
  before_action :load_sidebar

  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.order(finished: :asc, created_at: :desc)
    @task = Task.new(project: @project)
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(permitted_params)
    @tasks = @project.tasks.order(created_at: :asc)

    if @task.valid? && @task.save
      redirect_to project_tasks_path(@project), notice: 'A new Task has been added!'
    else
      flash[:alert] = 'Please, check errors in the form'
      render :index
    end
  end

  def check
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @task.finished? ? @task.uncheck : @task.check
    render nothing: true, status: :ok
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @tasks = @project.tasks.order(created_at: :asc)

    @task.destroy

    flash[:notice] = 'This Task has been removed!'
    redirect_to project_tasks_path(@project)
  end

  protected

  def permitted_params
    params.require(:task).permit([:project_id, :finished, :description])
  end

  private

  def check_permission
    # Check if user is owner of project or if it belong to members
    project = Project.find(params[:project_id])
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
