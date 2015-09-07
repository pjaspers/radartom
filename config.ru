require "bundler/setup"

require "shack"
use Rack::Static, :urls => ["/public"]
sha = ENV["SHA"] || "el-inferis"
Shack::Middleware.configure do |shack|
  shack.sha = sha
  shack.content = "<a href='https://github.com/pjaspers/radar-tom/commit/{{sha}}'>{{short_sha}}</a>"
end
use Shack::Middleware

if ENV["RACK_ENV"] == "development"
  require 'sass/plugin/rack'
  use Sass::Plugin::Rack
end

require "./broechem"
run Broechem
