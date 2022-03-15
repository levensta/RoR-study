# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/ft_wikipedia'

class Ft_wikipediaTest < Minitest::Test
  def test_version
    refute_nil ::Ft_wikipedia::VERSION
  end

  def test_phil_reached
    print "\n"
    r = Ft_wikipedia.search('Oasis (band)')
    assert false unless r == 7
    puts("=>#{r}")

    print "\n"
    r = Ft_wikipedia.search('philosophy')
    assert false unless r == 1
    puts("=>#{r}")
  end

  def test_loop
    print "\n"
    r = Ft_wikipedia.search('C.S.Lewis')
    assert false unless r.nil?
    puts("=>#{r.inspect}")
  end

  def test_dead_end
    print "\n"
    r = Ft_wikipedia.search('42 (number)')
    assert false unless r.nil?
    puts("=>#{r.inspect}")
  end
end
