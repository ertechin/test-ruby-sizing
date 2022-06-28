# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
n_index = 0

5.times do
    n_index +=1
    AddedNews.create(
        context: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        title: Faker::Book.title,
        tag: n_index % 2 ==0 ? 'İyi Haber': 'Kötü Haber',
        date: Faker::Date.between(from: 2.days.ago, to: Date.today)
    )
end

