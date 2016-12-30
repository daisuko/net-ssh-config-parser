require "net/ssh/config/parser/version"

module Net
  module SSH
    class Config
      module Parser
        class << self
          def load(filename)
            return nil unless File.exist?(filename)

            parse(open(filename, &:read))
          end

          def parse(value)
            inner_parse(value.lines.map(&:chomp).reject { |line| line.empty? })
          end

          private

          def inner_parse(lines, hosts = {})
            first, rest = lines[0], lines[1..-1]
            key, *names = first.split(' ')
            options, rest = option_parse(rest)
            ret = hosts.merge(names.each_with_object({}) { |e, a| a[e] = options })

            rest.empty? ? ret : inner_parse(rest, ret)
          end

          def option_parse(lines, options = {})
            first, rest = lines[0], lines[1..-1]

            if rest && first.start_with?(' ')
              key, value = first.split(' ', 2)

              option_parse(rest, options.merge(key => cast(value)))
            else
              [options, lines]
            end
          end

          def cast(value)
            case value
            when /^\d+$/  then value.to_i
            when /^yes$/i then true
            when /^no$/i  then false
            else value
            end
          end
        end
      end
    end
  end
end
