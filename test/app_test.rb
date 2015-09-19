require "helper"

FULL_STACK_SYNERGY_APP = Rack::Builder.parse_file("config.ru").first

# Not using the mixin because the `app` defined in the other test file, would interfere with an `app` in this test.
def session
  Rack::Test::Session.new(Rack::MockSession.new(FULL_STACK_SYNERGY_APP))
end

def with_session(&block)
  block.call(session)
end

class AppTest < Minitest::Test
  def test_renders_old_page_by_default
    ENV.delete("UNLEASH_THE_KRAKEN")
    with_session do |session|
      session.get "/"
      assert session.last_response.ok?
      assert_includes session.last_response.body, "Animated Tom"
    end
  end

  def test_renders_new_page_with_env_variable
    ENV["UNLEASH_THE_KRAKEN"] = "GO"
    with_session do |session|
      session.get "/"
      assert session.last_response.ok?
      refute_includes session.last_response.body, "Animated Tom"
    end
  end

  def test_renders_new_page_with_specially_crafted_query_string
    ENV.delete("UNLEASH_THE_KRAKEN")
    with_session do |session|
      session.get "/?it=doesnt-matter&as=long&as=it&has=the-following&bob=stinkt"
      assert session.last_response.ok?
      refute_includes session.last_response.body, "Animated Tom"
    end
  end
end
