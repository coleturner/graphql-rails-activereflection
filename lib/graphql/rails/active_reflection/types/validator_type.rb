GraphQL::Rails::ActiveReflection::Types::ValidatorType = GraphQL::ObjectType.define do
  name GraphQL::Rails::ActiveReflection::ValidatorReflection.schema_name

  field :absence, types.Boolean
  field :presence, types.Boolean
  field :uniqueness, types.Boolean
  field :with_format, types.String
  field :without_format, types.String
  field :min_length, types.Int
  field :max_length, types.Int
  field :inclusion, types.String.to_list_type
  field :exclusion, types.String.to_list_type
end
