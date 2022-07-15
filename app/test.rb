
require 'excon'
require 'json'
    def find_verse
        mb = request_api(
            "http://api.alquran.cloud/v1/surah/11"
        )
        results = mb["data"]["ayahs"]  
        apiresults = []
        results.each do |result| 
            apiresults << result["number"]
        end 
       apiresults

    #    hey = []
    #      apiresults.each do |res|
    #           hey << Aya.find_by_aya_number(res)
    #         end
    #         hey

    end
     
  
  
 
    
  
    def request_api(url)
      response = Excon.get(url)
      return nil if response.status != 200
      JSON.parse(response.body)
    end
 
  p find_verse