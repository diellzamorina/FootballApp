//
//  SignUpViewController.swift
//  FootballApp
//
//  Created by user231820 on 4/18/23.
//

import UIKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func signupButtonPressed(_ sender: UIButton) {
        // Create an instance of the User model and set its properties
        let user = User(firstName: firstNameTextField.text ?? "", lastName:lastNameTextField.text ?? "" , email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
               // Trigger the segue and pass the user data to the HomeViewController
               performSegue(withIdentifier: "fromSignupToHome", sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "fromSignupToHome" {
                if let destinationVC = segue.destination as? HomeViewController {
                    // Set the properties of the HomeViewController with the user data
                    if let user = sender as? User {
                        destinationVC.user = user
                    }
                }
            }
        }
}
