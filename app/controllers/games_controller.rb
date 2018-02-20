require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0..10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @attempt_url = params[:attempt]
    @letters = params[:letters]
    @attempt = @attempt_url.split("")
    if @attempt == []
      @result = "No result"
    elsif grid_check(@attempt, @letters) == false
      @result = "Sorry but #{@attempt} cannot be built out of #{@letters}"
# <!-- api call is false -->
    elsif api_check(@attempt_url) == false
      @result = "Sorry but #{@attempt} is not a valid English word..."
# The word is valid according to the grid and is an English word
    else
      @result = "Congratulations! #{@attempt} seems to be an English word!"
    end
  end

  def api_check(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
      response_file = open(url).read
      response = JSON.parse(response_file)
      response[ "found" ]
  end

  def grid_check(attempt, letters)
    attempt.all? { |i| letters.include?(i) }
  end
end


