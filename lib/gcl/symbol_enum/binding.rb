# frozen_string_literal: true

module Gcl
  module SymbolEnum
    #
    # Bind model's attribute to enum serializer
    #
    # noinspection RubyResolve
    module Binding
      def bind_enum_field(attribute_name, value_class, namespace: attribute_name)
        model_class = self

        namespace = namespace&.to_s

        model_class.instance_exec do
          serialize attribute_name, value_class

          value_class.items.each do |item|
            name = [namespace, item.to_s].compact.join('_')

            scope name, -> { where(attribute_name => item) }

            model_class.define_method "#{name}?" do
              item === send(attribute_name)
            end
          end

          value_class.groups.each do |group|
            name = [namespace, group.name.to_s].compact.join('_')

            scope name, -> { where(attribute_name => group.items) }

            model_class.define_method "#{name}?" do
              group === send(attribute_name)
            end
          end
        end
      end
    end
  end
end
