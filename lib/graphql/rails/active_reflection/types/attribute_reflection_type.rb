GraphQL::Rails::ActiveReflection::Types::AttributeReflectionType = GraphQL::ObjectType.define do
  name GraphQL::Rails::ActiveReflection::AttributeReflection.schema_name

  field :name, !types.String
  field :field_name, !types.String
  field :validators, GraphQL::Rails::ActiveReflection::Types::ValidatorType.to_list_type
  field :validate, GraphQL::Rails::ActiveReflection::Types::ValidationResultType do
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
      GraphQL::Rails::ActiveReflection::ValidationResult.new(model.valid?, model.errors[obj.name])
    end
  end
end
