class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy, :add_tags, :change_status]

  # GET /todos.json
  def index
    @todos = Todo.page params[:page]
  end

  # GET /todos/1.json
  def show
    if @todo
      render :show, status: :ok
    else
      render json: {}, status: 404
    end
  end

  # PUT /todos/1/change_status.json
  def change_status
    if @todo.update(todo_status_params)
      render :show
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PUT /todos/1/add_tags.json
  def add_tags
    tag = Tag.find_or_create_by(tag_params)
    if tag
      @todo.tags << tag
      render :show, status: :created
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  # GET /todos/1/recover.json
  def recover
    @todo = Todo.unscoped.find(params[:id])
    if @todo.restore
      render :show
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render :show, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1.json
  def update
    if @todo.update(todo_params)
      render :show
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:title, :description, :status)
    end

    def todo_status_params
      params.require(:todo).permit(:status)
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
