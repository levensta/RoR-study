require 'worldmap.rb'
require 'battle.rb'
require 'save.rb'
require 'request_movies.rb'

$view = { 
  prev_page: "",
  save_slot: 0,
  new_ball: 0,
  caption: "a"
}
$game = {
  input: "",
  pos: {x: 4, y: 4},
  moviedex: [],
  spawn: Array.new(10) { Array.new(10, 0) },
  monsters: []
}
$player = {
  hp: 42,
  hit_point: 1,
  movieballs: 0
}
$selected = {}

class MainController < ApplicationController
  def initialize
    super
  end

  def power
    reset_global_vars()
    redirect_to action: :title
  end

  def reset_global_vars
    # page
    $view = { 
      prev_page: "",
      save_slot: 0,
      new_ball: 0,
      caption: "a"
    }
    $game = {
      input: "",
      pos: {x: 4, y: 4},
      moviedex: [],
      mov_idx: 0,
      spawn: Array.new(10) { Array.new(10, 0) },
      monsters: []
    }
    $player = {
      hp: 42,
      hit_point: 1,
      movieballs: 0
    }
    $selected = {}
  end

  def title
    reset_global_vars()
    Worldmap.set_spawn_points()
    RequestMovies.request()
    $view[:prev_page] = "title"
  end

  def worldmap
    if $game[:monsters].empty?
      redirect_to '/ending'
      return
    end
    $view[:new_ball] = $view[:new_ball].to_i if $view[:new_ball].class == String
    $view[:new_ball] -= 1 if $view[:new_ball] > 0 
    $view[:prev_page] = "worldmap"
    unless params[:input] == nil
      $game[:input] = params[:input]
      stumble = Worldmap.move_char($game[:input])
      url = stumble == 1 ? '/battle' : '/worldmap'
      redirect_to url
    end
  end

  def battle
    $selected = $game[:monsters].pop if $selected.empty?
    unless params[:input] == nil
      Battle.start
      $game[:input] = params[:input]
      case $game[:input]
      when 'a'
        url = Battle.input_a 
      when 'b'
        url = Battle.input_b
      else
        
      end
      redirect_to url
    end
  end

  def result
    unless params[:input] == nil
      $game[:input] = params[:input]
      case $game[:input]
      when 'a'
        redirect_to '/worldmap'  
      else
      end
    end
  end

  def moviedex
    case params[:input]
    when "l"
      $game[:mov_idx] = $game[:moviedex].length if $game[:mov_idx] == 0
      $game[:mov_idx] -= 1
    when "r"
      $game[:mov_idx] = -1  if $game[:mov_idx] == $game[:moviedex].length - 1
      $game[:mov_idx] += 1
    end
    unless params[:input] == nil
      $game[:input] = params[:input]
      next_page = (params[:input] == "s" ? "/worldmap" : "/moviedex")
      redirect_to next_page
    end
  end

  def save
    unless params[:input] == nil
      $game[:input] = params[:input]
      s = Save.new
      case $game[:input]
      when 'a'
        s.save
        url = '/save'
      when 'b'
        s.load
        url = '/save'
      else
        url = '/save'
      end
      Save.move_select($game[:input])
      redirect_to url
    end
  end

  def ending

  end
end
