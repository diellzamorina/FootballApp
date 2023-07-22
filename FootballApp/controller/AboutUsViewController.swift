import UIKit
import WebKit
import CoreLocation

class AboutUsViewController: UIViewController, WKNavigationDelegate {


    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your name"
        return textField
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your email"
        textField.keyboardType = .emailAddress
        return textField
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Message"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.text = "Enter your message"
        textView.textColor = UIColor.lightGray
        return textView
    }()

    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupForm()

    }


    @IBAction func locationButtonTapped(_ sender: Any) {
    }
    @objc private func locationButtonTapped() {
            let locationSearchViewController = LocationSearchViewController()
            navigationController?.pushViewController(locationSearchViewController, animated: true)
        }





    private func setupForm() {
        // Add UI components to the view
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(messageLabel)
        view.addSubview(messageTextView)
        view.addSubview(submitButton)


        // Configure layout constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8).isActive = true
        messageTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        messageTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        messageTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 20).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc private func submitButtonTapped() {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let message = messageTextView.text else {
            return
        }

        // Handle form submission

        // Clear the form fields
        nameTextField.text = nil
        emailTextField.text = nil
        messageTextView.text = "Enter your message"
        messageTextView.textColor = UIColor.lightGray

        // Display a success message or perform other actions
        let alertController = UIAlertController(title: "Success", message: "Form submitted successfully", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}


