# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/deepthought'

class DeepthoughtTest < Minitest::Test
  def test_version
    refute_nil ::Deepthought::VERSION
  end

  def test_object
    assert(Deepthought.new.class, Deepthought)
  end

  def test_value
    assert(Deepthought.new.respond('The Ultimate Question of Life, the Universe and Everything'), '42')
    assert(Deepthought.new.respond('Ruby is fun stuff'), "Mmmm i'm bored")
  end
end
