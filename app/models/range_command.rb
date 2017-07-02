# == Schema Information
#
# Table name: range_commands
#
#  id         :integer          not null, primary key
#  name       :string
#  start_time :time
#  stop_time  :time
#  start_day  :integer
#  stop_day   :integer
#  command    :string
#

class RangeCommand < ActiveRecord::Base
   has_and_belongs_to_many :actuators
   
   def inRange?(currentDateTime)
       
       bIsInRange = false
       
       @cwstartDay = getcwday(start_day)
       @cwstopDay = getcwday(stop_day)
       @startTime = start_time.strftime("%H:%M:%S")
       @stopTime = stop_time.strftime("%H:%M:%S")
       
       #p Time.now.strftime("%H:%M:%S %Z")
       if (@cwstartDay <= @cwstopDay) then
           bIsInRange = manage_on_one_week(currentDateTime)
       else
           bIsInRange = manage_on_two_weeks(currentDateTime)
       end
       
       if bIsInRange then
         currentTime = currentDateTime.strftime("%H:%M:%S")
         p "log: currentTime = #{currentTime}, start_time = #{@startTime}, stop_time = #{@stopTime}"
       end

       
       return bIsInRange
   end
   
protected

    def manage_on_one_week(currentDateTime)
        currentTime = currentDateTime.strftime("%H:%M:%S")
        bIsInRange = false
        if ((@cwstartDay == @cwstopDay) && (@cwstartDay == currentDateTime.cwday)) then
            if ((@startTime <= currentTime) && (@stopTime > currentTime)) then
                p '1-is range'
                bIsInRange = true
            end
            return bIsInRange
        end
        
        if (@cwstartDay == currentDateTime.cwday) then
            if (@startTime <= currentTime) then
                p '2-is range'
                bIsInRange = true
            end
            return bIsInRange
        end
        
        if ((@cwstartDay != currentDateTime.cwday) && (@cwstopDay != currentDateTime.cwday)) then
            if (@cwstartDay < currentDateTime.cwday) && (@cwstopDay > currentDateTime.cwday) then
                p '2b-is range'
                bIsInRange = true
            end
            return bIsInRange
        end
        
        if (@cwstopDay == currentDateTime.cwday) then
            if (@stopTime > currentTime) then
                p '3-is range'
                bIsInRange = true
            end
            return bIsInRange
        end
        
        return bIsInRange
    end
    
    def manage_on_two_weeks(currentDateTime)
        currentTime = currentDateTime.strftime("%H:%M:%S")
        bIsInRange = false

        if (@cwstartDay == currentDateTime.cwday) then
            if (@startTime <= currentTime) then
                p '22-is range'
                bIsInRange = true
            end
            return bIsInRange
        end
        
        if ((@cwstartDay != currentDateTime.cwday) && (@cwstopDay != currentDateTime.cwday)) then
            p "log: @cwstartDay=#{@cwstartDay} currentDateTime.cwday = #{currentDateTime.cwday} @cwstopDay = #{@cwstopDay}"
            if (@cwstartDay < currentDateTime.cwday) || (@cwstopDay > currentDateTime.cwday) then
                p '22b-is range'
                bIsInRange = true
            end
            return bIsInRange
        end
        
        if (@cwstopDay == currentDateTime.cwday) then
            if (@stopTime > currentTime) then
                p '23-is range'
                bIsInRange = true
            end
            return bIsInRange
        end
        
       return bIsInRange
    end
   
private

    #all are equivalent except sunday which cwday equals 7 but 0 in RangeCommand
    def getcwday(week)
        rc = week
        if (week == 0) then
            rc = 7
        end
        return rc
    end

end
