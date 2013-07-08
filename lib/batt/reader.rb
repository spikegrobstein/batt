module Batt
  class Reader

    attr_accessor :battery_reader

    def initialize
      os = get_os
      case os
      when :darwin
        @battery_reader = lambda { get_battery_status_osx }
      else
        raise "Unsupported OS: #{ os }"
      end
    end

    def status
      @battery_reader.call
    end

    # figure out which OS is running
    # this might need to be a little more solid
    # returns a downcased symbol
    def get_os
      line = Cocaine::CommandLine.new('uname')
      output = line.run

      output.chomp.downcase.intern
    end

    # get the battery status for OSX
    # returns a hash.
    # TODO: write some docs
    def get_battery_status_osx
      line = Cocaine::CommandLine.new('pmset', '-g batt')
      output = line.run

      # spits out something like:
      # Currently drawing from 'AC Power'
      # -InternalBattery-0     98%; charging; 0:30 remaining

      output = output.split(/\n/)
      status = output.shift.scan(/'(.+?)'/).first
      result = status + output.shift.scan(/(\d+%);\s*(.+?);\s*(.+)/).first

      Hash[[:source, :capacity, :status, :remaining].zip(result)]
    end
  end
end
