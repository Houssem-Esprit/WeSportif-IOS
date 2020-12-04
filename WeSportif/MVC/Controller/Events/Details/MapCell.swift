

import UIKit
import MapKit
class MapCell: UITableViewCell {
//let locationManager = CLLocationManager()
    var event: Event? = nil {
        didSet {
            addPin()
            focusMapView()
        }
    }
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        debugPrint(event, "event in map")
        if event != nil {
            addPin()
            focusMapView()
        }

    }
    func addPin() {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: Double(event?.lat ?? "")!, longitude: Double(event?.lng ?? "")!)
        annotation.coordinate = centerCoordinate
        annotation.title = event?.lieu
        mapView.addAnnotation(annotation)
    }
    

    func focusMapView() {
        let mapCenter = CLLocationCoordinate2DMake( Double(event?.lat ?? "")!, Double(event?.lng ?? "")!)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        mapView.region = region
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



