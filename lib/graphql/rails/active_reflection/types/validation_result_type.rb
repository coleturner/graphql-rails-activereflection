GraphQL::Rails::ActiveReflection::Types::ValidationResultType = GraphQL::ObjectType.define do
  name ValidationResult.schema_name

  field :valid, types.Boolean
  field :errors, types.String.to_list_type
end
