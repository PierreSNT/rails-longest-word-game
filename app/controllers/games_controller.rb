require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    source = ("A".."Z").to_a
    @letters = []
    10.times { @letters << source[rand(source.size)].to_s }
    return @letters
  end

  def score
    # raise
    # check if the word exist
    # is the world using the letters provided
    # We need : The original letters, the word submitted by the user
    @attempt = params[:word]
    @letters = params[:letters]
    # @attempt.upcase!
    @result = {}
    if english? == false
      @result[:score] = 0
      @result[:message] = "Your attempt is not an English word"
    # elsif are_letters == false || use_of_letters == false
    elsif are_letters == false
      @result[:score] = 0
      @result[:message] = "Well done! But you used letters which are not in the grid"
    else
      @result[:score] = @attempt.length
      @result[:message] = "Well done!"
    end
    @result
  end

  private

  def english?
  # checking if the word is english
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    return word["found"]
  end

  def are_letters
    check_array = []
    @attempt.upcase.split('').each do |letter|
      if @letters.include? letter
        check_array << true
      else
        check_array << false
      end
    end
    if check_array.include? false
      false
    else
      true
    end
  end

  def use_of_letters
    check_array = []
    @attempt.split('').each do |letter|
      if @attempt.split('').count(letter) <= @letters.count(letter)
        check_array << true
      else
        check_array << false
      end
    end
    if check_array.include? false
      false
    else
      true
    end
  end
end


