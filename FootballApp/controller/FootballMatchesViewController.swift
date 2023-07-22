import UIKit
import MapKit

class FootballMatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    var matches: [Match] = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mapView.topAnchor),
            
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MatchCell.self, forCellReuseIdentifier: MatchCell.reuseIdentifier)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        loadMatches()
    }
    
    func loadMatches() {
        let geocoder = CLGeocoder()
        
        let match1 = Match(homeTeam: "Arsenal", awayTeam: "Liverpool", location: "Emirates Stadium, London", homeCoordinates: CLLocationCoordinate2D(latitude: 51.556, longitude: -0.106), awayCoordinates: CLLocationCoordinate2D(latitude: 53.430, longitude: -2.960), address: "75 Drayton Park, London N5 1BU, United Kingdom")
        let match2 = Match(homeTeam: "Manchester United", awayTeam: "Manchester City", location: "Old Trafford, Manchester", homeCoordinates: CLLocationCoordinate2D(latitude: 53.463, longitude: -2.291), awayCoordinates: CLLocationCoordinate2D(latitude: 53.485, longitude: -2.200), address: "Sir Matt Busby Way, Stretford, Manchester M16 0RA, United Kingdom")
        let match3 = Match(homeTeam: "Chelsea", awayTeam: "Tottenham Hotspur", location: "Stamford Bridge, London", homeCoordinates: CLLocationCoordinate2D(latitude: 51.492, longitude: -0.193), awayCoordinates: CLLocationCoordinate2D(latitude: 51.604, longitude: -0.065), address: "Fulham Rd, Fulham, London SW6 1HS, United Kingdom")
        
        matches = [match1, match2, match3]
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchCell.reuseIdentifier, for: indexPath) as? MatchCell else {
            return UITableViewCell()
        }
        
        let match = matches[indexPath.row]
        cell.configure(with: match)
        
        // Update watchLocationButton target and action
        cell.watchLocationButton.addTarget(self, action: #selector(watchLocationButtonTapped(_:)), for: .touchUpInside)
        cell.watchLocationButton.tag = indexPath.row
        
        // Update pathButton target and action
        cell.pathButton.addTarget(self, action: #selector(pathButtonTapped(_:)), for: .touchUpInside)
        cell.pathButton.tag = indexPath.row
        
        return cell
    }
    
    @objc private func watchLocationButtonTapped(_ sender: UIButton) {
        let match = matches[sender.tag]
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(match.address) { (placemarks, error) in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                // Handle geocoding error here
                return
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = "\(match.homeTeam) vs \(match.awayTeam)"
            self.mapView.addAnnotation(annotation)
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    @objc private func pathButtonTapped(_ sender: UIButton) {
        let match = matches[sender.tag]

        let sourcePlacemark = MKPlacemark(coordinate: match.homeCoordinates)
        let destinationPlacemark = MKPlacemark(coordinate: match.awayCoordinates)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destinationMapItem
        directionsRequest.transportType = .automobile

        let directions = MKDirections(request: directionsRequest)
        directions.calculate { [weak self] (response, error) in
            guard let route = response?.routes.first, let self = self else {
                // Handle direction calculation error here
                return
            }

            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlay(route.polyline)

            // Adjust the map's region to fit the entire route
            let routeRect = route.polyline.boundingMapRect
            self.mapView.setVisibleMapRect(routeRect, edgePadding: UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40), animated: true)
        }
    }
    
    func drawPath(source: MKPointAnnotation, destination: MKPointAnnotation) {
        let sourcePlacemark = MKPlacemark(coordinate: source.coordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destination.coordinate)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            if let response = response {
                let routes = response.routes
                for route in routes {
                    self.mapView.addOverlay(route.polyline)
                    print("Route name: \(route.name)")
                    print("Distance: \(route.distance / 1000) km")
                    print("Expected travel time: \(route.expectedTravelTime / 3600) hrs")
                }
            }
            if let error = error {
                print("Directions calculation error: \(error)")
            }
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "PinAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.red // Set the stroke color to red
            renderer.lineWidth = 3
            return renderer
        }

        return MKOverlayRenderer()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
}

class MatchCell: UITableViewCell {
    static let reuseIdentifier = "MatchCell"
    
    let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let watchLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Watch Location", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pathButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Directions", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(watchLocationButton)
        contentView.addSubview(pathButton)
        
        NSLayoutConstraint.activate([
            homeTeamLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            homeTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            awayTeamLabel.topAnchor.constraint(equalTo: homeTeamLabel.bottomAnchor, constant: 8),
            awayTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            watchLocationButton.topAnchor.constraint(equalTo: awayTeamLabel.bottomAnchor, constant: 16),
            watchLocationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            pathButton.topAnchor.constraint(equalTo: watchLocationButton.bottomAnchor, constant: 16),
            pathButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pathButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pathButton.widthAnchor.constraint(equalTo: watchLocationButton.widthAnchor),
            pathButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with match: Match) {
        homeTeamLabel.text = match.homeTeam
        awayTeamLabel.text = match.awayTeam
    }
}

struct Match {
    let homeTeam: String
    let awayTeam: String
    let location: String
    let homeCoordinates: CLLocationCoordinate2D
    let awayCoordinates: CLLocationCoordinate2D
    let address: String // Add address property
}
