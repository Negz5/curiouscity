=begin
Copyright 2013 WBEZ
This file is part of Curious City.

Curious City is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Curious City is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with Curious City.  If not, see <http://www.gnu.org/licenses/>.
=end
require 'flickr-objects'

class FlickrService
  def get_api_key
    if File.exists? 'config/api-key.yml'
      config = YAML.load_file('config/api-key.yml')
      return config["key"]
    end
    return "some key"
  end

  def find_pictures(search_string)
    Flickr.api_key = get_api_key
    query = {:text => search_string, :license=>"1,2,3,4,5,6", :extras=>['owner_name'], :per_page=>50}
    Flickr.photos.search(query).map{|photo| FlickrPicture.new(photo)}
  end
end
