class PostsController < ApplicationController
  before_action :category, only: [:index , :show]

  # GET /posts
  def index

    @posts = if !params[:category_name].blank?
              Post.joins(:categories).where("categories.name = :category_name", :category_name=>params[:category_name]).order('created_at DESC').page(params[:page]).per(5)
            elsif !params[:tag_name].blank?
              Post.joins(:tags).where("tags.name = :tag_name", :tag_name=>params[:tag_name]).order('created_at DESC').page(params[:page]).per(5)
            else
              Post.search_posts_based_on_like(params[:search]).order('created_at DESC').page(params[:page]).per(5)
            end
    respond_to do |format|
      format.html{render :index}
      format.rss { render :index, :content_type => Mime::XML }
    end
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order("id").page(params[:page]).per(5)

    @recent_posts = Post.order("created_at DESC").limit(5)
    @popular_posts = Post.order("comments_count DESC").limit(5)
  end

  private
  def category
    @categories = Category.all
    @tags = Post.tag_counts_on(:tags)
  end
end
