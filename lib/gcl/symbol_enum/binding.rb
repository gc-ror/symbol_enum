# frozen_string_literal: true

class SymbolEnum
  module Binding
    def bind(model_class, attribute_name, namespace = attribute_name)
      symbols = self

      namespace = namespace&.to_s

      model_class.instance_exec do
        serialize attribute_name, symbols

        symbols.each do |symbol|
          name = [namespace, symbol.to_s].compact!.join('_')
          scope name, -> { where(attribute_name => symbol) }

          define_method "#{name}?", <<-RUBY
            #{attribute_name} == #{symbol.to_s}
          RUBY
        end
      end
    end
  end
end
