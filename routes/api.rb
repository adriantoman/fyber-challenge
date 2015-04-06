class MyApp < Sinatra::Base

  register Sinatra::Flash

  END_POINT = "http://api.sponsorpay.com"
  VERSION = "v1"
  API_KEY = "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"

  get '/' do
    erb :index
  end

  post '/make_call_to_fyber' do
    # Lets check if the users has specified all the parameters
    errors = []
    [:uid,:pub0,:page].each do |value|
        if (params[value].nil? or params[value] == "")
          errors << "The param #{value.to_s} is empty."
        end
    end
    if errors.empty?
      # Lets make call to Fyber API
      url = "#{END_POINT}/feed/#{VERSION}/offers.json"
      request_params = {
        :appid => 157,
        :uid => params[:uid],
        :ip => "109.235.143.113",
        :locale => "de",
        :device_id => "2b6f0cc904d137be2e1730235f5664094b83",
        :pub0 => params[:pub0],
        :page => params[:page],
        :offer_type => "112",
        :timestamp => Time.now.strftime("%s")
      }

      # Lets create the hash key
      # Sort our request params
      sorted_request_params = request_params.sort_by{|k,v| k.to_s}
      # Create string
      output_string = sorted_request_params.map{|k,v| "#{k.to_s}=#{v}"}.join("&")
      # Add API KEY at the end
      output_string += "&#{API_KEY}"
      output_hash = Digest::SHA1.hexdigest(output_string)
      request_params.merge!({:hashkey => output_hash})
      response = HTTParty.get(url,:query => request_params)
      if (response.headers["X-Sponsorpay-Response-Signature"] != Digest::SHA1.hexdigest(response.body + "#{API_KEY}") )
        flash[:error] = "It looks like someone has tampered with the response."
        redirect '/'
      end

      # TODO: Check if the response from API is with 200. In other case show error to user

      @offers = response["offers"].map do |element|
        {
            "title" => element["title"],
            "payout" => element["payout"],
            "thumbnail" => element["thumbnail"]["lowres"]
        }
      end
      erb :offers
    else
      # TODO: Don't lose parameters after error
      flash[:error] = errors.join(" ")
      redirect '/'
    end
  end



end
