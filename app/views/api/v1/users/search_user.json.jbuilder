if @which_json
  json.search_result @search_result
else
  json.search_result 'İletişim Bilgileriniz Kapalı'
end