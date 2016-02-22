class CalculatedDataController < ApplicationController
  def index
    @operation = Operation.find(params[:operation_id])
    @calculatedData = CalculatedDatum.where(operation_id: @operation.id).page(params[:page]).per_page(70)
  end
    
end
