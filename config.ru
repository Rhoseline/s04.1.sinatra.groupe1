require 'bundler'
Bundler.require
require 'csv'
require 'json'

$:.unshift File.expand_path("./../lib", __FILE__)
require 'controller'

run ApplicationController
