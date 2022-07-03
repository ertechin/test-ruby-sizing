if @forgot_pw_which_json
  json.internal_api_status 'ok'
else
  json.internal_api_status 'bad'
end

