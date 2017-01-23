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
end
