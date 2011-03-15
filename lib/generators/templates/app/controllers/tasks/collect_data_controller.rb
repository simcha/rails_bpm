class Tasks::CollectDataController < TasksController::Base

  def show
    @room = Room.new(@task_fields["room"])
  end
  def update
    @room = Room.new(params["room"])
    
    if @room.valid? 
      @task_fields["room"] = @room
      super
    else 
      render :show
    end
  end
end