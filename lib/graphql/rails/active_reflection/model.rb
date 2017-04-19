module GraphQL::Rails::ActiveReflection
  class Model
    def self.interface
      @interface ||= GraphQL::InterfaceType.define do
        name "ActiveReflectionInterface"
        field('_model', GraphQL::Rails::ActiveReflection::Types::ModelReflectionType, 'Model of attributes for field.')
      end
    end

    def self.field(**kwargs, &block)
      # We have to define it fresh each time because
      # its name will be modified and its description
      # _may_ be modified.
      field = GraphQL::Field.define do
        type(GraphQL::Rails::ActiveReflection::Model.interface)
        description('Fetch the content model for the given object.')
        resolve(GraphQL::Rails::ActiveReflection::Types::ModelReflection)
      end

      if kwargs.any? || block
        field = field.redefine(kwargs, &block)
      end

      field
    end
  end
end
