json.extract! user, :id, :name, :surname, :patronymic, :description, :email, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
