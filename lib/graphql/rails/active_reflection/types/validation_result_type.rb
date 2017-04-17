module GraphQL
  module Rails
    module ActiveReflection
      module Types
          ValidationResultType = ::GraphQL::ObjectType.define do
          name ValidationResult.schema_name

          field :valid, types.Boolean
          field :errors, types.String.to_list_type
        end
      end
    end
  end
end
