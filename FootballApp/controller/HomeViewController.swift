//
//  HomeViewController.swift
//  FootballApp
//
//  Created by user231820 on 4/17/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let firstName = user?.firstName {
            print("first name : \(firstName)")
                    firstNameLabel.text = "First Name: \(firstName)"
                }
                
                if let lastName = user?.lastName {
                    print("last name : \(lastName)")
                    lastNameLabel.text = "Last Name: \(lastName)"
                }
                
                if let email = user?.email {
                    emailLabel.text = "Email: \(email)"
                }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "MenuSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            // Access the destination view controller and pass data if needed
            if let menuViewController = segue.destination as? MenuViewController {
                // Pass any required data to the MenuViewController
                // menuViewController.property = value
            }
        }
    }

}
