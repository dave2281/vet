# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create!(
  [
    { email: 'admin@example.com', password: 'password123', role: 'admin' },
    { name: 'Андрей', surname: "Имейлович", email: 'user@example.com', password: 'password123', role: 'member' },
    { name: "Билл", surname: "Гейтс", patronymic: "Генри", description: "University of Veterinary",
      experience: '20 лет и более 10 тысяч вылеченных животных', role: 'doctor', email: 'john@gmail.com', password: 'password123'}
  ]
)

Category.create(
  [
    { title: 'Коты', description: 'полезная информация о клинической симптоматике, опыте и методах лечения болезней у кошек', user_id: 1  },
    { title: 'Собаки', description: 'полезная информация о клинической симптоматике, опыте и методах лечения болезней у собак', user_id: 1 }
  ]
)

Question.create!(
  [
    { title: "На собаке появился 'лишай'", text: "Подскажите пожалуйста наиболее эффективный способ лечения.", user_id: 2, category_id: 2},
    { title: "Кот очень вредный, какает мимо лотка.", text: "Подскажите пожалуйста наиболее эффективный способ лечения.", user_id: 2, category_id: 1}
 ]
)

Comment.create!(
  [
    { text: "Да, ваш кот определенно вредный. Наиболее эффективный метод лечения, кусь за ховост. Ежедневно, а желательно 2-3 раза в день.",
      user_id: 3, question_id: 2 },
    { text: "Используйте 'Лишамид', намазывая на место укуса.", user_id: 3, question_id: 1 }
  ]
)