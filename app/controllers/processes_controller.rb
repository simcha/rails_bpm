
#
# ruote process instances
#
class ProcessesController < RailsBpmController

  def index
    current_page = 1
    current_page = params[:page].to_f unless params[:page].nil?
    per_page = ITEMS_PER_PAGE 
    
    @processes = WillPaginate::Collection.create(current_page, per_page) do |pager|

      result = RuoteKit.engine.processes({:skip => pager.offset, :limit => pager.per_page})
      pager.replace(result)
    
      unless pager.total_entries
        pager.total_entries = RuoteKit.engine.processes({:count => true})
      end
    end
  end

  def create

    definition = RailsBpm::Process.find(params[:definition])

    wfid = RuoteKit.engine.launch(definition.definition)

    flash[:notice] = I18n.t('flash.notice.launched', :wfid => wfid)

    redirect_to :controller => 'definitions', :action => 'index'
  end
end

