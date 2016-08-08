current_dir = Dir.pwd
cookbook_path [
File.expand_path('../cookbooks', __FILE__)
]
ssl_verify_mode :verify_none