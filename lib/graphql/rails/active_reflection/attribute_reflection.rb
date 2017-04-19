module GraphQL::Rails::ActiveReflection
  class AttributeReflection
    @schema_name = "ActiveReflectionAttribute"

    attr_reader :klass
    attr_reader :name
    attr_reader :description
    attr_reader :validators

    def initialize(field, klass, schema)
      @klass = klass
      @name = field.property || field.name
      @validators = klass.validators.map { |validator|
        return nil if validator.attributes.exclude? @name
        return nil if validator.options[:if].present?
        return nil if validator.options[:unless].present?

        ValidatorReflection.new(validator)
      }.compact
      @errors = []
    end

    class << self
      attr_accessor :schema_name
    end
  end
end
