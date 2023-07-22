//
//import UIKit
//import CoreData
//
//class SavePlayerViewController: UIViewController {
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    private var playerNameTextField: UITextField!
//    private var playerAgeTextField: UITextField!
//    private var playerPositionTextField: UITextField!
//    private var saveButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        playerNameTextField = UITextField()
//        playerNameTextField.translatesAutoresizingMaskIntoConstraints = false
//        playerNameTextField.borderStyle = .roundedRect
//        playerNameTextField.placeholder = "Name"
//        view.addSubview(playerNameTextField)
//
//        playerAgeTextField = UITextField()
//        playerAgeTextField.translatesAutoresizingMaskIntoConstraints = false
//        playerAgeTextField.borderStyle = .roundedRect
//        playerAgeTextField.placeholder = "Age"
//        view.addSubview(playerAgeTextField)
//
//        playerPositionTextField = UITextField()
//        playerPositionTextField.translatesAutoresizingMaskIntoConstraints = false
//        playerPositionTextField.borderStyle = .roundedRect
//        playerPositionTextField.placeholder = "Position"
//        view.addSubview(playerPositionTextField)
//
//        saveButton = UIButton(type: .system)
//        saveButton.translatesAutoresizingMaskIntoConstraints = false
//        saveButton.setTitle("Save", for: .normal)
//        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
//        view.addSubview(saveButton)
//
//        NSLayoutConstraint.activate([
//            playerNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            playerNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
//            playerNameTextField.widthAnchor.constraint(equalToConstant: 200),
//            playerNameTextField.heightAnchor.constraint(equalToConstant: 40),
//
//            playerAgeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            playerAgeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            playerAgeTextField.widthAnchor.constraint(equalToConstant: 200),
//            playerAgeTextField.heightAnchor.constraint(equalToConstant: 40),
//
//            playerPositionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            playerPositionTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60),
//            playerPositionTextField.widthAnchor.constraint(equalToConstant: 200),
//            playerPositionTextField.heightAnchor.constraint(equalToConstant: 40),
//
//            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            saveButton.topAnchor.constraint(equalTo: playerPositionTextField.bottomAnchor, constant: 20)
//        ])
//    }
//
//    @objc private func saveButtonTapped() {
//        guard let playerName = playerNameTextField.text, !playerName.isEmpty else {
//            showAlert(message: "Please enter a valid player name.")
//            return
//        }
//        guard let playerAgeText = playerAgeTextField.text, let playerAge = Int16(playerAgeText) else {
//            showAlert(message: "Please enter a valid age.")
//            return
//        }
//        guard let playerPosition = playerPositionTextField.text, !playerPosition.isEmpty else {
//            showAlert(message: "Please enter a valid player position.")
//            return
//        }
//
//        savePlayer(name: playerName, age: playerAge, position: playerPosition)
//    }
//
//    func savePlayer(name: String, age: Int16, position: String) {
//        let entityName = String(describing: Player.self)
//        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
//            print("Failed to retrieve entity description for entity: \(entityName)")
//            return
//        }
//
//        let player = Player(entity: entity, insertInto: context)
//        player.name = name
//        player.age = age
//        player.position = position
//
//        do {
//            try context.save()
//            showAlert(message: "Player saved successfully!")
//        } catch {
//            showAlert(message: "Error saving player: \(error.localizedDescription)")
//        }
//    }
//
//    private func showAlert(message: String) {
//        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
//
//    func readPlayers() {
//        let entityName = String(describing: Player.self)
//        let fetchRequest: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: entityName)
//
//        do {
//            let players = try context.fetch(fetchRequest)
//            for player in players {
//                print("Name: \(player.name ?? ""), Age: \(player.age), Position: \(player.position ?? "")")
//            }
//        } catch {
//            print("Error fetching players: \(error)")
//        }
//    }
//}
import UIKit
import CoreData

class SavePlayerViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var playerNameTextField: UITextField!
    private var playerAgeTextField: UITextField!
    private var playerPositionTextField: UITextField!
    private var saveButton: UIButton!
    private var readButton: UIButton!
    private var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Save Player"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(titleLabel)

        playerNameTextField = UITextField()
        playerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        playerNameTextField.borderStyle = .roundedRect
        playerNameTextField.placeholder = "Name"
        view.addSubview(playerNameTextField)

        playerAgeTextField = UITextField()
        playerAgeTextField.translatesAutoresizingMaskIntoConstraints = false
        playerAgeTextField.borderStyle = .roundedRect
        playerAgeTextField.placeholder = "Age"
        view.addSubview(playerAgeTextField)

        playerPositionTextField = UITextField()
        playerPositionTextField.translatesAutoresizingMaskIntoConstraints = false
        playerPositionTextField.borderStyle = .roundedRect
        playerPositionTextField.placeholder = "Position"
        view.addSubview(playerPositionTextField)

        saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.backgroundColor = UIColor.systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        view.addSubview(saveButton)
        
        readButton = UIButton(type: .system)
        readButton.translatesAutoresizingMaskIntoConstraints = false
        readButton.setTitle("Read", for: .normal)
        readButton.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        readButton.backgroundColor = UIColor.systemGreen
        readButton.setTitleColor(.white, for: .normal)
        readButton.layer.cornerRadius = 10
        view.addSubview(readButton)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            playerNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            playerNameTextField.widthAnchor.constraint(equalToConstant: 200),
            playerNameTextField.heightAnchor.constraint(equalToConstant: 40),

            playerAgeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerAgeTextField.topAnchor.constraint(equalTo: playerNameTextField.bottomAnchor, constant: 20),
            playerAgeTextField.widthAnchor.constraint(equalToConstant: 200),
            playerAgeTextField.heightAnchor.constraint(equalToConstant: 40),

            playerPositionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerPositionTextField.topAnchor.constraint(equalTo: playerAgeTextField.bottomAnchor, constant: 20),
            playerPositionTextField.widthAnchor.constraint(equalToConstant: 200),
            playerPositionTextField.heightAnchor.constraint(equalToConstant: 40),

            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: playerPositionTextField.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            readButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            readButton.widthAnchor.constraint(equalToConstant: 100),
            readButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func saveButtonTapped() {
        guard let playerName = playerNameTextField.text, !playerName.isEmpty else {
            showAlert(message: "Please enter a valid player name.")
            return
        }
        guard let playerAgeText = playerAgeTextField.text, let playerAge = Int16(playerAgeText) else {
            showAlert(message: "Please enter a valid age.")
            return
        }
        guard let playerPosition = playerPositionTextField.text, !playerPosition.isEmpty else {
            showAlert(message: "Please enter a valid player position.")
            return
        }

        savePlayer(name: playerName, age: playerAge, position: playerPosition)
    }
    
    @objc private func readButtonTapped() {
        readPlayers()
    }

    func savePlayer(name: String, age: Int16, position: String) {
        let entityName = String(describing: Player.self)
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("Failed to retrieve entity description for entity: \(entityName)")
            return
        }

        let player = Player(entity: entity, insertInto: context)
        player.name = name
        player.age = age
        player.position = position

        do {
            try context.save()
            showAlert(message: "Player saved successfully!")
        } catch {
            showAlert(message: "Error saving player: \(error.localizedDescription)")
        }
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func readPlayers() {
        let entityName = String(describing: Player.self)
        let fetchRequest: NSFetchRequest<Player> = NSFetchRequest<Player>(entityName: entityName)

        do {
            let players = try context.fetch(fetchRequest)
            var playersInfo = ""
            for player in players {
                let playerInfo = "Name: \(player.name ?? ""), Age: \(player.age), Position: \(player.position ?? "")\n"
                playersInfo += playerInfo
            }
            showAlert(message: playersInfo.isEmpty ? "No players found." : playersInfo)
        } catch {
            showAlert(message: "Error fetching players: \(error)")
        }
    }
  

}
