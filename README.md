# FbExif

This script is designed to work with Facebook archives.  You can start by getting a backup of your Facebook data. Go to https://www.facebook.com/settings and click "Download a copy" at the bottom of that page.

Once you've downloaded that and extracted the zip file, this you will have all of your Facebook data, including all uploaded photos.  You will find the photos do not have any EXIF data in them, but some of that data is available within the HTML files in the archive.  This script will populate those images with that data.

## Requirements

Ruby 1.9 or higher and an installation of the Exiftool command-line application at least version 7.65. Instructions for installation you can find under www.sno.phy.queensu.ca/~phil/exiftool/install.html .

## Installation

    gem install fb_exif

## Usage

It is recommended that you do not run this on your only copy of these photos.  This script will be modifying data inside the photos.  **Please make sure to have backups.**

This can be run inside the directory called `photos` inside the extracted Facebook archive

    fb_exif

or you can provide the path to that directory

    fb_exif /path/to/photos

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cbulock/fb_exif.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

