class DashBoardPanelsController < ApplicationController
  before_filter :authenticate
  before_filter :load_panel , only: [:show, :edit, :update, :destroy]

  def new
    dashboard = DashBoard.find(params[:dash_board_id])
    @panel = dashboard.dash_board_panel.new
    @panel.save
    redirect_to edit_dashboard_path(dashboard)
  end
  
  
  def show
    
  end  
  
  def update
    if @panel.update(panel_params) then
      flash[:info] = "panel updated"
    else
      flash[:error] = "panel update failed"
    end
    dashboard = @panel.dash_board
    redirect_to edit_dashboard_path(dashboard)
  end
  
  def destroy
    dashboard=@panel.dash_board
    @panel.destroy
#     flash[:info] = "panel removed"
    redirect_to edit_dashboard_path(dashboard)
  end   
    
private
  def load_panel
    @panel = DashBoardPanel.find(params[:id])
  end
  
  def panel_params
    params.require(:dash_board_panel).permit(:id, :name)
  end

end
