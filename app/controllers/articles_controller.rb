#require 'byebug'
class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        #byebug
        #@article = Article.find(params[:id]) #commenting - added set_article method
        # params[] - this fetches the id/attribute value from the search box to the controller
        #:id is the field value or the value of the id column. if in search box of browser we give /articles/1 then the id is 1 
        #and to fetch this value from the browser to the controller we use params[] 
        # and the variable article is local to this method. so inorder to make it available across the app we make it as instance variable uisng @
        # and now if we use this in show.html.erb to display on the screen
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
      @article = Article.new
    end

    # WE SAVE OUR ARTICLES FROM HERE
    def create
      #render plain: params[:article]
      byebug
      @article = Article.new(article_params)
      @article.user = current_user
      #render plain: @article.inspect
      if @article.save
        flash[:notice] = "Article was created successfully."
        redirect_to article_path(@article)
      else
        render 'new'
      end
    end

    def edit
        #byebug
        #@article = Article.find(params[:id]) #commenting - added set_article method
    end

    def update
        #byebug
        #@article = Article.find(params[:id])  #commenting - added set_article method
        # the above line will point to the row in the db having the id which we sent from the above line
        if @article.update(article_params)
          flash[:notice] = "Article was updated successfully"
          redirect_to @article
        else
          render 'edit'
        end
    end

    def destroy
      #@article = Article.find(params[:id]) #commenting - added set_article method
      @article.destroy
      redirect_to articles_path
    end

    private

    def set_article #added this method to reduce redundancy
        @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own article"
        redirect_to @article
      end
    end
end