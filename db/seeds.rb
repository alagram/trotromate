User.create(email: "admin@example.com", name: "admin", password: "password", admin: true)

Project.create(name: "Trotromate Beta")

State.create(name: "New", background: "#85FF00", color: "white", default: true)

State.create(name: "Open", background: "#00CFFD", color: "white")

State.create(name: "Closed", background: "black", color: "white")
