require "bundler/setup"
require "shack"

# The new app:
# - sets up [Shack](https://github.com/pjaspers/shack) to see what version is deployed
# - compiles the sass (in development)
# - Fires up the Broechem Sinatra app
broechem_city = Rack::Builder.new do
  use Rack::Static, :urls => ["/img", "/stylesheets"], root: "public"
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
end

# The old app:
# - shows el @inferis disguised as Dennis Nedry
old_app = Rack::Builder.new do
  use Rack::Static, :urls => ["/img", "/stylesheets"], root: "public"
  run -> (env) {
    [
      200,
      {
        'Content-Type'  => 'text/html',
        'Cache-Control' => 'public, max-age=86400'
      },
      File.open('public/old-front.html', File::RDONLY)
    ]
  }
end

# Since we're doing this in complete stealth mode, only show the new app, when:
# - a config variable is set, `UNLEASH_THE_KRAKEN` needs to be truthy
# - or when asked via query string
run -> (env) {
  if ENV["UNLEASH_THE_KRAKEN"] || env["QUERY_STRING"].include?("bob=stinkt")
    broechem_city.call(env)
  else
    old_app.call(env)
  end
}
