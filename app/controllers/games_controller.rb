require 'open-uri'
require 'byebug'

class GamesController < ApplicationController
    def new
        letters = Array('a'..'z')
        word_length = rand(5..12)
        @letters = letters.shuffle.first(word_length)
        @letters
    end

    def score
        @word = params['word']
        @letters = params['letters']
        letters = @letters.split
        guess_array = @word.split("")
        match = letters.select do |h|
            guess_array.include?(h)
        end
        if match.join != guess_array.join
            @response = "Invalid"
        else
            response = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
            @response = JSON.parse(response)
            @response['found']
        end
        raise
    end
end
