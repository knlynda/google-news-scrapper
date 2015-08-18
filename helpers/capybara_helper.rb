require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
require 'yaml'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome
Capybara.current_driver = :chrome