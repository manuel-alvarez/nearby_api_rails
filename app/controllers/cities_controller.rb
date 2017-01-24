class CitiesController < ActionController::Base
  protect_from_forgery with: :null_session

  def index
  	render :json => Rails.application.config.cities
   # respond_to do |format|
   #    format.html {render text: "Your data was sucessfully loaded. Thanks"}
   #    format.json { render text: Rails.application.config.cities }
   #  end
  end

  def create
  	new_id = params[:city].downcase.gsub! ' ', '_'
  	puts "#{new_id} is the new id for #{params[:city]}"
  	city = {}
  	city[:city] = params[:city]
  	city[:lat] = params[:lat]
  	city[:lon] = params[:lon]
  	city[:wikipedia] = params[:wikipedia]
  	Rails.application.config.cities[new_id] = city

  	render :json => Rails.application.config.cities[new_id]
  end

  def show
  	render :json => Rails.application.config.cities[params[:id]]
  end

  def update
  	city = Rails.application.config.cities[params[:id]]
  	puts params
  	unless params[:city][:city].nil?
  		city[:city] = params[:city][:city]
  	end
  	unless params[:city][:lat].nil?
  		city[:lat] = params[:city][:lat]
  	end
  	unless params[:city][:lon].nil?
  		city[:lon] = params[:city][:lon]
  	end
  	unless params[:city][:wikipedia].nil?
  		city[:wikipedia] = params[:city][:wikipedia]
  	end
  	Rails.application.config.cities[params[:id]] = city

  	show  # render show, since it's the id itself what we want to be rendered
  end

  def destroy
  	Rails.application.config.cities.reject!{|k| k == params[:id]}

  	index
  end

  def distance(lat1, lon1, lat2, lon2)
    earth_radius = 6371  # in Kilometers

    start_lat = lat1 * Math::PI / 180
    start_lon = lon1 * Math::PI / 180
    end_lat = lat2 * Math::PI / 180
    end_lon = lon2 * Math::PI / 180

    delta_lon = (start_lon - end_lon).abs;
    # Calculate angle in the inner center of the sphere (earth). This does not have in mind the different angles depending on latitude, but it will be ok for this project.
    central_angle = Math.acos((Math.sin(start_lat) * Math.sin(end_lat)) + (Math.cos(start_lat) * Math.cos(end_lat) * Math.cos(delta_lon)));
    dist = earth_radius * central_angle;
  end

  def cities_near(lat, lon, max_distance=500)
  	output = {}
    puts "Calculating distances from lat: #{lat}, lon: #{lon}"
  	Rails.application.config.cities.each_pair do |key, city|
  		dist = self.distance(lat, lon, city["lat"], city["lon"])
      if dist <= max_distance
        city[:dist] = dist
        output[key] = city
      end
  	end

    return output
  end

  def nearby
  	city = Rails.application.config.cities[params[:id]]
    puts "Searching for nearby cities from city #{city}"
    nearby_cities = self.cities_near(city["lat"], city["lon"])

    render :json => nearby_cities
  end

  def near
    latlon = params[:latlon].split(",")
    lat = latlon[0].to_f
    lon = latlon[1].to_f
    nearby_cities = self.cities_near(lat, lon)

    render :json => nearby_cities
  end
end
