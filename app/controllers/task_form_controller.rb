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

      if params[:release_subaction]
        @workitem.participant_name = 'anyone'
      elsif params[:take_subaction]
        @workitem.participant_name = session[:username]
      end

      RuoteKit.storage_participant.update(@workitem)
    end

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
