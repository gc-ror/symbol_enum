# frozen_string_literal: true

# noinspection RubyResolve
require 'gcl/symbol_enum/version'

module Gcl
  #
  # Symbol Enumerator
  #
  class SymbolEnum
    attr_reader :id, :symbol, :text

    extend Enumerable

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
      !(self == (other))
    end

    def self.each(&block)
      values.each(&block)
      self
    end

    def self.declare(&block)
      raise 'already declared.' unless values.nil?

      @values = []
      @index = {}

      instance_exec(&block)

      values.freeze
      index.freeze
    end

    def self.item(*args)
      v = new(*args).freeze
      values << v

      raise if index.key?(v.id) || index.key?(v.to_s) || index.key?(v.to_sym)

      index[v.to_i] = v
      index[v.to_s] = v
      index[v.to_sym] = v

      define_singleton_method(v.to_sym) { v }
    end

    def self.load(value)
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

    def self.[](value)
      load(value)
    end

    def self.value
      # code here
    end

    def self.dump(value)
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

    class << self
      private

      attr_reader :values, :index
    end

    private_class_method :new
  end
end
