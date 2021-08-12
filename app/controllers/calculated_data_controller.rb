class CalculatedDataController < ApplicationController
  before_action :authenticate
  before_action :load_calculated_data, only: [:delete_sample] 

  def index
    @operation = Operation.find(params[:operation_id])
    @calculatedData = CalculatedDatum.where(operation_id: @operation.id).order("beginPeriod DESC").page(params[:page]).per_page(70)
  end
    
  def delete_sample
    operation_id = @calculatedData.operation_id
    @calculatedData.destroy
    redirect_to calculated_data_path(operation_id: operation_id )
  end
    
private
  def load_calculated_data
    @calculatedData = CalculatedDatum.find(params[:id])
  end
  
end
