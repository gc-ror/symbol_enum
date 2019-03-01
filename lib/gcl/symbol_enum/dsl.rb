# frozen_string_literal: true

module Gcl
  class SymbolEnum
    module DSL

      def declare(&block)
        raise 'already declared.' unless values.nil?

        @values = []
        @index = {}

        instance_exec(&block)

        values.freeze
        index.freeze
      end

      def item(*args)
        v = new(*args).freeze
        values << v

        raise if index.key?(v.id) || index.key?(v.id.to_s) || index.key?(v.to_s) || index.key?(v.to_sym)

        index[v.to_i] = v
        index[v.to_i.to_s] = v
        index[v.to_s] = v
        index[v.to_sym] = v

        define_singleton_method(v.to_sym) { v }
      end

      def each(&block)
        values.each(&block)
        self
      end

    end
  end
end