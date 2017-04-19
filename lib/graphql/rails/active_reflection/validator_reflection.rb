require 'active_model'
require 'active_model/validations'
require 'active_model/validations/absence'
require 'active_model/validations/exclusion'
require 'active_model/validations/format'
require 'active_model/validations/inclusion'
require 'active_model/validations/length'
require 'active_model/validations/presence'
require 'active_record/validations'
require 'active_model/validations/absence'
require 'active_model/validations/length'
require 'active_model/validations/presence'
require 'active_record/validations/uniqueness'


module GraphQL::Rails::ActiveReflection
  class ValidatorReflection
    @schema_name = "ActiveReflectionValidator"

    attr_reader :validator

    def initialize(validator)
      @validator = validator
    end

    def absence
      true if [
        ActiveModel::Validations::AbsenceValidator,
        ActiveRecord::Validations::AbsenceValidator
      ].any? { |klass| @validator.is_a? klass }
    end

    def presence
      true if [
        ActiveModel::Validations::PresenceValidator,
        ActiveRecord::Validations::PresenceValidator
      ].any? { |klass| @validator.is_a? klass }
    end

    def uniqueness
      true if @validator.is_a? ActiveRecord::Validations::UniquenessValidator
    end

    def with_format
      return nil unless @validator.is_a? ActiveModel::Validations::FormatValidator
      @validator.options[:with]
    end

    def without_format
      return nil unless @validator.is_a? ActiveModel::Validations::FormatValidator
      @validator.options[:without]
    end

    def min_length
      return nil unless [
        ActiveModel::Validations::LengthValidator,
        ActiveRecord::Validations::LengthValidator
      ].any? { |klass| @validator.is_a? klass }
      @validator.options[:minimum]
    end

    def max_length
      return nil unless [
        ActiveModel::Validations::LengthValidator,
        ActiveRecord::Validations::LengthValidator
      ].any? { |klass| @validator.is_a? klass }
      @validator.options[:maximum]
    end

    def inclusion
      return nil unless @validator.is_a? ActiveModel::Validations::InclusionValidator
      return nil if @validator.options[:in].respond_to? :call
      @validator.options[:in]
    end

    def exclusion
      return nil unless @validator.is_a? ActiveModel::Validations::ExclusionValidator
      return nil if @validator.options[:in].respond_to? :call
      @validator.options[:in]
    end

    # TODO NumericalityValidator
    # TODO AcceptanceValidator (is this relevant anymore?)

    class << self
      attr_accessor :schema_name
    end
  end
end
