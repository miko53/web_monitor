class RangeCommandsController < ApplicationController
  before_filter :authenticate
  #before_filter :load_actuator , only: [:show,:edit,:update,:show_operation, :delete_sample]
  
  def index
    @actuator_commands = RangeCommand.all.order(:name).page(params[:page]).per_page(10)
  end
  
  def new
    @actuator_command = RangeCommand.new
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
  
 private
  def range_command_params
    params.require(:range_command).permit(:name, :start_time, :stop_time, :start_day, :stop_day)
  end

end
