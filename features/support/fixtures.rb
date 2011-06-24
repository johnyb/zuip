# copy fixture svg presentations to assets directory
Dir[Rails.root.join("spec/fixtures/*.svg")].each {|f| FileUtils.copy(f,Rails.root.join("public/assets/zuip")) }

