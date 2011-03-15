module TasksHelper
  def task_buttons(workitem = @workitem)
    render :partial => "/tasks/buttons", :locals => {:workitem => workitem}
  end
end
