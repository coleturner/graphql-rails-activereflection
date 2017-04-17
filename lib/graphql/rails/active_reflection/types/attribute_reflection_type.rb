module GraphQL
  module Rails
    module ActiveReflection
      module Types

        AttributeReflectionType = ::GraphQL::ObjectType.define do
          name AttributeReflection.schema_name

          field :name, !types.String
          field :validators, ValidatorType.to_list_type
          field :validate, ValidationResultType do
            argument :int, types.Int
            argument :str, types.String
            argument :float, types.Float
            argument :bool, types.Boolean

            resolve ->(obj, args, _ctx) do
              values = [args['int'], args['str'], args['float'], args['bool']]
              raise ArgumentError, "Must specify at least one argument" if values.compact.empty?
              raise ArgumentError, "Too many arguments, one expected" if values.compact.size > 1

              value = values.compact.first

              model = obj.klass.new
              model[obj.name] = value

              model.validate!
              ValidationResult.new(model.valid?, model.errors[obj.name])
            end
          end
        end

      end
    end
  end
end
