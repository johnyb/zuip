module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def path_to_presentation(title)
    case title
    when /^About Zooming Presentations$/
      path_to_presentation("presentations")
    else
      begin
        path = "#{::Rails.root}/spec/fixtures/#{title.underscore}.svg"
        raise Errno::ENOENT unless File.exist?(path)
        path
      rescue Errno::ENOENT
        raise "Can't find presentation with title \"#{title}\".\n" +
            "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def params_for_waypoint(name)
    case name
    when /^Title$/
      '?zoom=7.863888888888889&lat=18849.26478&lon=21906.20852&layers=B'
    else
      raise "Can't find mapping from \"#{name}\" to a waypoint.\n" +
          "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
