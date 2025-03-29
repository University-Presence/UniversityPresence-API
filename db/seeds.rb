User.create!(
  name: "Admin",
  email: "admin@university.presence",
  password: "123456",
  password_confirmation: "123456",
  admin: true
)

Course.create(name:"Análise e Desenvolvimento de Sistemas", periods: 3)
  Course.create(name:"Direito", periods: 10)
  Course.create(name:"Enfermagem", periods: 10)
