# frozen_string_literal: true

module Gcl
  module SymbolEnum
    #
    # Value
    #
    class Value
      attr_reader :id, :symbol, :text, :options

      def initialize(id, symbol, text, **options)
        @id = id
        @symbol = symbol
        @text = text
        @options = options
      end

      #
      # Class structure
      #

      class << self
        attr_reader :items
        attr_reader :index
        attr_reader :groups
        attr_reader :group_index

        include Enumerable

        def each(&block)
          items.each &block
        end
      end

      def self.[](value)
        # noinspection RubyResolve
        index[value]
      end

      def self.inherited(base_class)
        base_class.class_eval do
          @items = []
          @index = {}
          @groups = []
          @group_index = {}
        end
      end

      #
      # Methods for domain specific language.
      #

      def self.item(id, name, text, **options)
        raise if index.key? id
        raise if index.key? name
        raise if group_index.key? name

        i = new(id, name, text, **options)

        items << i

        index[id] = i
        index[name] = i
        index[name.to_s] = i
        index[i] = i

        define_singleton_method name do
          return i
        end
      end

      def self.group(name, items)
        raise if index.key? name
        raise if group_index.key? name

        g = Group.new(self, name, items)

        groups << g

        group_index[name] = g
        group_index[name.to_s] = g

        define_singleton_method name do
          return g
        end
      end

      #
      # Methods for equivalence
      #

      def ==(other)
        case other
        when Integer
          to_i == other
        when String
          to_s == other
        when Symbol
          to_sym == other
        when self.class
          self.__id__ == other.__id__
        else
          false
        end
      end

      def !=(other)
        !(self == other)
      end

      alias === ==

      #
      # Methods of type conversion
      #

      alias to_i id
      alias to_sym symbol

      def to_s
        to_sym.to_s
      end

      #
      # Methods for serializing
      #

      def self.load(value)
        case value
        when Integer, Symbol, String, self, NilClass
          index[value]
        else
          raise TypeError
        end
      end

      def self.dump(value)
        # noinspection RubyResolve
        load(value)&.to_i
      end
    end
  end
end
