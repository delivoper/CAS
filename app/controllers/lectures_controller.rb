class LecturesController < ApplicationController

  before_action :find_post, only: [:show]
  before_action :authenticate_user!, except: [:show]

  def index
    @lectures = Lecture.all
  end

  def new
    @lecture = Lecture.new
  end

  def show
    @lecture = Lecture.find(params[:id])
  end

  def create
    @lecture = Lecture.new(post_params)

    if @lecture.save
      redirect_to @lecture
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:lecture).permit(:name)
  end

  def find_post
    @lecture = Lecture.find(params[:id])
  end
end
