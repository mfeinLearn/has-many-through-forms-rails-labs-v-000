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
        # when we submit our form we are going to hit line 9 or what ever Post.new is on
        # that is where all of the magic is going to happen ALL AT ONCE
        # 1. we are going to instanciate a new post from post_params
            # Post.new is going to go to the strong params (posts_params)
        # 2. then active record is going to try to instanciate a new post object from all of
        # these things
            # it is going to see if we have a method title= on our post... which we do!.. because of
            # this is an attribute on the post; this is something on the table and active record is
            # going to set up a writer for that attribute title!
            # this also applies to the other attributes: content and category_id.
            # we also get the following methods category_id= and category_id which are writer and reader,respectively, because we have this relationship where a post belongs
            # to a catagory

            # When we go to category_attributes active record is going to be looking for a writter too
            # - we can solve our two problems (1) writter (2) category_attributes is not coming through params as expected
            # by using a macro called accepts_nested_attributes_for in the Post model and pass in the name of the relation ship is like this:
            # accepts_nested_attributes_for :category
            # we would add reject_if: :all_blank like this:
            # accepts_nested_attributes_for :category, reject_if: :all_blank
            ## if we do not fill that fields we are not going to try to create a blank category there, and we can just use our collection select.

            # ASIDE: if it was a has many relationship then we would write:
            # accepts_nested_attributes_for :categories


       @post = Post.new(post_params)
       if @post.save
          redirect_to @post
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
