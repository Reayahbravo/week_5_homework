class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]  
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
        @post = Post.new
  end
  
  def create
      # The `params` object available in controllers
      # is composed of the query string, url params and the
      # body of a form (e.g. req.query + req.params + req.body)
  
      # A good trick to see if your routes work and you're getting
      # data that you want is rendering the params as JSON. This
      # is like doing res.send(req.body) in Express.
      #render json: params
  
    @post = Post.new post_params
    @post.user = current_user

    if @post.save
      #redirect_to home_path
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
      #@post = Post.find params[:id]
      #@post.view_count += 1 # me cut out
    @post.save
        #render json: params
        ##render json: @post
        ###render :show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def index
    @posts = Post.order(created_at: :desc)
        # render json: @posts
  end
    
  def edit
        #@post = Post.find params[:id]
  end
    
  def update
    #render json: params
    #@post = Post.find params[:id]

    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    #@post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end


  private
  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user!
    unless can?(:manage, @post)
      flash[:danger] = "Access Denied"
      redirect_to post_path(@post)
    end
  end
end
