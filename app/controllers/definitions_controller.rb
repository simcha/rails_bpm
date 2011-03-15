
#
# process definitions
#
class DefinitionsController < RailsBpmController

  def index

    @definitions = RailsBpm::Process.all
  end

  def show

    @definition = RailsBpm::Process.find(params[:id])
  end
  def launch
    redirect_to :controller => 'processes', :action => 'create', :definition => params[:id]
  end
end

