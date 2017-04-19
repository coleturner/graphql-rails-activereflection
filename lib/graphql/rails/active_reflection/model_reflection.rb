module GraphQL::Rails::ActiveReflection
  class ModelReflection
    @schema_name = "ActiveReflectionModel"
    @reflections = {}

    def self.call(obj, args, ctx)
      raise TypeError, "ActiveReflection object type must be derived from ActiveRecord::Base" unless obj.is_a?(ActiveRecord::Base)
      @reflections[obj] ||= new(obj, ctx)
    end

    attr_reader :attributes

    def initialize(obj, ctx)
      @klass = obj.class
      @type = ctx.schema.resolve_type(obj, ctx)
      @schema = ctx.schema
      @attributes = @type.fields.map { |name, field|
        # No reflection if it's not a model attribute
        property = field.property || name
        if @klass.attribute_names.include? property
          GraphQL::Rails::ActiveReflection::AttributeReflection.new(field, @klass, @schema)
        end
      }.compact
    end

    class << self
      attr_accessor :schema_name
    end

  end
end
