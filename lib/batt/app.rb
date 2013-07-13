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
        color = %w(red yellow green)[c.to_i / 33]
        puts "#[bg=#{color},fg=black]#{ c }#[default]"
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

  end
end



