class ApiController < ApplicationController

  respond_to :json

  def index
    @posts = Post.all

    respond_with (@posts) do |format|
      format.json { render :json => @posts.as_json(include: { lecture: { only: :name} }, except: [:id, :user_id, :lecture_id] ) }

    end

  end

  def show

    @lecture_id = Lecture.where(name: params[:lecture])
    @posts = Post.where(lecture_id: @lecture_id).order("created_at DESC")

    if @posts.nil?
      @error={'error'=>'Announcement not found'}
      respond_with(@error, :status=>:not_found,:callback=>params[:callback])
    else
      respond_with (@posts) do |format|
        format.json { render :json => @posts.as_json(include: { lecture: { only: :name} }, except: [:id, :user_id, :lecture_id] ),
        :status=>:ok,
        :callback=>params[:callback] }
      end

    end

  end


end
