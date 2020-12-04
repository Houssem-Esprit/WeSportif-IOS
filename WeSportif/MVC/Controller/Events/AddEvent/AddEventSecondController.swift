

import UIKit
import MapKit
class AddEventSecondController: BaseViewController, MapCoordinatesDelegate, CoachDelegate {
    func coachChoosen(coatch: User) {
        self.coatch = coatch
    }
    
    func getData(lat: Double, Lang: Double) {
        self.lang = Lang
        self.lat = lat
    self.addPin()
        self.focusMapView()
    }
    
let segueId = "chooseCoach"
    var coatch: User? = nil {
        didSet {
            self.coachLabel.text = coatch?.nom
        }
    }
    var catId = 0
    var nomCategory = ""
    var dateEvent = ""
    let segueMapId = "map"
    var lang: Double = 0
    var lat: Double = 0
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnCoach: UIButton!
    @IBOutlet weak var coachLabel: UILabel!
    @IBOutlet weak var nextB: UIButton!
    
    
    @IBOutlet weak var descriptionArea: UITextView!
  
    @IBAction func nextBtnClicked(_ sender: UIButton) {

        ApiManager.shared.addNewEvent(titre: nomCategory, desc: descriptionArea.text, lat: lat, lang: lang, date: dateEvent, coachId: coatch?.cin ?? "", userId: UserDefaults.standard.string(forKey: "cin")!) { (response) in
                        debugPrint(response, "add event resp")
            if response != nil {
                AlertPopUp().showValidationAlert(title: "Event Added", msg: "Succcessfuly added", viewController: self, completion: {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            } else {
                AlertPopUp().getAlertWithOkMessage(title: "Error", message: "Please try again", viewController: self)
            }
                    }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showCoachList(_ sender: UIButton) {
        performSegue(withIdentifier: segueId, sender: self)
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func chooseCoachChanged(_ sender: UISwitch) {
        DispatchQueue.main.async {
            self.btnCoach.isHidden = sender.isOn ? false : true
             self.coachLabel.isHidden = sender.isOn ? false : true
        }
    }
    func addPin() {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lang)
        annotation.coordinate = centerCoordinate
        
        mapView.addAnnotation(annotation)
    }
    
    
    func focusMapView() {
        let mapCenter = CLLocationCoordinate2DMake( lat, lang)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: span)
        mapView.region = region
    }
    
    @IBAction func showMapBtnClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: segueMapId, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueMapId {
            if let mapVC = segue.destination as? MapEventViewController {
                mapVC.mapCoordinatesDelegate = self
            }
        }
        if segue.identifier == segueId {
            if let coatchVC = segue.destination as? CoachViewController {
                coatchVC.coachDelegate = self
            }
        }
        
    }
    


}
