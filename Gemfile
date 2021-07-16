source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'jquery-rails'
gem 'pry-rails'
gem 'puma', '~> 5.0'
gem 'rails-i18n'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rubocop-rails', require: false
  gem 'sqlite3'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'web-console', '>= 4.1.0'
end

group :production do
  gem 'mailjet'
  gem 'pg', '~> 1.1'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
