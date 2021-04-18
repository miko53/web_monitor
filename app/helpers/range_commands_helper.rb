module RangeCommandsHelper
    
    # RangeCommand rangeCommand
    def display_date(day, time)
      #Date::DAYNAMES.zip((0..6).to_a
      if (time != nil) then
        Date::DAYNAMES[day] + ', ' + time.strftime('%H:%M')
      else
        "NA"
      end
    end
    
    def display_actuators(range_command)
        name_list = ""
        range_command.actuators.each do |actuator|
            name_list += actuator.name 
            if (!actuator.equal?(range_command.actuators.last)) then
                name_list += ', '
            end
        end
        
        return name_list
    end
end
