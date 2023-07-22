
import UIKit
import WebKit

class FootballSongsViewController: UIViewController {
    private var webView: WKWebView!
    private var scrollView: UIScrollView!
    
    private let songs: [(name: String, videoID: String, imageName: String)] = [
        ("Waving Flag - FIFA", "WTJSt4wP2ME", "waving"),
        ("Champions League Anthem", "6BNaeGJWzFw", "djellza"),
        ("Waka Waka - Shakira", "pRpeEdMmmQ0", "shakira"),
        ("We Will Rock You - Queen", "fJ9rUzIMcZQ", "maxresdefault"),
        ("Seven Nation Army - The White Stripes", "0J2QdDbelmY", "djellza"),
        ("Thunderstruck - AC/DC", "v2AC41dglnM", "imagine"),
        ("Eye of the Tiger - Survivor", "btPJPFnesV4", "djellza"),
        ("We Are the Champions - Queen", "04854XqcfCY", "djellza")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupScrollView()
        setupSongs()
        setupWebView()
    }

    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
  
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    

    private func setupSongs() {
        var previousSongView: UIView?
        
        for (index, song) in songs.enumerated() {
            let songView = createSongView(song)
            scrollView.addSubview(songView)
            
       
            songView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                songView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                songView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                songView.heightAnchor.constraint(equalToConstant: 100),
            ])
            
            if let previousSongView = previousSongView {
                songView.topAnchor.constraint(equalTo: previousSongView.bottomAnchor, constant: 8).isActive = true
            } else {
                songView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
            }
            
            previousSongView = songView
            
            // Add tap gesture recognizer to the song view
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(songTapped(_:)))
            songView.addGestureRecognizer(tapGesture)
      
            songView.tag = index
            
    
            let separatorView = createSeparatorView()
            scrollView.addSubview(separatorView)
            
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                separatorView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                separatorView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 1),
                separatorView.topAnchor.constraint(equalTo: songView.bottomAnchor),
            ])
        }
        
        if let lastSongView = previousSongView {
            lastSongView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8).isActive = true
        }
    }

    private func createSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
        return separatorView
    }

    
    private func createSongView(_ song: (name: String, videoID: String, imageName: String)) -> UIView {
        let songView = UIView()
        songView.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: song.imageName))
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        songView.addSubview(imageView)
        
     
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: songView.leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: songView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        let nameLabel = UILabel()
        nameLabel.text = song.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        songView.addSubview(nameLabel)
 
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: songView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: songView.centerYAnchor),
        ])
        
        return songView
    }
    
    private func setupWebView() {
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        // Configure layout constraints for the web view
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        webView.isHidden = true
    }
    
    @objc private func songTapped(_ sender: UITapGestureRecognizer) {
        guard let songView = sender.view else { return }
        let songIndex = songView.tag
        
        if songIndex < songs.count {
            let selectedSong = songs[songIndex]
            openYouTubeVideo(selectedSong.videoID)
        }
    }
    
    private func openYouTubeVideo(_ videoID: String) {
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)")!
        let youtubeRequest = URLRequest(url: youtubeURL)
        webView.load(youtubeRequest)
        webView.isHidden = false
    }
}
