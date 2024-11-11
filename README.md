# Soter

Soter is a different way of thinking about field-level security in your rails application.  This started with a friend asking me for some thoughts on their rails app, which I added, [then blogged about](https://0x69616e.com/posts/data-security-done-right/) and then used this as the inspiration for creating my own gem.  This was meant to be something rails specific -- if you want to implement it in a different way, feel free to fork and implement as needed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'soter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install soter

## Usage

Once the gem is installed, you can add the grading to your model:

```
class Patient < ApplicationRecord
  include Soter::GradedAccessControl

  # Grading fields with sensitive data
  grade_field :name, :public
  grade_field :dob, :PII
  grade_field :medical_history, :PHI
end
```

Then, enable that user to access the specific grades, their role must include the `:PHI` tag:

```
# app/models/user.rb
class User < ApplicationRecord
  has_many :roles

  def has_role_for_grade?(grade)
    roles.exists?(grade: grade)
  end
end

# app/models/role.rb
class Role < ApplicationRecord
  belongs_to :user

  validates :grade, inclusion: { in: [:public, :PII, :PHI, :PCI] }
end
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/uid0/soter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Soter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/uid0/soter/blob/master/CODE_OF_CONDUCT.md).
