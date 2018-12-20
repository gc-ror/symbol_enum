# frozen_string_literal: true

class SymbolEnum
  #
  # Bind model's attribute to enum serializer
  #
  # noinspection RubyResolve
  module Binding
    def bind(model_class, attribute_name, namespace = attribute_name)
      symbols = self

      namespace = namespace&.to_s

      model_class.instance_exec do
        serialize attribute_name, symbols

        symbols.each do |symbol|
          name = [namespace, symbol.to_s].compact!.join('_')
          scope name, -> { where(attribute_name => symbol) }

          class_eval <<-RUBY, __FILE__ , __LINE__
            def #{name}?
              #{attribute_name} == #{symbol}
            end
          RUBY
        end
      end
    end
  end
end
