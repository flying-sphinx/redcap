require 'rubygems'
require 'bundler'

$:.unshift File.dirname(__FILE__) + '/../lib'
$:.unshift File.dirname(__FILE__) + '/..'

Bundler.require :default, :development

require 'redcap'

RSpec.configure do |config|
  
end
