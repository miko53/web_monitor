class ReportsController < ApplicationController
  def index
    @report = Report.new
  end

  def create
    reportParam = params[:report]
    @report = Report.new
    @report.title = reportParam["title"]
    @report.dateBegin = DateTime.parse(reportParam["dateBegin"])
    @report.dateEnd = DateTime.parse(reportParam["dateEnd"])
    @report.deviceName = reportParam["deviceName"]
    @report.flowID = reportParam["flowID"]
    
    begin
      device = Device.find_by_name(@report.deviceName)
      if (device == nil) then
        flashString = "Unknown device #{@report.deviceName}, please retry"
        raise "device == nil"
      end

      sensor = device.sensors.find_by_order(@report.flowID)
      if (sensor == nil) then
        flashString = "Unknown sensor #{@report.flowID}, please retry"
        raise "sensor == nil"
      end
      
      samples = sensor.db.where('sensor_id=? AND (datetime(dateTime) >= datetime(?) AND datetime(dateTime) < datetime(?))',  
                                sensor.id, 
                                @report.dateBegin, @report.dateEnd)
      if (samples == nil || samples.count == 0) then
        flashString = "no samples"
        #raise "samples == nil"
      end
      
      #@series_a = samples.group_by_minute(:dateTime)
      @series_a = Array.new
        #build the serie of data
      samples.each { |sample| 
        @series_a << [ sample.dateTime, sample.value ]
        }
      
      sensor = device.sensors.find_by_order(2)
      samples = sensor.db.where('sensor_id=? AND (datetime(dateTime) >= datetime(?) AND datetime(dateTime) < datetime(?))',  
                                sensor.id, 
                                @report.dateBegin, @report.dateEnd)
      @series_b = Array.new
      samples.each { |sample| 
        @series_b << [ sample.dateTime, sample.value ]
        }
      

      #rescue
      #  flash[:info] = flashString
      #  redirect_to root_path
    end
    
    #  p "count ==> " + samples.count.to_s     
    
    
    #retrieve the corresponding data
    #@series_a= [
    #            [ DateTime.now.iso8601(), 1],
    #            [ DateTime.now.since(1.minutes).iso8601(), 15.2],
    #            [ DateTime.now.since(2.minutes).iso8601(), 15.6],
    #            [ DateTime.now.since(3.minutes).iso8601(), 15.9], 
    #            [ DateTime.now.since(4.minutes).iso8601(), 10.5]
    #           ]
    #@series_b= [
    #              [ DateTime.now , 10] ,
    #              [ DateTime.now.since(1.minutes), 152],
    #              [ DateTime.now.since(2.minutes), 156], 
    #              [ DateTime.now.since(3.minutes), 159] , 
    #              [ DateTime.now.since(4.minutes), 105]
    #           ]

  end
  
end
