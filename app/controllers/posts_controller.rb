class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  # 1. set up instance variable for action
  # 2. redirect based on some condition (i.e. have to be logged in situation)

  def index
    @posts = Post.all
  end

  def show 
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was edited"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = 'You can only vote on the post "<%= @post.title %>" once.'
        end
        redirect_to :back
      end  
      format.js 
    end
  end

  private

  def post_params
    # params.require(:post).permit! # permits all fields
    params.require(:post).permit(:title, :url, :description, category_ids: []) #permits specific fields only
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end
end
