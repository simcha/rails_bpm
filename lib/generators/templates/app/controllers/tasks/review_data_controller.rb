class Tasks::ReviewDataController < TasksController::Base

  def show
    @room_1 = Room.new(@task_fields["stack"][0]["room"])
    @room_2 = Room.new(@task_fields["stack"][1]["room"])
  end
  def update
    @room_1 = Room.new(params["rooms"]["room_1"])
    @room_2 = Room.new(params["rooms"]["room_2"])
    
    if @room_1.valid? && @room_2.valid? 
      @task_fields["stack"][0]["room"] = @room_1
      @task_fields["stack"][1]["room"] = @room_2
      @task_fields["accepted"] = params["rooms"]["accepted"]
      super
    else 
      render :show
    end
  end
end