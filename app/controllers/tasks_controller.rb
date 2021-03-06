class TasksController < TaskFormController
  
  def index

    current_page = 1
    current_page = params[:page].to_f unless params[:page].nil?
    per_page = ITEMS_PER_PAGE 
    
    user_or_group = params[:group]
    user_or_group ||= session[:username]
    unless params[:group].blank? or params[:group] == "anyone" or User.find(session[:username]).groups.include? user_or_group
        render :text => "No access", :status => :forbidden
      else 
  
      @workitems = WillPaginate::Collection.create(current_page, per_page) do |pager|
  
        result = Ruote::Workitem.for_user(user_or_group,{:skip => pager.offset, :limit => pager.per_page},params[:all_users])
        pager.replace(result)
      
        unless pager.total_entries
          pager.total_entries = Ruote::Workitem.for_user_count(user_or_group,{},params[:all_users])
        end
      end
      
      respond_to do |format|
        format.html
        format.js {
          render :update do |page|
            page.replace 'results', :partial => 'search_results'
          end
        }
      end
    end
  end
  def edit

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