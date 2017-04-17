ModelReflectionType = ::GraphQL::ObjectType.define do
  name Recline::GraphQL::ModelReflection.schema_name
  field :attributes, AttributeReflectionType.to_list_type
end
