


# SerchController
class SearchController < ApplicationController
  def index 

    
      if params[:lexical_type] 

        words = params[:q][:content_or_text_cont] 
        if words.blank?
          redirect_to root_path
          @counter = 0
        else
          @ayas= Aya.where("content LIKE ?","%" + words + "%")
          @counter = @ayas.count
          @pagy, @ayas = pagy(@ayas,items:12)

        end
 
      elsif params[:semantic_type]  

        words = params[:q][:content_or_text_cont] 
        if words.blank?
          redirect_to root_path
          @counter = 0
        else
          @ayas = find_verse(words)
          @counter = @ayas.count
          # @pagy, @ayas = pagy(@ayas)

        end

      else  
        nil 
      end 

    
  end
  
  
  private 

  def request_api(url)
    response = Excon.get(url)
    #return nil if response.status != 200
    JSON.parse(response.body)
  end

  def find_verse(words)
    query = CGI.escape("#{words}")  
    mb = request_api(
      "https://ac7a-217-52-191-171.eu.ngrok.io/similar-verse/#{query}"
    ) 
    mb['results'].map { |row| row[2]}   
  end 
  
end



































# class SearchController < ApplicationController
#   require 'json' 
#   require 'excon' 
  
#   def index
#     # # @page=params.fetch(:page,0).to_i
#     #  @query = Aya.ransack(params[:q])
#     #  @ayas1 = @query.result(distinct: true)
#     # # @ayas =@ayas1.offset(@page * 10).limit(10)
#     #  @counter= @ayas1.count
#     # @pagy, @ayas = pagy(@ayas1,items:12)
#     # # @ayas= Aya.where("text LIKE ?","%" + params[:q] + "%")
#     if params[:search].blank?
#       redirect_to root_path
#     else
#       @parameter = params[:search]
#       @ayas0 = Aya.all.where("content LIKE :search", search: "%#{@parameter}%")
#     end


#     # \\\\\\\\\\\\\\\\\ call API of semantic search \\\\\\\\\\\\\\\\\\\\\\\\\

#     #query = CGI.escape("#{params[:search]}")  
#     mb = request_api(
#         "http://api.alquran.cloud/v1/surah/114"
#     )
#     results = mb["data"]  
#     cnt = 0 
#     apiresults = []
#     results.each do |result| 
#         apiresults << mb["data"]["ayahs"][1]["number"]
#         cnt += 1 
#     end  


#     @resultsOfApiFromDatabase = []

#     apiresults.each do |res|
#       @resultsOfApiFromDatabase << Aya.find(res)
#     end

#     @finalResults =  @ayas0 + @resultsOfApiFromDatabase


    
    
#     @counter = @finalResults.length 
#     @pagy, @ayas = pagy(@finalResults,items:12)
#   end



#   private 

#   def request_api(url)
#     response = Excon.get(url)
#     return nil if response.status != 200
#     JSON.parse(response.body)
#   end

#   def semantic
      
#   end

  

#   # def past
#   #   page:@page - 1
#   #   @ayas =@ayas1.offset(@page * 10).limit(10)
#   # end

#   # def next_page
#   #   page:@page + 1
#   #   @ayas =@ayas1.offset(@page * 10).limit(10)
#   # end

# end
