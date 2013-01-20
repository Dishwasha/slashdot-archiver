class ArticlesController < ApplicationController
  before_filter :access_control
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    articles = Article.search do
      filter :missing, {field: 'metadata', existence: true, null_value: true}
    end

    respond_with articles
  end

  def show
    article = Article.find(params[:id])

    respond_with article
  end

  def new
  end

  def create
    article = Article.find(params[:article][:link].split('/').last)
    unless article && article.id.present?
      #debugger
      article = Article.create(params[:article])
    end

    respond_with article
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def options
    head :ok
  end

  private
  def access_control
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type'
  end
end
