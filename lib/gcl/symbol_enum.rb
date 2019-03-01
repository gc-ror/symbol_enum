# frozen_string_literal: true

require_relative 'symbol_enum/version'
require_relative 'symbol_enum/serializer'
require_relative 'symbol_enum/dsl'
require_relative 'symbol_enum/binding'

module Gcl
  #
  # Symbol Enumerator
  #
  class SymbolEnum
    extend Serializer
    extend DSL
    extend Enumerable

    class << self
      private

      # noinspection RubyResolve
      attr_reader :values, :index
    end

    attr_reader :id, :symbol, :text

    #
    # @param [Integer] id
    # @param [Symbol] symbol
    # @param [Text] text
    #
    def initialize(id, symbol, text)
      @id = id
      @symbol = symbol
      @text = text
    end

    def to_s
      symbol.to_s
    end

    alias to_i id
    alias to_sym symbol
    alias inspect to_s

    def ==(other)
      case other
      when self.class
        id == other.id
      when Integer
        id == other
      when Symbol
        symbol == other
      when String
        to_s == other
      else
        false
      end
    end

    def !=(other)
      !(self == other)
    end

    private_class_method :new
  end
end
