module ConstantsList
  include TEMONA
 # include Protocalendar
  GOOGLE_KEY="ABQIAAAALDj9yqEQO1UYyigAFCyryBQvEBHjuQEDOMniQj3Kj6hucGU0fhSS7JxVteSwFm95_rZGwMV9rOumHw"
  GOOGLE_MAP_SCRIPT = "<script src=\"http://maps.google.com/maps?file=api&amp;v=2&amp;key=#{GOOGLE_KEY}\" type=\"text/javascript\"></script>"
  GOOGLE_MAP_SCRIPT_AJAX = "<script type=\"text/javascript\" src=\"http://www.google.com/jsapi?key=#{GOOGLE_KEY}\"></script>"
  

  GLAYERIN ="Glayer.show();"
  GLAYEROUT ="Glayer.fadeOut();"
  STYLE_RED = "background-color:MistyRose"
  STYLE_YELLOW = "background-color:Moccasin"
  SITE_NAME ="NPO法人 東淀川地域町づくりの会"
  def top_url
    case ENV['RAILS_ENV']
    when "production";"http://higashiyodogawa-machizukuri.org"
    when "development";"http://localhost:3100"
    else "http://localhost:3100"
    end
  end
  def contact_kind
    ["参加について","要請、要望について","その他"]
  end
  #パンくず用link_to
  def link_to_pankuzu(hash={})
    new_make_hash = {}
    hash.each{|h|new_make_hash[h[0]] = h[1] unless h[0]=="link_name"}
    return link_to(hash['link_name'],new_make_hash)
  end
  
  def image_url
    return "#{ConstantsList.top_url}/images/"
  end
  def lightbox_to(img1,img2,opt={})
    link_to(img1,image_url + img2,:rel=>"lightbox")
  end
  def add_to_project(text,opt={})
    link_to_remote(text,
      :url=>{:action=>:interest_check,:id=>opt[:id]},
      :loading =>  ConstantsList::GLAYERIN,
      :loaded =>  ConstantsList::GLAYEROUT
      #:update=>"mainContent",
      #:submit=>"mainContent"
    )
  end
  def show_googlemap(object_longitude,object_latitude,size_width=410,size_height=320)
    tag = javascript_include_tag 'google_map_lib'
    tag += GOOGLE_MAP_SCRIPT
    tag += '<div class="googlemap">'
    tag += "<div id=\"map\" style=\"width:#{size_width}px; height: #{size_height}px\">"
    tag += "<script type='text/javascript'>ExeShowAddress(#{object_longitude},#{object_latitude})</script>"
    tag += "</div>"
    tag += "</div>"
    return tag
  end
   
end
  