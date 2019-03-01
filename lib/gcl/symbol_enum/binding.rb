# frozen_string_literal: true

module Gcl
  class SymbolEnum
    #
    # Bind model's attribute to enum serializer
    #
    # noinspection RubyResolve
    module Binding
      module ClassMethods
        def bind_enum_field(model_class, attribute_name, namespace = attribute_name)
          symbols = self

          namespace = namespace&.to_s

          model_class.instance_exec do
            serialize attribute_name, symbols

            symbols.each do |symbol|
              name = [namespace, symbol.to_s].compact!.join('_')
              scope name, -> { where(attribute_name => symbol) }

              class_eval <<-RUBY, __FILE__, __LINE__
            def #{name}?
              #{attribute_name} == :#{symbol}
            end
              RUBY
            end
          end
        end
      end

      def included(klass)
        klass.extend ClassMethods
      end
    end
  end
end