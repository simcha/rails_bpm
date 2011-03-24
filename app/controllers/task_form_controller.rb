class TaskFormController < RailsBpmController
  helper :tasks
  
  before_filter :get_process_data, :except => [ :index]

  def update()
    unless params[:workitem].blank? or params[:workitem][:fields].blank?
      fields = Rufus::Json.decode(params[:workitem][:fields]) 
      @workitem.fields.merge!(fields)
    end
    @workitem.fields.merge!(@task_fields)

    if params[:proceed_subaction]

      RuoteKit.storage_participant.reply(@workitem)
      flash[:notice] = I18n.t('flash.notice.proceeded', :fei => @workitem.fei.sid)
    else
      
      RuoteKit.storage_participant.update(@workitem)
      flash[:notice] = I18n.t('flash.notice.saved', :fei => @workitem.fei.sid)
    end

    redirect_to :controller => :tasks, :action => :index
  end
  def claim
    @workitem.fields["orginal_participant"] = @workitem.participant_name
    @workitem.participant_name = session[:username]
    RuoteKit.storage_participant.update(@workitem)
    if params[:edit]
      redirect_to :action => :edit
    else
      redirect_to :controller => :tasks, :action => :index
    end
  end
  def unclaim
    @workitem.participant_name = @workitem.fields["orginal_participant"]
    RuoteKit.storage_participant.update(@workitem)
    redirect_to :controller => :tasks, :action => :index
  end
  private
  
  def get_process_data
    @workitem =
      RuoteKit.storage_participant[params[:id]]
    @task_fields = @workitem.fields
    @ruote_process_state_tree =
      Rufus::Json.encode(RuoteKit.engine.process(@workitem.wfid).current_tree)
  end
end
