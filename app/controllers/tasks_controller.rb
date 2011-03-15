class TasksController < TaskFormController
  
  def index

    @workitems = Ruote::Workitem.for_user(session[:username])
  end
  def show

    @workitem =
      RuoteKit.storage_participant[params[:id]]
    @tree =
      Rufus::Json.encode(RuoteKit.engine.process(@workitem.wfid).current_tree)
  end
  class Base < TaskFormController
    layout 'tasks_base'
    helper :tasks
    
    def index
      redirect_to :controller => :tasks, :action => :index
    end
  end

end