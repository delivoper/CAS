class ApiController < ApplicationController

  respond_to :json

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show

    @lecture_id = Lecture.find_by(name: params[:lecture]).id

    @posts = Post.where(lecture_id: @lecture_id).order("created_at DESC")

    if @posts.nil?
      @error={'error'=>'Book not found'}
      respond_with(@error, :status=>:not_found,:callback=>params[:callback])
    else
      respond_with(@posts, :status=>:ok,:callback=>params[:callback])
    end

  end

end
