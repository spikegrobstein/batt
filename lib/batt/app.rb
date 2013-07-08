module Batt
  class App < Thor

    desc "status", "spit out the full battery status"
    # option :tmux, :type => :boolean
    # option :ansi, :type => :boolean
    def status
      b = Batt::Reader.new
      result = b.status

      size = result.keys.map{ |k| k.length }.reduce(0) { |m, l| m = l if l > m; m }
      result.each do |k,v|
        puts "%#{ size }s: %s" % [ k, v ]
      end

    end

  end
end



