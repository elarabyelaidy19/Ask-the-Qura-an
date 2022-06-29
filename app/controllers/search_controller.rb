class SearchController < ApplicationController
  
  
  def index
    @query = Aya.ransack(params[:q])
    @ayas = @query.result(distinct: true)
    @counter= @ayas.count
  end
end
