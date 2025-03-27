source 'https://rubygems.org'

ruby '3.3.4'

gem 'devise'
gem 'devise-jwt'
gem 'rails', '~> 8.0.2'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'ransack', github: 'activerecord-hackery/ransack'
gem 'enumerate_it'
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]
gem 'bootsnap', require: false
gem 'jsonapi-rails'
gem 'kaminari'
gem 'rack-cors'
gem 'active_model_serializers'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner-active_record'
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'parallel_tests'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
