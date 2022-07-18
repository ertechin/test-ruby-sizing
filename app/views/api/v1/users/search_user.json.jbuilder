if @which_json
  json.search_result @search_result
else
  json.internal_api_status 'contact_info is close'
end