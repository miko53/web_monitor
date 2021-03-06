
class String
  def valid_float?
    true if Float self rescue false
  end
end

class ActuatorsController < ApplicationController
  before_action :authenticate
  before_action :load_actuator , only: [:show,:edit,:update,:show_operation, :delete_sample]

  def edit
  end

  def index
    @actuators = Actuator.all
  end
  
  def send_grouped_orders
    order = params['actuator_orders']['value']
    forced = params['actuator_orders']['forced']
    #p params['actuator_orders']['value']
    #p forced
    Actuator.all.each do |act|
      act.forced = forced
      act.save
    end
    
    Actuator.all.each do |act|
      CommandSchedule.send_command(act, act.order, order)
    end
    redirect_to actuators_path
  end
  
  
  def send_forced_orders
    forced = params['actuator_orders']['forced']
    #p forced
    Actuator.all.each do |act|
      act.forced = forced
      act.save
    end   
    redirect_to actuators_path
  end
  
  def send_orders
    #p params
    # NOTE: the retrieval of orders is not very optimal 
    # the aim of the following code is to use the value of 
    # the checkbox given in params to know which actuator must be updated
    # in a first pass, the list of actuator to update is put inside in a list (by Id)
    # then the parameter actuator is read and actuator can be updated for each id selected

    selectedId = Array.new
    actuator_data = nil
    
    params.each do |param|
      if (param[0].valid_float?) then
        if (param[1]['selected'].to_i) == 1 then
          selectedId << param[0].to_i
        end
      else
        if (param[0] == "actuators") then
          actuator_data = param[1]
        end
      end
    end
    
    #p selectedId
    #p actuator_data
    
    actuator_data.each do |actuator| 
      if selectedId.include?(actuator[0].to_i) then
        # p actuator[1]
        act = Actuator.find(actuator[0].to_i)
        act.forced = actuator[1]["forced"]
        #value is send by pipe to the process which send order in device
        #act.value = actuator[1]["value"]
        CommandSchedule.send_command(act, act.order, actuator[1]["value"])
        act.save
      end
    end
    
    redirect_to actuators_path
  end
  
  def update
    if (@actuator.update(actuator_params)) then
      flash[:info] = "actuator correctly updated"
      redirect_to device_url(@actuator.device)
    else
      flash[:error] = "actuator update failed"
      render :edit
    end
  end
  
  def create
    redirect_to actuators_path
  end
  
private
  def load_actuator
    @actuator = Actuator.find(params[:id])
  end
  
  def actuator_params
    params.require(:actuator).permit(:order, :name, :forced, :actuator_type)
  end  
end
