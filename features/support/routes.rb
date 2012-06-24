def path_for(route_name)
  case(route_name)
  when "homepage" then root_path
  when "post" then post_path(@post.permalink)
  else
    __send__("#{route_name}_path")
  end
end
