

import UIKit

class IMCViewController: BaseViewController {
let segueImc = "calculateIMC"
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    var imcElement: ImcElement? = nil {
        
        didSet {
            height.text = "\(imcElement?.hauteur ?? 0)"
            weightLabel.text =   "\(imcElement?.poids ?? 0)"
            debugPrint(imcElement?.valeurImc )
          self.imc = imcElement?.valeurImc ?? 0
        }
    }
    var imc: Double = 0 {
        didSet {
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
            }
        }
    }
    let imcCellIdentifier = "IMCCELL"
    let chartCellIdentifier = "chartCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
self.setUpClassName(className: "Stats")
        getImcFromWS()
        
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == segueImc {
            if
                let imcVC = segue.destination as? IMCCalculViewController {
                imcVC.imcDelegate = self
            }
        }
    }

    

}


extension IMCViewController: ImcDelegate {
    func calculateImc(height: Double, weight: Double, imc: Double) {
        DispatchQueue.main.async {
            self.height.text = "\(height)"
            self.weightLabel.text = "\(weight)"
            let imcToReturn = Double(imc).rounded()
            self.imc = imcToReturn
            debugPrint(imc, "IMC is")
        }
    }
    
    
}
