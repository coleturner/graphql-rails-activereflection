# GraphQL::Rails::ActiveReflection
## (graphql-rails-activereflection)
Reflection over GraphQL for ActiveRecord models and validators

# What is it?
The purpose of this gem is to enable ActiveRecord reflections on models over GraphQL.

At release, this gem only contains reflections on validators. This is to avoid duplication and doubling up on the front-end for how to validate form inputs.

Eventually I would like to include some React examples and sample container components to apply the validators.

# Installation
To begin, install the gem by adding it to the `Gemfile`:

```ruby
  gem 'graphql-rails-activereflection'
```

You're now ready to expose validators for your GraphQL Fields.  This only works for fields that resolve to ActiveRecord Models.

To expose a field, add the following line:

```ruby
  implements GraphQL::Rails::ActiveReflection::Model.interface, inherit: true
```

And that's it! This will add a `_model` field to the object type and enables the following query:

```graphql
fragment on YourObjectType {
  _model {
    attributes {
      name

      validators {
        abscence: Boolean
        prescence: Boolean
        uniqueness: Boolean
        with_format: String
        without_format: String
        min_length: Integer
        max_length: Integer
        inclusion: [String]
        exclusion: [String]
      }

      validate(int: Integer, str: String, float: Float, bool: Boolean) {
        valid: Boolean
        errors: [String]
      }
    }
  }
}
```

Each of the validators corresponds to the standard Rails validators. Almost all validators for an attribute will be returned, **except those that have the `if` or `unless` conditionals.** This is by design and therefore make note that any conditional validations will have to be performed manually.

There is also the `validate(...)` field with arguments for standard scalar types. Any one of the arguments can be provided, but only one. The result will contain a `valid` boolean and a list of `errors` strings returned from the validators.

## Direction
Future plans for this module are to expose any reflections for an ActiveRecord model.

# Needs Help
If you wish to contribute to this project, any pull request is warmly welcomed.

- [ ] Documentation
- [ ] Examples
- [ ] Unit Tests

# Credits
- Cole Turner ([@colepatrickturner](https://github.com/colepatrickturner))
