module GraphQL
  module Rails
    module ActiveReflection
      module Types
        ModelReflectionType = ::GraphQL::ObjectType.define do
          name ModelReflection.schema_name
          field :attributes, AttributeReflectionType.to_list_type
        end
      end
    end
  end
end
