class TopicsController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @topic = @project.topics.find(params[:id])
    @comment = Comment.new(user: current_user, topic: @topic)
    @comments = @topic.comments
  end

  def new
    @topic = Project.find(params[:project_id]).topics.build
  end

  def create
    @project = Project.find(params[:project_id])
    @topic = @project.topics.build(permitted_params)
    @topic.user = current_user

    if @topic.valid? && @topic.save
      redirect_to project_topic_path(@project, @topic), alert: 'Uma nova Discussão foi iniciada'
    else
      flash[:alert] = 'Por favor, confira os erros do formulário'
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @topic = @project.topics.find(params[:id])

    if @topic.valid? && @topic.update_attributes(permitted_params)
      flash[:alert] = 'Esta Discussão foi editado com sucesso'
      redirect_to project_topic_path(@project, @topic)
    else
      flash[:alert] = 'Por favor, confira os erros do formulário'
      render :edit
    end
  end

  protected

  def permitted_params
    params.require(:topic).permit([:user_id, :project_id, :title, :body])
  end
end
