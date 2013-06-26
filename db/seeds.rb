# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin
# User.create(nom: "Akkouh", prenom: "Mahdi", email: "akkouh.mahdi@gmail.com",
# 							password: "foobar", password_confirmation: "foobar", admin: true)
# User.first.update(password: "foobar", password_confirmation: "foobar", admin: true)

# Aviron model
# Aviron.create(description: "simple", nbplaces: 1)
# Aviron.create(description: "double", nbplaces: 2)
# Aviron.create(description: "yolette", nbplaces: 4)

# Creneau model
## 45 minutes
# t = Time.now.change(hour: 9, min: 0, sec: 0)
# (1..4).each do |i|
# 	Creneau.create(debut: t, fin: t+45.minutes)
# 	t = t + 45.minutes
# end
# t = t.change(hour: 14, min: 0)
# (1..4).each do |i|
# 	Creneau.create(debut: t, fin: t+45.minutes)
# 	t = t + 45.minutes
# end
# ## 1 hour
# t = t.change(hour: 9, min: 0)
# (1..3).each do |i|
# 	Creneau.create(debut: t, fin: t+1.hour)
# 	t = t + 1.hour
# end
# t = t.change(hour: 14, min: 0)
# (1..3).each do |i|
# 	Creneau.create(debut: t, fin: t+1.hour)
# 	t = t + 1.hour
# end