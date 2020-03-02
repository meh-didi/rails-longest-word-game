# frozen_string_literal: true

require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @result = score_and_message
    @result
  end

  def included?
    params[:word].upcase.chars.all? { |letter| params[:word].count(letter) <= params[:letters].split.count(letter) }
  end

  def score_and_message
    if params[:word] === ''
      'Please type a word'
    else
      if included?
        if english_word?
          "Congratulation! #{params[:word]} is a valid English word!"
        else
          "sorry but #{params[:word]} does not seem to be a valid English word..."
        end
      else
        "Sorry but #{param[:word]} cannot be built out of #{param[:letter]}"
      end
  end
end

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end
end
