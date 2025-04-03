User.create!(
  name: "Admin",
  email: "admin@university.presence",
  password: "123456",
  password_confirmation: "123456",
  admin: true
)
User.create!(
  name: "Alan",
  email: "alan@university.presence",
  password: "123456",
  password_confirmation: "123456",
  admin: true
)

course = Course.create(name:"Análise e Desenvolvimento de Sistemas", periods: 3)
Course.create(name:"Direito", periods: 10)
Course.create(name:"Enfermagem", periods: 10)

class_room = ClassRoom.create!(name: "Turma A", course: course)

Student.create!([
  { name: "Carlos H. Migon", ra: "241403-1", class_room: class_room },
  { name: "Alan G. G. Przyvara", ra: "249693-1", class_room: class_room }
])

puts "Seed concluido com sucesso!"
