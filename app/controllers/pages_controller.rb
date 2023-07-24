class PagesController < ApplicationController

    def main
 

    #Creates the flickr object, per flickr gem doc
    @flickr = Flickr.new ENV["flickr_api_key"], ENV["flickr_shared_secret"]

    #Examples/info from a real user
    # nsid = "57847683@N00"
    #flickr.people.getPublicPhotos(user_id: "57847683@N00")

    #The photo url has this syntax per documentation
    # https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg
    
    #This is an example of the api raw response 
    # [{"id"=>"53062868643", "owner"=>"57847683@N00", "secret"=>"d991d72404", 
    #"server"=>"65535", "farm"=>66, "title"=>"The Storm Passed", "ispublic"=>1, 
    #"isfriend"=>0, "isfamily"=>0}, 

    @nsid = params[:nsdi]

    if @nsid
        begin
            @list_of_images = @flickr.people.getPublicPhotos(user_id: @nsid)
            @list_of_url = get_array_url(@list_of_images)
            
        rescue 
            redirect_to root_path, alert: "Couldn't find the user"
        end
    end

   
            
    end
  
    
    private

    def get_url(info)
        "https://live.staticflickr.com/#{info["server"]}/#{info["id"]}_#{info["secret"]}.jpg"
    end


    def get_array_url(photo_hash)
        new_array = []

        photo_hash.each do |data|
            new_array << get_url(data)
        end

        new_array
    end

end
