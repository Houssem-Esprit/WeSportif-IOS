

import UIKit
import Kingfisher
class HomeViewController: BaseViewController {
    var eventsArray : [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                self.eventsTV.reloadData()
            }
        }
    }
    var nearEventsArray : [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                if !self.nearEventsArray.isEmpty {
                    self.recommandCV.reloadData()
                }
            }
        }
    }
    var indexSelectedTV = 0
    let detailsSegueId = "details"
let eventCell = "eventCell"
    let recommandedCellId = "recommanded"
    let addEventSegueId = "addEvent"
    let eventsNames = ["jogging","tennis","health","zumba", "handball", "footing"]
    @IBOutlet weak var eventsTV: UITableView!
    @IBOutlet weak var recommandCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpClassName(className: "Events List")
      
        self.navigationItem.leftBarButtonItem = nil
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllEvents()
        self.getAllNearEvents()
    }
    @IBAction func addBtnClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: addEventSegueId, sender: self)
        
    }

    
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        
        let dateFromInputString = dateFormatter.date(from: date_string)
        dateFormatter.dateFormat = "dd-MM-yyyy" // Here you can use any dateformate for output date
        if(dateFromInputString != nil){
            return dateFormatter.string(from: dateFromInputString!)
        }
        else{
            debugPrint("could not convert date")
            return "N/A"
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventCell, for: indexPath) as? HomeCell

        populateCell(cell: cell, index: indexPath.row)
         cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelectedTV = indexPath.row
        performSegue(withIdentifier: detailsSegueId, sender: self)
    }
    
    
    func populateCell(cell: HomeCell?, index: Int) {
        let event: Event = eventsArray[index]
        let baseImageUrlString: String = Route.imageEventFolder.description
        let url = URL(string: "\(baseImageUrlString)\(event.img ?? "")") as? URL
        if let urlImage = url {
            cell?.eventImage.kf.setImage(with: urlImage)
        }
        cell?.eventDate.text = self.GetFormatedDate(date_string: event.dateDebut, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")

        cell?.eventName.text = event.titre
        
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearEventsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommandedCellId, for: indexPath) as? HomeCVCell
        populateNearEventCell(cell: cell, index: indexPath.item)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.6, height: collectionView.frame.height * 0.85)
    }
    
    func populateNearEventCell(cell: HomeCVCell?, index: Int) {
        let event: Event = eventsArray[index]
        let baseImageUrlString: String = Route.imageEventFolder.description
        let url = URL(string: "\(baseImageUrlString)\(event.img ?? "")") as? URL
        if let urlImage = url {
            cell?.eventImage.kf.setImage(with: urlImage)
        }
        cell?.eventDate.text = self.GetFormatedDate(date_string: event.dateDebut, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        
        cell?.eventName.text = event.nom
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueId {
            if let detailsVC = segue.destination as? DetailsController {
                detailsVC.event = eventsArray[indexSelectedTV]
            }
        }
    }
    
}
