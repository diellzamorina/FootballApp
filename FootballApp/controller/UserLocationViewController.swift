
import UIKit
import MapKit
import CoreLocation

class UserLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
//    private let showLocationButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        mapView.delegate = self
        mapView.frame = view.bounds
        mapView.showsUserLocation = true
        view.addSubview(mapView)

//        showLocationButton.setTitle("Your Location", for: .normal)
//        showLocationButton.backgroundColor = .systemBlue
//        showLocationButton.setTitleColor(.white, for: .normal)
//        showLocationButton.layer.cornerRadius = 5
//        showLocationButton.addTarget(self, action: #selector(showUserLocation), for: .touchUpInside)
//        view.addSubview(showLocationButton)

        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorization()
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        case .denied, .restricted:
            showLocationAccessAlert()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            fatalError("Unknown location authorization status")
        }
    }

    func startUpdatingLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else {
            return
        }

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation.coordinate
        annotation.title = "You are here"
        mapView.addAnnotation(annotation)

        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

    func showLocationAccessAlert() {
        let alertController = UIAlertController(title: "Location Access Required", message: "Please enable location access in Settings to show your location on the map.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }

    @objc private func showUserLocation() {
        if let userLocation = mapView.userLocation.location {
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation.coordinate
            annotation.title = "You are here"
            mapView.addAnnotation(annotation)

            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    private func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

//        showLocationButton.translatesAutoresizingMaskIntoConstraints = false
//        showLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        showLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        showLocationButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        showLocationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

