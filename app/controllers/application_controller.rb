
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/articles' #makes a new GET request
  end
  
  # get all articles (READ)
  get '/articles' do
    @articles = Article.all #get what you want from the model, and store it as an instance variable
    erb :index #we access that instance variable in the view (index.erb)
  end

  # READ articles
  get '/articles' do
    @articles = Article.new
    erb :new
  end

    # view the form to CREATE an article
  get '/articles/new' do
    @articles = Article.all
    erb :new
  end
  
  # CREATE 1 article (finds article by id)
  post '/articles' do
    article = Article.new(params) #this goes with article.save. .new only makes a new instance, but does not save it.
    article.save #this saves the .new instance. These two lines work simliarly as .create

    # @article = Article.create(params)
    redirect "/articles/#{Article.last.id}" #makes a new GET request
    # redirect to "/articles/#{article.id}" # don't know why this didn't work
  end

    # READ 1 article
  get '/articles/:id' do
    @article = Article.find(params["id"])
    erb :show
  end

  # view the form to UPDATE 1 specific article
  get '/articles/:id/edit' do #finds an article based on params from the URL
    @article = Article.find(params[:id])
    erb :edit
  end
  
  patch "/articles/:id" do #using PATCH instead of PUT to modify only part of the object (article) 
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect "/articles/#{ @article.id }" #makes a new GET request
  end

    # delete
  delete "/articles/:id" do
    #@article = Article.find(params["id"])
    Article.destroy(params[:id]) 
    redirect "/articles" #makes a new GET request
  end

end

# redirect - makes a new instance, and loses any data from a previous instance. This will also end the block, much like #return in ruby.

# erb - doesn't make a new request. This stays within the SAME request, and retains all the data from that instance.