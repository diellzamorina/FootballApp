

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let menuItems = ["Football Teams", "Football Matches", "Home", "Sign Out", "Profile","About Us", "Football Songs", "Players Gallery", "Users", "Player", "Save Players", "Location"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell")
        
        view.addSubview(tableView)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)


        switch indexPath.row {
        case 0:
          
            performSegue(withIdentifier: "FootballTeamsSegue", sender: nil)
        case 1:
            performSegue(withIdentifier: "MatchesSegue", sender: nil)
            break
        case 2:
            //diqka
            break
        case 3:
           //diqka
            break
        case 4:
        //diqka
            performSegue(withIdentifier: "ProfileSegue", sender: nil)
            break
        case 5:
            performSegue(withIdentifier: "AboutUsSegue", sender: nil)
            break
        case 6:
            performSegue(withIdentifier: "SongsSegue", sender: nil)
            break
        case 7:
            performSegue(withIdentifier: "PlayersSegue", sender: nil)
            break
        case 8:
            performSegue(withIdentifier: "UsersSegue", sender: nil)
            break
        case 9:
            performSegue(withIdentifier: "LastSegue", sender: nil)
            break
        case 10:
            performSegue(withIdentifier: "SaveSegue", sender: nil)
            break
        case 11:
            performSegue(withIdentifier: "LocationSegue", sender: nil)
            break
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FootballTeamsSegue" {
       
            if segue.destination is FootballTeamsViewController {
              
            }
        } else if segue.identifier == "ProfileSegue" {
      
            if segue.destination is ProfileViewController {
       
            }
        }else if segue.identifier == "MatchesSegue" {
        
            if segue.destination is FootballMatchesViewController {
             
            }
        }
        else if segue.identifier == "AboutUsSegue" {
           
            if segue.destination is AboutUsViewController {
            
            }
        }
        else if segue.identifier == "SongsSegue" {
         
            if segue.destination is FootballSongsViewController {
           
            }
        }
        else if segue.identifier == "PlayersSegue" {
    
            if segue.destination is TeamPlayersViewController {
            
            }
        }
        else if segue.identifier == "UsersSegue" {
        
            if segue.destination is UsersViewController {
               
            }
        }
        else if segue.identifier == "LastSegue" {
          
            if segue.destination is PlayerViewController {
       
            }
        }
        else if segue.identifier == "SaveSegue" {
           
            if segue.destination is SavePlayerViewController {
          
            }
        }
        else if segue.identifier == "LocationSegue" {
           
            if segue.destination is UserLocationViewController {
          
            }
        }
        
    }

}
