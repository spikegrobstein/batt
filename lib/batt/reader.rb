module Batt
  class Reader

    attr_accessor :battery_reader

    def initialize
      os = get_os
      case os
      when :darwin
        @battery_reader = lambda { parse_battery_status_osx(get_battery_status_osx) }
      else
        raise "Unsupported OS: #{ os }"
      end
    end

    # runs the batteryreader
    # this could probably be refactored to leverage a class per OS
    def status
      @battery_reader.call
    end

    # figure out which OS is running
    # this might need to be a little more solid
    # returns a downcased symbol (eg: +:darwin+ or +:linux+)
    def get_os
      line = Cocaine::CommandLine.new('uname')
      output = line.run

      output.chomp.downcase.intern
    end

    # get the battery status for OSX
    # returns a hash.
    # spits out something like:
    # Currently drawing from 'AC Power'
    # -InternalBattery-0     98%; charging; 0:30 remaining
    # TODO: write some docs
    def get_battery_status_osx
      line = Cocaine::CommandLine.new('pmset', '-g batt')
      output = line.run
    end

    def parse_battery_status_osx(output)
      output = output.split(/\n/)
      status = output.shift.scan(/'(.+?)'/).first
      result = status + output.shift.scan(/(\d+%);\s*(.+?);\s*(.+)/).first

      Hash[[:source, :capacity, :status, :remaining].zip(result)]
    end

    class << self

      # Given a capacity percentage, return the color
      def color_for_capacity(capacity)
        case capacity.to_i
        when -100..20 then :red # if there's any weird errors where things go negative, be red.
        when 20..30 then :orange
        when 30..75 then :yellow
        else
          :green
        end
      end
    end
  end
end
