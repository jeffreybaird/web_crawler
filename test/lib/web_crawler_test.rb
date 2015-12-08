require_relative '../test_helper'

class WebCrawlerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::WebCrawler::VERSION
  end

end
