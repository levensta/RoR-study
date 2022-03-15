# frozen_string_literal: true

require_relative 'ft_wikipedia/version'
require 'nokogiri'
require 'open-uri'

class Ft_wikipedia
  def self.search(subject)
    so_far = []
    about = subject
    about = about.gsub(' ', '_') if about.include? ' '
    puts "First search @ : https://en.wikipedia.org/wiki/#{about}"
    return 1 if about.capitalize == 'Philosophy'

    so_far.append(about)
    begin
      raise StandardError if Nokogiri.HTML(URI.open("https://en.wikipedia.org/wiki/#{about}")).nil?
    rescue StandardError
      puts 'Dead end page reached'
      return
    end
    until about == 'Philosophy' || so_far.include?(nil) || so_far.uniq.length != so_far.length
      about = Nokogiri.HTML(URI.open("https://en.wikipedia.org/wiki/#{about}")).xpath('//p/a[@href]').to_s.scan(%r{<a href="/wiki/(.*?)"}).flatten.first
      puts "https://en.wikipedia.org/wiki/#{about}" unless about.nil?
      so_far.append(about)
    end
    return so_far.length - 1 if so_far.include?('Philosophy')

    begin
      raise StandardError if so_far.uniq.length != so_far.length
    rescue StandardError
      puts 'Loop detected there is no way to philosophy here'
      return
    end
    begin
      raise StandardError if about.nil?
    rescue StandardError
      puts 'Dead end page reached'
    end
  end
end
