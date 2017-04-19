module GraphQL::Rails::ActiveReflection
  class ValidationResult
    @schema_name = "ActiveReflectionValidation"

    attr_reader :valid
    attr_reader :errors

    def initialize(valid, errors)
      @valid = valid
      @errors = errors
    end

    class << self
      attr_accessor :schema_name
    end
  end
end
