if @which_json
  json.search_result @search_result, :email, :phone, :full_name, :job, :city, :country, :about, :g_year, :profile_image
else
  json.search_result 'İletişim Bilgileriniz Kapalı'
end