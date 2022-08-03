json.userData do
json.user_id "#{@current_user.id}"
json.email @current_user.email
json.token @current_user.token
json.phone @current_user.phone
json.profile_image @user_image_url
json.full_name @current_user.full_name
json.job @current_user.job
json.city @current_user.city
json.country @current_user.country
json.about @current_user.about
json.g_year "#{@current_user.g_year}"
json.verified @current_user.verified
json.contact_info @current_user.contact_info
end
