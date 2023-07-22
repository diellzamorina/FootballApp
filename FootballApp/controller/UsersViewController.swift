
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class UsersViewController: UIViewController {
    private var users: [APIUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
        ])

        fetchData { [weak self] users in
            guard let self = self else { return }
            self.users = users

            for user in self.users {
                let userView = self.createUserView(with: user)
                stackView.addArrangedSubview(userView)
            }
        }
    }

    private func fetchData(completion: @escaping ([APIUser]) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/users") else { return }

        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let users = self.parseUsers(from: json)
                completion(users)
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

    private func parseUsers(from json: JSON) -> [APIUser] {
        var users: [APIUser] = []
        for (_, userJSON) in json["users"] {
            let user = APIUser(
                firstName: userJSON["firstName"].stringValue,
                lastName: userJSON["lastName"].stringValue,
                image: userJSON["image"].stringValue,
                age: userJSON["age"].intValue,
                gender: userJSON["gender"].stringValue
            )
            users.append(user)
        }
        return users
    }
    private func createUserView(with user: APIUser) -> UIView {
        let userView = UIView()

        let imageView = UIImageView()
        if let imageURL = URL(string: user.image) {
            imageView.af.setImage(withURL: imageURL)
        }

        let displayNameLabel = UILabel()
        displayNameLabel.text = "\(user.firstName) \(user.lastName)"

        let ageLabel = UILabel()
        ageLabel.text = "Age: \(user.age)"

        let genderLabel = UILabel()
        genderLabel.text = "Gender: \(user.gender)"

        [imageView, displayNameLabel, ageLabel, genderLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            userView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: userView.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),

            displayNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            displayNameLabel.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10),

            ageLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            ageLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),

            genderLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            genderLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 5),
            genderLabel.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -10)
        ])

        return userView
    }

}

struct APIUser {
    let firstName: String
    let lastName: String
    let image: String
    let age: Int
    let gender: String
}
