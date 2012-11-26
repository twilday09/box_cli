require 'active_support/inflector'
require 'active_support/core_ext/hash'
require 'active_support/ordered_hash'

module BoxCli
  module HashToPretty
    def to_pretty(indent = 0)
      "".tap do |s|
        indifferent = self.with_indifferent_access
        keys = self.keys.map(&:to_s)
        keys.sort! unless ActiveSupport::OrderedHash === self
        humanized = keys.inject({}) { |m, k| m[k] = k.humanize; m }
        max_length = humanized.values.map(&:length).max
        keys.each do |key|
          s << "".ljust(indent) << (humanized[key] + ': ').ljust(max_length + 2)
          if Hash === indifferent[key]
            s.strip! << "\n"
            hash = indifferent[key]
            hash.extend HashToPretty
            s << hash.to_pretty(indent + 3)
          else
            s << indifferent[key].to_s << "\n"
          end
        end
      end
    end
  end
end