module GraphQL
  module Rails
    module ActiveReflection
      class ModelReflection
        @schema_name = "ActiveReflectionModel"

        def self.call(obj, args, ctx)
          raise UnsupportedObject unless obj < ActiveRecord::Base
          @reflections[obj.class] ||= new(obj.class, ctx.schema)
        end

        attr_reader :attributes

        def initialize(klass, schema)
          @klass = klass
          @type = schema.resolve_type(@klass)
          @schema = schema
          @attributes = @type.fields.map { |field|
            # No reflection if it's not a model attribute
            property = field.property || field.name
            return nil unless klass.attribute_names.include? property

            AttributeReflection.new(field, klass, schema)
          }.compact
        end

        class << self
          attr_accessor :schema_name
        end

      end
    end
  end
end
