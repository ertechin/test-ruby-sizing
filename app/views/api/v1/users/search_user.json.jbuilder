if @which_json
  json.search_result @search_result
else
  json.internal_api_status 'bad'
end