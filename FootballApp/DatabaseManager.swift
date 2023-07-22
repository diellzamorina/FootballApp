import SQLite

class DatabaseManager {
    let db: Connection
    let users = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let age = Expression<Int>("age")

    init() {
        // Replace with the appropriate file path to your SQLite database
        let filePath = "path/to/database.sqlite"
        db = try! Connection(filePath)
    }

    func setupDatabase() throws {
        try db.run(users.create { table in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(age)
        })
    }

    func saveUser(name: String, age: Int) throws {
        let insert = users.insert(self.name <- name, self.age <- age)
        try db.run(insert)
    }

    func getUsers() throws -> [Perdoruesi] {
        var users: [Perdoruesi] = []

        for row in try db.prepare(self.users) {
            let user = Perdoruesi(id: row[id], name: row[name], age: row[age])
            users.append(user)
        }

        return users
    }
}

struct Perdoruesi {
    let id: Int
    let name: String
    let age: Int
}

//// Usage example:
//let databaseManager = DatabaseManager()
//
//do {
//    try databaseManager.setupDatabase()
//
//    try databaseManager.saveUser(name: "John Doe", age: 30)
//
//    let users = try databaseManager.getUsers()
//    for user in users {
//        print("User ID: \(user.id), Name: \(user.name), Age: \(user.age)")
//    }
//} catch {
//    print("Error: \(error)")
//}
//
