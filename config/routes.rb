ActionController::Routing::Routes.draw do |map|

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  #
  # Install the default route as the lowest priority.
  map.admin 'admin/', :controller => 'admin/menu', :action => 'logout'
  #map.root :controller=>'shop', :action=>'display_cart'
  map.root :controller=>'content/content', :action=>'top'

  map.with_options(:controller => 'content/content') do |m|
    m.about  'about/', :action => 'about'
    m.greeting 'greeting/', :action => 'greeting'
    m.voice 'voice/', :action => 'voice'
    m.info 'info/', :action => 'info'
    m.supporter 'supporter/', :action => 'supporter'
    m.access 'access/', :action => 'access'
  end


  map.topics 'topics/:action/:id', :controller => 'content/topics'
  map.contact 'contact/:action/:id', :controller => 'content/contact'
  map.activity 'activity/:action/:id', :controller => 'content/activity'
  
  
  map.connect ':controller/:id/:page', :requirements => {:id => /\d+/, :page => /\d+/}
  map.connect ':controller/:action/:id', :requirements => {:id => /\d+/}
  map.connect ':controller/:action/:id'

  # disable invalid request.
  #  map.connect '*anything', :controller => 'shop', :action => 'display_cart'

end
