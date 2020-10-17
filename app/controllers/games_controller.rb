require 'open-uri'
require 'json'
# Class for game
class GamesController < ApplicationController
  VOWELS = %w[a e i o u].freeze
  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('a'..'z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def reshuffle
    @letters.shuffle!
  end

  def score
    @guess = params[:word].downcase.split(//)
    @letters = params[:letters].split(' ')

    @letters_included = included?(@letters, @guess)

    @valid_english_word = english_word?(params[:word])

    @score = update_score(@valid_english_word, @letters_included, params[:word])
  end

  def reset_score
    session[:score] = nil
    redirect_to :new
  end

  def included?(letters, word)
    word.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    JSON.parse(response)['found']
  end

  def update_score(valid_english_word, letters_included, word)
    session[:score] = 0 unless session[:score]

    score = valid_english_word && letters_included ? word.length : 0
    session[:score] += score
    score
  end
end
