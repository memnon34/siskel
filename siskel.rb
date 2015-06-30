require 'httparty'

class Siskel
  attr_accessor :title, :year, :rating, :plot

  def initialize(title, opts = {})
    @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&y=#{opts[:year]}&plot=#{opts[:plot]}?tomatoes=true")
    @rating = @movie["Rated"]
    @title = get_title
    @year = @movie["Year"]
    @plot = @movie["Plot"]
    @tomatoes = @movie["tomatoMeter"]

  end

  def get_title
    @movie["Title"] || @movie["Error"]
  end

  def concensus
    case @tomatoes.to_i
    when 76..100
      "Two Thumbs Up"
    when 51..75
      "Thumbs Up"
    when 26..50
      "Thumbs Down"
    else 
      "Two Thumbs Down"
    end
  end


end 







