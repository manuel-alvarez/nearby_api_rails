class CitiesController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  	render :json => Rails.application.config.cities
   # respond_to do |format|
   #    format.html {render text: "Your data was sucessfully loaded. Thanks"}
   #    format.json { render text: Rails.application.config.cities }
   #  end
  end
end
