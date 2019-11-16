class RangeCommandsController < ApplicationController
  before_action :authenticate
  before_action :load_range_command , only: [:edit, :update, :destroy]
  
  def index
    @actuator_commands = RangeCommand.all.order(:name).page(params[:page]).per_page(10)
  end
  
  def new
    @actuator_command = RangeCommand.new
  end
  
  def edit
  end
  
  def create
    @actuator_command = RangeCommand.new(range_command_params)
    actuator_command_id = params.require(:actuators_range_commands).permit(:actuator_ids => [] )
    #p actuator_command_id 
    #p @actuator_command 
    if (@actuator_command.save) then
      flash[:info] = "time slot created successfully"
      @actuator_command.actuator_ids = actuator_command_id[:actuator_ids]
      @actuator_command.save
      redirect_to range_commands_path
    else
      flash[:error] = "report saved failed"
      render :new
    end
  end
  
  def destroy
    @actuator_command.destroy 
    flash[:info] = "time slot removed"
    redirect_to range_commands_path
  end
  
  def update
    actuator_command_id = params.require(:actuators_range_commands).permit(:actuator_ids => [] )
    @actuator_command.actuator_ids = actuator_command_id[:actuator_ids]
    if (@actuator_command.update(range_command_params)) then
        flash[:info] = "time slot correctly updated"
        redirect_to range_commands_path
    else
       flash[:error] = "update failed"
        render :edit
    end
  end
  
 private
  def load_range_command
      @actuator_command = RangeCommand.find(params[:id])
  end
  
  def range_command_params
    params.require(:range_command).permit(:name, :start_time, :stop_time, :start_day, :stop_day, :command)
  end

end
