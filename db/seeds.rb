User.create!(
  name: "Admin",
  email: "admin@university.presence",
  admin: true,
  password: "123456"
)


  Course.create(name:"Análise e Desenvolvimento de Sistemas", periods: 3)
  Course.create(name:"Direito", periods: 10)
  Course.create(name:"Enfermagem", periods: 10)
