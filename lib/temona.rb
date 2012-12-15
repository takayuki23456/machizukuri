module TEMONA
  def mod_keyword(keyword) 
     #検索キーワードの整形
    #１、重複を削除
    #２、重複した空白の削除
    #３、タブの削除
    #４、スペースを「-」に置換
    query = keyword.to_s.gsub(" ","-").gsub("　","-").gsub("\t","").split("-")
    query.delete("") 
    return (query.uniq.join(",").gsub(",","-")).kconv(Kconv::SJIS, Kconv::UTF8)
  end
end