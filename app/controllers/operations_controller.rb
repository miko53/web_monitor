class OperationsController < ApplicationController
  
  def new
    @sensor= Sensor.find(params[:sensor_id])
    @operation = @sensor.operations.new
  end

  def create
    @operation = Operation.new(operation_params)
    if (@operation.save) then
      flash[:info] = "operation created successfully"      
      redirect_to sensor_show_operation_url(@operation.sensor)
    else
      flash[:error] = "operation saved failed"
      render :new
    end
  end
  
  def show
    
  end

  def edit
    
  end


  def update
    
  end

  def destroy
  end

  def index
  end

private
  def operation_params
    params.require(:operation).permit(:id, :sensor_id, :beginPeriod, :period, :calcul_type)
  end
end
