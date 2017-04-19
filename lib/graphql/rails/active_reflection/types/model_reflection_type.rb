GraphQL::Rails::ActiveReflection::Types::ModelReflectionType = GraphQL::ObjectType.define do
  name GraphQL::Rails::ActiveReflection::ModelReflection.schema_name
  field :attributes, GraphQL::Rails::ActiveReflection::Types::AttributeReflectionType.to_list_type
end
