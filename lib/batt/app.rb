# encoding: utf-8

require 'pry'
module Batt
  class App < Thor

    desc "all", "spit out the full battery status"
    # option :tmux, :type => :boolean
    # option :ansi, :type => :boolean
    def all
      b = Batt::Reader.new
      result = b.status

      size = result.keys.map{ |k| k.length }.reduce(0) { |m, l| m = l if l > m; m }
      result.each do |k,v|
        puts "%#{ size }s: %s" % [ k, v ]
      end

    end

    desc "source", "spit out the current source of power (AC or battery)"
    def source
      b = Batt::Reader.new

      puts b.status[:source]
    end

    desc "capacity", "spit out the current capacity in % of the battery"
    option :tmux, :type => :boolean, :desc => 'Enable tmux colour'
    def capacity
      b = Batt::Reader.new

      c = b.status[:capacity]

      if options[:tmux]
        color = Reader.color_for_capacity(c.to_i)
        puts Formatter::Tmux.format c, :fg => :black, :bg => color
      else
        puts c
      end
    end

    desc "status", "spit out the status of the battery"
    def status
      b = Batt::Reader.new
      result = b.status

      puts b.status[:status]
    end

    desc "remaining", "spit out the remaining time for the battery"
    def remaining
      b = Batt::Reader.new

      puts b.status[:remaining]
    end

    desc "meter", "return an ascii-art battery meter showing the current capacity."
    option :tmux, :type => :boolean, :desc => "Enable tmux colour"
    option :size, :type => :numeric, :desc => "The size of the meter", :default => 5
    def meter
      b = Batt::Reader.new

      c = b.status[:capacity].to_i

      meter_size = options[:size]
      meter_filled_level = (meter_size * ( c.to_f / 100 )).round

      if options[:tmux]
        meter_filled = "█" * (meter_filled_level)
        meter_empty = " " * (meter_size - meter_filled_level)
        color = Reader.color_for_capacity(c)

        puts "[#{ Formatter::Tmux.format meter_filled, :fg => color }#{ meter_empty }]"
      else
        puts "[#{ "█" * meter_filled_level }#{ ' ' * (meter_size - meter_filled_level) }]"
      end
    end

  end
end



