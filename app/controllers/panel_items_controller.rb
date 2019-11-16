class PanelItemsController < ApplicationController
  before_action :authenticate
  before_action :load_item , only: [:show, :edit, :update, :destroy]

def new
    panel = DashBoardPanel.find(params[:panel_id])
    @item = panel.panel_item.new
    @item.save
    dashboard = panel.dash_board
    redirect_to edit_dashboard_path(dashboard)
end
  
def update
  if @item.update(item_params) then
    flash[:info] = "updated"
  else
    flash[:error] = "update failed"
  end
  panel = @item.dash_board_panel
  dashboard = panel.dash_board
  redirect_to edit_dashboard_path(dashboard)
end

def destroy
  dashboard = @item.dash_board_panel.dash_board
  @item.destroy
  redirect_to edit_dashboard_path(dashboard)
end

private

def load_item
  @item = PanelItem.find(params[:id])
end

def item_params
  params.require(:panel_item).permit(:id, :name, :sensor_name, :operation_name)
end

end
