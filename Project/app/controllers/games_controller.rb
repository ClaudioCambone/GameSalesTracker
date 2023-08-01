class GamesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  #http_basic_authenticate_with name: "user", password: "user", except: [:index, :show]

  def index
    @games = Game.all
  end

  def show 
    @game = Game.find(params[:id])
  end

  def new 
    @game = Game.new
  end

  def create 
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @game = Game.find(params[:id])
  end
  
  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to @game
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to root_path, status: :see_other
  end

  private 
  def game_params
    params.require(:game).permit(:title, :body, :status)
  end

end
