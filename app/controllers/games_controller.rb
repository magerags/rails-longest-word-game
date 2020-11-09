require 'open-uri'

class GamesController < ApplicationController
  def new
    letters = ('A'..'Z').to_a
    @new = Array.new(10) { letters.sample }
  end

  def score
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    @score = "Well done!"
    if word_in_grid?(params[:word], params[:grid])
      api = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)
      api["found"] ? @score_num = (api["length"] * 5) : @score = "not an english word"
    else
      @score = 'word not in the grid'
    end
    @score
  end

  def word_in_grid?(word, grid)
    grid = grid.split
    word.upcase.chars.each do |letter|
      if grid.index(letter)
        grid.delete_at(grid.index(letter))
      else
        return false
      end
    end
    true
  end
end
