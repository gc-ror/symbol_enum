# frozen_string_literal: true

module Gcl
  module SymbolEnum
    class Group
      attr_reader :name, :items, :index

      def initialize(schema, name, items)
        @name = name

        @items = items.map do |item|
          if item.is_a? Group
            item.items
          elsif schema.group_index.key? item
            schema.group_index[item].items
          elsif schema.index.key? item
            [schema.index[item]]
          else
            raise
          end
        end.flatten

        @index = {}
        @items.each do |item|
          @index[item.to_i] = item
          @index[item.to_s] = item
          @index[item.to_sym] = item
          @index[item] = item
        end
      end

      def ===(other)
        index.key? other
      end
    end
  end
end
