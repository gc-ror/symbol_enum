# frozen_string_literal: true

class SymbolEnum
  module Serializer
    def load(value)
      case value
      when Integer, Symbol, String
        index[value]
      when self
        index[value.id]
      when NilClass
        nil
      else
        raise TypeError
      end
    end

    def [](value)
      # noinspection RubyResolve
      load(value)
    end

    def dump(value)
      case value
      when Integer, Symbol, String
        index[value]&.to_i
      when self
        index[value.id]&.to_i
      when NilClass
        nil
      else
        raise TypeError
      end
    end
  end
end
