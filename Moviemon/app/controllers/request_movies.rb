require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class RequestMovies
  def self.request
    all_movies = File.readlines("#{Rails.root}/app/assets/etc/mov_id.txt").join.split("\n")
    randex = (0..72).to_a.shuffle.take(10)
    randex.each_entry { |idx| $game[:monsters].append(all_movies[idx]) }
    $game[:monsters].each_with_index do |mov, n|
      url = URI("https://movie-database-alternative.p.rapidapi.com/?r=json&i=#{mov}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-host"] = 'movie-database-alternative.p.rapidapi.com'
      request["x-rapidapi-key"] = '6ea9c0752emshbc9db49f4ab069cp15b114jsn86b7785f658b'
      response = http.request(request)
      $game[:monsters][n] = JSON.parse(response.read_body).slice("Title", "Year", "Director", "imdbRating", "Plot", "Poster", "Genre").transform_keys!(&:to_sym)
      $game[:monsters][n].merge!({hp: $game[:monsters][n][:imdbRating].to_f})
    end
  end
end
