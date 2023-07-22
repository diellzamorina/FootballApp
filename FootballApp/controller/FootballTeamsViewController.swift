import UIKit

class FootballTeam {
    let name: String
    let emblem: UIImage?

    init(name: String, emblem: UIImage?) {
        self.name = name
        self.emblem = emblem
    }
}

class FootballTeamsViewController: UIViewController {

    let footballTeams = [
        FootballTeam(name: "FC Barcelona", emblem: UIImage(named: "barcelona_emblem")),
        FootballTeam(name: "Real Madrid", emblem: UIImage(named: "madrid_emblem")),
        FootballTeam(name: "Manchester United", emblem: UIImage(named: "manchester_united_emblem")),
        FootballTeam(name: "Liverpool", emblem: UIImage(named: "liverpool_emblem")),
        FootballTeam(name: "Arsenal", emblem: UIImage(named: "arsenal_emblem")),
        FootballTeam(name: "Sevilla", emblem: UIImage(named: "sevilla_emblem")),
        FootballTeam(name: "Manchester City", emblem: UIImage(named: "manchester_city_emblem")),
        FootballTeam(name: "Chelsea", emblem: UIImage(named: "chelsea_emblem")),
        FootballTeam(name: "Galatasaray", emblem: UIImage(named: "galatasaray_emblem"))
       
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

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

        for team in footballTeams {
            let teamView = createTeamView(with: team)
            stackView.addArrangedSubview(teamView)
        }
    }

    func createTeamView(with team: FootballTeam) -> UIView {
        let teamView = UIView()
        teamView.backgroundColor = .lightGray
        teamView.translatesAutoresizingMaskIntoConstraints = false

        let emblemImageView = UIImageView(image: team.emblem)
        emblemImageView.contentMode = .scaleAspectFit
        emblemImageView.translatesAutoresizingMaskIntoConstraints = false
        teamView.addSubview(emblemImageView)

        let nameLabel = UILabel()
        nameLabel.text = team.name
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            emblemImageView.leadingAnchor.constraint(equalTo: teamView.leadingAnchor, constant: 10),
            emblemImageView.topAnchor.constraint(equalTo: teamView.topAnchor, constant: 10),
            emblemImageView.trailingAnchor.constraint(equalTo: teamView.trailingAnchor, constant: -10),
            emblemImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.leadingAnchor.constraint(equalTo: teamView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: teamView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: emblemImageView.bottomAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: teamView.bottomAnchor, constant: -10)
        ])

        return teamView
    }
}
