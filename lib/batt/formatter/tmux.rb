module Batt
  module Formatter
    class Tmux

      class << self

        def format(string, options={})
          fg = options[:fg]
          bg = options[:bg]

          color_string = [ bg_color(bg), fg_color(fg) ].compact.join(',')

          if color_string.length > 0
            "#[#{ color_string }]#{ string }#[default]"
          else
            string
          end
        end

        def bg_color(color)
          return nil unless color

          "bg=#{ color }"
        end

        def fg_color(color)
          return nil unless color

          "fg=#{ color }"
        end

      end

    end
  end
end
