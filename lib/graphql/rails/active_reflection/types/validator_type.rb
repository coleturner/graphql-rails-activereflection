module GraphQL
  module Rails
    module ActiveReflection
      module Types
        ValidatorType = ::GraphQL::ObjectType.define do
          name ValidatorReflection.schema_name
          # TODO NumericalityValidator

          field :abscence, types.Boolean do
            resolve ->(obj, _args, _ctx) do
              obj < ActiveModel::Validations::AbsenceValidator
            end
          end

          field :prescence, types.Boolean do
            resolve ->(obj, _args, _ctx) do
              obj < ActiveModel::Validations::PrescenceValidator
            end
          end

          field :uniqueness, types.Boolean do
            resolve ->(obj, _args, _ctx) do
              obj < ActiveModel::Validations::UniquenessValidator
            end
          end

          field :with_format, types.String do
            resolve ->(obj, _args, _ctx) do
              return nil unless obj < ActiveModel::Validations::FormatValidator
              obj.options[:with]
            end
          end

          field :without_format, types.String do
            resolve ->(obj, _args, _ctx) do
              return nil unless obj < ActiveModel::Validations::FormatValidator
              obj.options[:without]
            end
          end

          field :min_length, types.Int do
            resolve ->(obj, _args, _ctx) do
              return nil unless obj < ActiveModel::Validations::LengthValidator
              obj.options[:minimum]
            end
          end

          field :max_length, types.Int do
            resolve ->(obj, _args, _ctx) do
              return nil unless obj < ActiveModel::Validations::LengthValidator
              obj.options[:maximum]
            end
          end

          field :inclusion, types.String.to_list_type do
            resolve ->(obj, _args, _ctx) do
              return nil unless obj < ActiveModel::Validations::InclusionValidator
              return nil if obj.options[:in].respond_to? :call
              obj.options[:in]
            end
          end

          field :exclusion, types.String.to_list_type do
            resolve ->(obj, _args, _ctx) do
              return nil unless obj < ActiveModel::Validations::ExclusionValidator
              return nil if obj.options[:in].respond_to? :call
              obj.options[:in]
            end
          end

          # TODO AcceptanceValidator (is this relevant anymore?)

        end
      end
    end
  end
end
