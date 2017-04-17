require 'graphql'
require 'graphql/rails/active_reflection/model_reflection'
require 'graphql/rails/active_reflection/attribute_reflection'
require 'graphql/rails/active_reflection/validation_result'
require 'graphql/rails/active_reflection/validator_reflection'
require 'graphql/rails/active_reflection/types'

module GraphQL
  module Rails
    module ActiveReflection
      VERSION = '0.1.0'

      class UnsupportedObject < StandardError; end

      class Model
        def self.interface
          @interface ||= GraphQL::InterfaceType.define do
            name "ActiveReflectionInterface"
            field('_model', ModelReflectionType, 'Model of attributes for field.')
          end
        end

        def self.field(**kwargs, &block)
          # We have to define it fresh each time because
          # its name will be modified and its description
          # _may_ be modified.
          field = GraphQL::Field.define do
            type(GraphQL::Rails::ActiveReflection::Model.interface)
            description('Fetch the content model for the given object.')
            resolve(ModelReflection)
          end

          if kwargs.any? || block
            field = field.redefine(kwargs, &block)
          end

          field
        end
      end
    end
  end
end
