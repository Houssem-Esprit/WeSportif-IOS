

import UIKit
import MapKit



protocol MapCoordinatesDelegate: class {
    func getData(lat: Double, Lang: Double)
}
class MapEventViewController: UIViewController, UISearchBarDelegate  {
    let locationManager = CLLocationManager()
    weak var mapCoordinatesDelegate: MapCoordinatesDelegate?
    @IBOutlet weak var mapView: MKMapView!
    var lang: Double = 0
     var lat: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = searchBtn
        
    }
    
    // MARK: VARIABLES
    lazy var searchBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "loop"), style: .plain, target: self, action: #selector(handlesearch(sender:)))
        return button
    }()
    
    
    
    // MARK: - Actions methods
    @objc func handlesearch(sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        self.present(searchController, animated: true, completion: nil)    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        
        
        let searchBarrequest = MKLocalSearch.Request()
        searchBarrequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchBarrequest)
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                debugPrint("error")
            } else {
//                if let annotations = self.mapView.annotations as? MKAnnotation{
//                    self.mapView.removeAnnotation(annotations )
//
//                }
                if !self.mapView.annotations.isEmpty {
                    self.mapView.removeAnnotations(self.mapView.annotations)
                }
                
                let lattitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                let annotation = MKPointAnnotation()
                self.lang = longitude!
                self.lat = lattitude!
                annotation.coordinate = CLLocationCoordinate2DMake(lattitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate , span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.mapCoordinatesDelegate?.getData(lat: self.lat, Lang: self.lang)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
