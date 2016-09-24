class DashboardsController < ApplicationController
  before_filter :authenticate
  before_filter :load_dashboard , only: [:show,:edit,:update, :destroy, :add_panel]
  

  def new
  end

  def index
  end
  
  def show
  end  
  
  def edit
  end
  
   def update
#     if (@report.update(report_params)) then
#       flash[:info] = "report correctly updated"
#       redirect_to dash_board_url(@report)
#     else
#       flash[:error] = "report update failed"
#       render :edit
#     end
  end
  
  def destroy
#     @report.destroy
#     flash[:info] = "report removed"
#     redirect_to reports_path
  end 
  
 private
  def load_dashboard
    @dashboard = DashBoard.find(params[:id])
  end
  
end
