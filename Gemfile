source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem "database_cleaner"
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'rspec-rails', '~> 3.7'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise', '~> 4.4', '>= 4.4.3'
gem 'paperclip', '~> 5.0'
gem 'aws-sdk', '~> 2'

gem 'bootstrap-sass', '~> 3.4.1'
gem 'jquery-rails'

gem 'wicked_pdf', '~> 1.1'
gem 'wkhtmltopdf-binary', '~> 0.12.3.1'

gem 'envyable', '~> 1.2', groups: [:development, :test]

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

# Use Omniauth plugin
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-linkedin', '~> 0.2.0'
gem 'omniauth-twitter', '~> 1.4'
gem 'omniauth-github', '~> 1.3'
gem 'omniauth-google-oauth2', '~> 0.5.3'

# Use ActiveRecord Sessions
gem "activerecord-session_store", ">= 2.0.0"

gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.4'
