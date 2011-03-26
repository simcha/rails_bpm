module TasksHelper
  def task_buttons(opts = {})
    workitem = opts[:workitem]
    workitem ||= @workitem
    answer_var = opts[:answer_var]
    answer_var ||= "answer"

    render :partial => "/tasks/buttons", :locals => {
        :workitem => workitem, 
        :answers => opts[:answers], 
        :answer_var => answer_var,
      }
  end
end
