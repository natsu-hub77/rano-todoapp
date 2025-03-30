class TasksController < ApplicationController
  def new
    @task = current_user.tasks.build
  end
end