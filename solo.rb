data_bag_path (ENV["CHEF_DATABAGS"] || File.expand_path("~/Development/databags"))
cookbook_path File.expand_path("..")
encrypted_data_bag_secret  (ENV["CHEF_SECRET_FILE"] || File.expand_path("~/.chef/encrypted_data_bag_secret"))
