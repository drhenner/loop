##  THESE SETTING SHOULD NOT NEED TO BE SECURE.  IF YOU NEED TO USE SECURE
##  SETTINGS USE -- config/config.yml AND FOLLOW THE INSTRUCTIONS ON THAT PAGE
##  TO DEPLOY

require 'yaml'

SETTINGS = {
  :admin_grid_rows  => 25,
  :use_foreign_keys => false
}

APP_CONFIG = YAML.load_file(File.join(Rails.root, "config", "config.yml"))

if RAILS_ENV != "production"
  IMAGE_PAPERCLIP_OPTIONS = {
                              :styles         => {  :mini     => '48x48>',
                                                    :small    => '100x100>',
                                                    :product  => '320x320>',
                                                    :large    => '450x450>',
                                                    :x_large  => '600x600>' },
                              :default_style  => :product,
                              :url            => "/assets/products/:id/:style/:basename.:extension",
                              :path           => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
                            }
elsif RAILS_ENV == "production"
  IMAGE_PAPERCLIP_OPTIONS = { :storage        => :s3,
                              :styles         => {  :mini     => '48x48>',
                                                    :small    => '100x100>',
                                                    :product  => '320x320>',
                                                    :large    => '450x450>',
                                                    :x_large  => '600x600>' },
                              :bucket         => 'loopdeluxe',
                              :s3_credentials => {
                                :access_key_id      => APP_CONFIG['s3_key'],
                                :secret_access_key  => APP_CONFIG['s3_secret']
                              },
                              :default_style  => :product,
                              :path           => ":attachment/:id/:style/:basename.:extension"
                            }
end
=begin
### These options are stored in each of the environment files

#Paperclip.options[:image_magick_path] = '/opt/local/bin'
if RAILS_ENV == "development"

  Paperclip.options[:command_path] = "DYLD_LIBRARY_PATH='/Users/davidhenner/ImageMagick-6.6.3/lib' /Users/davidhenner/ImageMagick-6.6.3/bin"

  #Paperclip.options[:command_path] = '/Users/davidhenner/ImageMagick-6.6.3/bin'
  #Paperclip.options[:command_path] = '/usr/local/bin'
  ###  UNCOMMENT IF USING MACPORTS
  #Paperclip.options[:command_path] = '/opt/local/bin'
else
  Paperclip.options[:command_path] = '/usr/bin'
end
=end