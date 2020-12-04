

import UIKit
import MapKit
class DetailsController: BaseViewController {
    var event: Event?
    let eventNameCellId = "nameEvent"
    let eventMapCell = "mapCell"
    let eventDetailsCell = "detailsCell"
    
    @IBOutlet weak var joinBtn: UIButton!
    let segueCommentID = "comment"
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var detailsTV: UITableView!
    
    @IBOutlet weak var eventTitle: UILabel!
    var joined: Bool = false {
        didSet {
            DispatchQueue.main.async {
                if self.joined {
                    self.joinBtn.setBackgroundImage(UIImage(named: "cancelJoin"), for: .normal)
                } else {
                     self.joinBtn.setBackgroundImage(UIImage(named: "join"), for: .normal)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let event = event, event != nil {
            DispatchQueue.main.async {
                 self.checkParticipation()
                 self.detailsTV.reloadData()
                self.checkParticipation()
            }
            self.eventTitle.text = event.titre ?? ""
            let baseImageUrlString: String = Route.imageEventFolder.description
            let url = URL(string: "\(baseImageUrlString)\(event.img ?? "")") as? URL
            if let urlImage = url {
                eventImage.kf.setImage(with: urlImage)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
          
            self.checkParticipation()
        }
    }
    
    @IBAction func commentBtnClicked(_ sender: UIButton) {
        performSegue(withIdentifier: segueCommentID, sender: self)
    }
    
    @IBAction func heartBtnClicked(_ sender: UIButton) {
        if joined { ApiManager.shared.removeParticipationEvent(idEvent: "\((event?.id)!)", userId: UserDefaults.standard.string(forKey: "cin")!) { (response) in
            if response != nil {
                debugPrint("removed")
            } else {
                debugPrint("error removing")
            }
            }
       
        } else {
            ApiManager.shared.participateToEvent(idEvent: "\((event?.id)!)", userId:  UserDefaults.standard.string(forKey: "cin")!) { (response) in
                if response != nil {
                    debugPrint("joined")
                } else {
                    debugPrint("error join")
                }
            }
        }
        joined = !joined
 
    }
    
   
    func checkParticipation() {
        ApiManager.shared.checkParticipation(idEvent: "\((event?.id)!)", userId: UserDefaults.standard.string(forKey: "cin")!) { (isSuccess) in
            DispatchQueue.main.async {
                if let success = isSuccess {
                    self.joined = success
                }
            }
            
        }
    }
    
    
}

extension DetailsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.selectionStyle = .none
        switch indexPath.row {

        case 0:
            if let secondCell = tableView.dequeueReusableCell(withIdentifier: eventDetailsCell, for: indexPath) as? DetailsCell {
                secondCell.eventDateLabel.text = event?.dateDebut.GetFormatedDate() ?? ""
secondCell.coachName.text = event?.coach ?? ""
                cell = secondCell
            }
            
            
        default:
            if let thirdCell = tableView.dequeueReusableCell(withIdentifier: eventMapCell, for: indexPath) as? MapCell {
                if let event = event {
                    thirdCell.event = event
                    thirdCell.addPin()
                    thirdCell.focusMapView()
                }
                cell = thirdCell
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.height * 0.2
        default:
            return UIScreen.main.bounds.height * 0.25


        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueCommentID {
            if let commentVC = segue.destination as? CommentViewController {
                if let event = event, event != nil {
                     commentVC.event = self.event
                }
            }
        }
    }
    
    
}
