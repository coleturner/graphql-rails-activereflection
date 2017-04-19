module GraphQL::Rails::ActiveReflection
  class AttributeReflection
    @schema_name = "ActiveReflectionAttribute"

    attr_reader :klass
    attr_reader :name
    attr_reader :field_name
    attr_reader :description
    attr_reader :validators

    def initialize(field, klass, schema)
      @klass = klass
      @field_name = field.name
      @name = field.property || field.name
      @validators = klass.validators.map { |validator|
        # Skip if the validator does not apply to this field
        # Skip if there are :if or :unless options (conditionals purposely unsupported)
        next if validator.attributes.exclude?(@name.to_sym) || validator.options[:if].present? || validator.options[:unless].present?
        GraphQL::Rails::ActiveReflection::ValidatorReflection.new(validator)
      }.compact
      @errors = []
    end

    class << self
      attr_accessor :schema_name
    end
  end
end
