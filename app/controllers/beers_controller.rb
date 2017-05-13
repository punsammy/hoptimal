class BeersController < ApplicationController

  def index
    @q = Beer.ransack(params[:q])
    @beers = @q.result(distinct: true).page params[:page]
    # @beers_all = @beers.order(:name).page params[:page]
    respond_to do |format|
      format.html
      format.json do
        render json: @Beer, except: %i(created_at updated_at)
      end
    end
  end

   def show
    @beer = Beer.find(params[:id])
    @user_beer = @beer.user_beers.new
     respond_to do |format|
      format.html
      format.json do
        render json: @Beer, except: %i(created_at updated_at)
      end
    end

    @bars= []
    @bar_where_beer_is_found = @beer.bar_beers
    @bar_where_beer_is_found.each do |bar|
      @bars << Bar.find(bar.bar_id)
    end
    # @bar = @beer.bar_beers.each do |bar|
    #   <%= link_to "#{(Bar.find(bar.bar_id)).name}", bar_path %>
  end

  def random
    render json: (Beer.all - UserBeer.all).sample
  end



  def random_by_preference
    @user = current_user
    render json: Beer.all.where(category_id: (current_user.category_id)).sample
  end


  def search
    @q = Beer.ransack(params[:q])
    @beers = @q.result(distinct: true).page params[:page]
    render @beers, layout: false
  end

end
