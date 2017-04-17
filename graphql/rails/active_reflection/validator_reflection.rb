module GraphQL
  module Rails
    module ActiveReflection
      class ValidatorReflection
        @schema_name = "ActiveReflectionValidator"

        attr_reader :validator

        def initialize(validator)
          @validator = validator
        end

        def abscence
          @validator < ActiveModel::Validations::AbsenceValidator
        end

        def prescence
          resolve ->(obj, _args, _ctx) do
            @validator < ActiveModel::Validations::PrescenceValidator
          end
        end

        def uniqueness
          @validator < ActiveModel::Validations::UniquenessValidator
        end

        def with_format
          return nil unless @validator < ActiveModel::Validations::FormatValidator
          @validator.options[:with]
        end

        def without_format
          return nil unless @validator < ActiveModel::Validations::FormatValidator
          @validator.options[:without]
        end

        def min_length
          return nil unless @validator < ActiveModel::Validations::LengthValidator
          @validator.options[:minimum]
        end

        def max_length
          return nil unless @validator < ActiveModel::Validations::LengthValidator
          @validator.options[:maximum]
        end

        def inclusion
          return nil unless @validator < ActiveModel::Validations::InclusionValidator
          return nil if @validator.options[:in].respond_to? :call
          @validator.options[:in]
        end

        def exclusion
          return nil unless @validator < ActiveModel::Validations::ExclusionValidator
          return nil if @validator.options[:in].respond_to? :call
          @validator.options[:in]
        end

        class << self
          attr_accessor :schema_name
        end
      end
    end
  end
end
