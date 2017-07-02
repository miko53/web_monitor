
class CommandSchedule
    
    def self.schedule
        
        now = DateTime.now
        
        now = DateTime.new(2017, 7, 3, 15, 0, 0)
        
        puts "shedule heating operation launched at #{now}"
        
        scheduledOperation = RangeCommand.all
        scheduledOperation.each do |currentOperation|
          #p currentOperation 
          #check if dateTime current correspond to the given range.
          if (currentOperation.inRange?(now)) then
              #take all heaters and applies the command is the current command is not the good one
              p 'is in range'
              currentOperation.actuators.each do |currentHeader|
                  p "#{currentHeader.name}: apply new command #{currentOperation.command}"
                  if (currentHeader.value == currentOperation.command) then
                      p "#{currentHeader.name}: nothing to do, command is already set"
                  else
                      p "#{currentHeader.name}: apply new command #{currentOperation.command}"
                      send_command(currentHeader, currentOperation.command)
                  end
              end
          end
        end
    end
    
private

    def self.send_command(heater, command)
        output = open("my_pipe", "w+") # the a for append at the end
        output.puts "#{heater.device.address};#{command}"
        output.flush
        #output.close
    end
    
end

    
