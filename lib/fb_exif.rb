require "fb_exif/version"
require "nokogiri"
require "mini_exiftool"

module FbExif

	# Author::    Cameron Bulock (mailto:cameron@bulock.com)
	# Copyright:: Copyright (c) 2016 Cameron Bulock
	# License::   MIT

	module_function

	def start(photo_dir)
		@photo_dir = photo_dir

		albums = Dir.entries(@photo_dir).select {|entry| File.directory? File.join(@photo_dir,entry) and !(entry =='.' || entry == '..') }
		albums.each do |album|
			FbExif.process_album(album)
		end
	end

	private

	def FbExif.gather_meta_data(image)
		meta_data = Hash.new
		meta_data["Created"] = image.css('div > div.meta').first.inner_html

		datas = image.css('div table tr')
		datas.each do |data|
			meta_data[data.css('th').inner_html] = data.css('td').inner_html
		end

		return meta_data
	end

	def FbExif.add_meta_data_to_image(image_path, meta_data)
		image = MiniExiftool.new image_path

		#Date and Time
		if meta_data["Taken"]
			datetime = Time.at(meta_data["Taken"].to_i).strftime('%F %T')
		elsif meta_data["Modified"]
			datetime = Time.at(meta_data["Modified"].to_i).strftime('%F %T')
		else 
			datetime = DateTime.parse(meta_data["Created"]).strftime('%F %T')
		end
		image.DateTimeOriginal = datetime

		#Orientation
		if meta_data["Orientation"]
			image.Orientation = meta_data["Orientation"]
		end

		#F-Stop
		if meta_data["F-Stop"]
			image.FNumber = meta_data["F-Stop"].to_i
		end

		#Exposure
		if meta_data["Exposure"]
			image.ExposureTime = meta_data["Exposure"].to_i
		end

		#ISO Speed
		if meta_data["ISO Speed"]
			image.ISO = meta_data["ISO Speed"]
		end

		#Focal Length
		if meta_data["Focal Length"]
			image.FocalLength = meta_data["Focal Length"].to_i
		end

		#Make and Model
		if meta_data["Camera Make"]
			image.Make = meta_data["Camera Make"]
		end
		if meta_data["Camera Model"]
			image.Model = meta_data["Camera Model"]
		end

		#GPS
		if meta_data["Latitude"]
			image.GPSLatitude = meta_data["Latitude"]
			image.GPSLatitudeRef = meta_data["Latitude"]
			image.GPSLongitude = meta_data["Longitude"]
			image.GPSLongitudeRef = meta_data["Longitude"]
		end

		image.save
		print '.'
	end

	def FbExif.process_album(album)
		html = File.open(@photo_dir + album + "/index.htm") { |f| Nokogiri::HTML(f) }
		images = html.css('.contents .block')
		images.each do |image|
			image_path = @photo_dir + album + '/' + image.css('img').attr('src')
			meta_data = FbExif.gather_meta_data(image)
			FbExif.add_meta_data_to_image(image_path, meta_data)
		end
	end

end