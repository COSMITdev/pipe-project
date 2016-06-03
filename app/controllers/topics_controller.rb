class TopicsController < ApplicationController
  before_action :check_permission
  before_action :authenticate_user!
  before_action :load_sidebar

  def index
    @project = Project.find(params[:project_id])
    @topics = @project.topics.order(updated_at: :desc)
  end

  def show
    @project = Project.find(params[:project_id])
    @topic = @project.topics.find(params[:id])
    @comment = Comment.new(user: current_user, topic: @topic)
    @comments = @topic.comments
  end

  def new
    @project = Project.find(params[:project_id])
    @topic = @project.topics.build
  end

  def create
    @project = Project.find(params[:project_id])
    @topic = @project.topics.build(permitted_params)
    @topic.user = current_user

    if @topic.valid? && @topic.save
      redirect_to project_topic_path(@project, @topic), notice: 'A new Thread has been created!'
    else
      flash[:alert] = 'Please, check errors in the form'
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @topic = @project.topics.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @topic = @project.topics.find(params[:id])

    if @topic.valid? && @topic.update_attributes(permitted_params)
      flash[:notice] = 'This thread was successfully edited!'
      redirect_to project_topic_path(@project, @topic)
    else
      flash[:alert] = 'Please, check errors in the form'
      render :edit
    end
  end

  protected

  def permitted_params
    params.require(:topic).permit([:user_id, :project_id, :title, :body])
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
