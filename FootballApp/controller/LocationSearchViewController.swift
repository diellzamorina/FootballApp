
import UIKit
import MapKit

class LocationSearchViewController: UIViewController {

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private let searchBox: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search Location"
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Add the map view and search box to the view
        view.addSubview(mapView)
        view.addSubview(searchBox)

        // Configure layout constraints for the map view
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
        ])

        // Configure layout constraints for the search box
        NSLayoutConstraint.activate([
            searchBox.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            searchBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBox.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        // Set up map view delegate and initial map region
        mapView.delegate = self
        let initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.6629, longitude: 21.1655), latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(initialRegion, animated: true)

        // Add a sample annotation for Prishtina
        let prishtinaAnnotation = MKPointAnnotation()
        prishtinaAnnotation.coordinate = CLLocationCoordinate2D(latitude: 42.6629, longitude: 21.1655)
        prishtinaAnnotation.title = "Prishtina"
        mapView.addAnnotation(prishtinaAnnotation)

        // Add more locations as needed

        // Set up search box delegate
        searchBox.delegate = self
    }

    private func addLocation(with title: String, latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

    private func drawRoute(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate { [weak self] response, error in
            guard let self = self, let route = response?.routes.first else {
                return
            }

            self.mapView.addOverlay(route.polyline)
        }
    }
}

extension LocationSearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue.withAlphaComponent(0.7)
            renderer.lineWidth = 3.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

extension LocationSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        if let searchText = searchBar.text, !searchText.isEmpty {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(searchText) { [weak self] placemarks, error in
                guard let self = self else { return }

                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                    return
                }

                if let placemark = placemarks?.first {
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    self.mapView.removeOverlays(self.mapView.overlays)

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = placemark.location!.coordinate
                    annotation.title = searchText
                    self.mapView.addAnnotation(annotation)
                    self.mapView.selectAnnotation(annotation, animated: true)

                    let cities = [
                        ("London Arsenal Stadium", 51.5549, -0.1084),
                        ("Manchester", 53.4839, -2.2446)
                        // Add more stadiums as needed
                    ]

                    for city in cities {
                        self.addLocation(with: city.0, latitude: city.1, longitude: city.2)
                        self.drawRoute(from: annotation.coordinate, to: CLLocationCoordinate2D(latitude: city.1, longitude: city.2))
                    }
                }
            }
        }
    }
}
