import UIKit

class ProfileViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let chooseImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose Profile Picture", for: .normal)
        button.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        animateViews()
    }
    
    private func animateViews() {
            profileImageView.alpha = 0
            nameLabel.alpha = 0
            chooseImageButton.alpha = 0
            
            UIView.animate(withDuration: 1.0, delay: 0.2, options: [.curveEaseInOut], animations: {
                self.profileImageView.alpha = 1
                self.nameLabel.alpha = 1
                self.chooseImageButton.alpha = 1
            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
                self.profileImageView.transform = .identity
            }, completion: nil)
        }
    
    private func setupViews() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(chooseImageButton)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            
            chooseImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseImageButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func chooseImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
