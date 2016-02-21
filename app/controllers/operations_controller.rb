require 'period_helper'

class OperationsController < ApplicationController
  before_filter :load_operation , only: [:show, :edit, :update, :destroy]
  
  def new
    @sensor= Sensor.find(params[:sensor_id])
    @operation = @sensor.operations.new
  end

  def create
    @sensor= Sensor.find(params[:operation][:sensor_id])
    @operation = @sensor.operations.new(operation_params)
    @operation.currentValue = 0
    @operation.number_samples = 0
    isValid, nextEndPeriod = PeriodHelper::get_next_end_period(@operation.period, @operation.period_unit, Time.now)
    
    if (isValid == true) then
      @operation.endPeriod = nextEndPeriod
      if (@operation.save) then
        flash[:info] = "operation created successfully"      
        redirect_to sensor_show_operation_url(@operation.sensor)
      else
        flash[:error] = "operation saved failed"
        render :new
      end
    else
        flash[:error] = "period not valid, enter a new period"
        render :new      
    end
    
  end
  
  #def index
  #end
  
  #def show  
  #end

  def edit
  end


  def update
    @operation = Operation.find(params[:id])
    parameter = operation_params
    #p "-------------------------------------------------"
    #p "param => #{parameter}"
    #p params[:operation]
    #p "-------------------------------------------------"
    isValid, nextEndPeriod = PeriodHelper::get_next_end_period(parameter[:period].to_i, parameter[:period_unit].to_i, Time.now)
    if (isValid == true) then
      parameter[:endPeriod] = nextEndPeriod
      if (@operation.update(operation_params)) then
        flash[:info] = "operation correctly updated"
        redirect_to sensor_show_operation_url(@operation.sensor)
      else
        flash[:error] = "operation update failed"
        render :edit
      end
    else
      flash[:error] = "period not valid, enter a new period"
      render :edit
    end
  end

  def destroy
    @operation.destroy
    flash[:info] = "operation removed"
    redirect_to sensor_show_operation_url(@operation.sensor)
  end


private
  def operation_params
    params.require(:operation).permit(:id, :sensor_id, :period, :period_unit, :calcul_type )
  end
  
  def load_operation
    @operation = Operation.find(params[:id])    
  end
  
end
