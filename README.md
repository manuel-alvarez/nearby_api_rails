Find nearby cities API. This time, developed in Ruby on Rails.

This is an experimental server writen in Ruby on Rails that loads a JSON file with a bunch of cities and serves data in an API service.

This is still in development, but it will have these methods:

/cities/

 - GET: Shows a list of available cities
 - POST: Adds a new city to the cities list

/cities/:id

 - GET: Shows data stored for a given city
 - PUT: Updates city data
 - DELETE: Removes a city from the cities list

/cities/:id/nearby

 - GET: Shows a list of cities within a radius of 500Km from the given city.

/cities/near/:coords

 - GET: Shows a list of cities within a radius of 500Km from the given point

   coords should have this format: /[\-0-9\.]+,[\-0-9\.]+/

   example: http://localhost:3000/cities/near/40.4,-3.5

