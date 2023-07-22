import UIKit

class PlayerViewController: UIViewController {
    private let playerNameKey = "PlayerName"
    private var playerNameTextField: UITextField!
    private var saveButton: UIButton!
    private var readButton: UIButton!
    private var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter a Player's Name"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(titleLabel)

        playerNameTextField = UITextField()
        playerNameTextField.translatesAutoresizingMaskIntoConstraints = false
        playerNameTextField.borderStyle = .roundedRect
        view.addSubview(playerNameTextField)

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
            titleLabel.bottomAnchor.constraint(equalTo: playerNameTextField.topAnchor, constant: -20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            playerNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerNameTextField.widthAnchor.constraint(equalToConstant: 200),
            playerNameTextField.heightAnchor.constraint(equalToConstant: 40),

            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: playerNameTextField.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40),

            readButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            readButton.widthAnchor.constraint(equalToConstant: 100),
            readButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        if let savedPlayerName = UserDefaults.standard.string(forKey: playerNameKey) {
            playerNameTextField.text = savedPlayerName
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerNameTextField.text = "" // Clear the text field
    }

    @objc private func saveButtonTapped() {
        guard let playerName = playerNameTextField.text, !playerName.isEmpty else {
            showAlert(message: "Please enter a valid player name.")
            return
        }

        UserDefaults.standard.set(playerName, forKey: playerNameKey)
        showAlert(message: "Player name saved successfully!")
    }

    @objc private func readButtonTapped() {
        if let savedPlayerName = UserDefaults.standard.string(forKey: playerNameKey) {
            print("Saved player name: \(savedPlayerName)")
            showAlert(message: "Saved player name: \(savedPlayerName)")
        } else {
            print("No player name found.")
            showAlert(message: "No player name found.")
        }
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
