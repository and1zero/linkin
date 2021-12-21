source 'https://rubygems.org'

gem 'rake', '~> 13.0.1'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'
# prefer puma over webrick
gem 'puma', '~> 4.3.9'
# database
gem 'pg'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'capybara'
end

ruby '2.6.6'
