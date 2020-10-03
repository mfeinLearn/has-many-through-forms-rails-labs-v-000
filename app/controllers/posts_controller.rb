class PostsController < ApplicationController

    ### this is a method that exist because a post belongs to a
    ##### catagory

    ### if a post had many catagories you would instead get a method:
    # @post = Post.new
    # @post.categories.build

    ## AGAIN THESE METHODS THAT COME ALONG WITH THE RELATIONSHIPS
    #### THAT YOU SET UP IN YOUR MODEL
    def new
      ## SINCE THIS IS A BELONGS TO WE WILL USE BUILD CATAGORY
      @post = Post.new
      @post.build_category
    end

    def create
       post = Post.create(post_params)
       if post.save
          redirect_to post
       else
           render :new
       end
    end

  def show
    @post = Post.find(params[:id])
  end

  private
  # :category_id is specifically for the collection select in our form
  # We also want to allow to permit category_attributes in our strong params
  def post_params
    params.require(:post).permit(:title, :content, :category_id, category_attributes: [:name])
  end
end
