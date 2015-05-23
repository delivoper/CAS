class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:lecture].blank?
      @posts = Post.all.order("created_at DESC")
    else
      @lecture_id = Lecture.where(name: params[:lecture])
      @posts = Post.where(lecture_id: @lecture_id).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

      if @post.save
        redirect_to @post
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end

  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :deadline, :lecture_id)

  end

end
