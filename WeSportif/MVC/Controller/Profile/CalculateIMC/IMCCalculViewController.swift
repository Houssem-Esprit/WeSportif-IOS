

import UIKit

protocol ImcDelegate: class {
    func  calculateImc (height: Double, weight: Double, imc: Double)
}



class IMCCalculViewController: UIViewController {
    weak var imcDelegate: ImcDelegate?
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    
    var imc: Double = 0
    var height: Double = 0
    var weight: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func updateImcBtnClicked(_ sender: UIButton) {
        guard let heightString = heightTF.text, !heightString.isEmpty else {
            debugPrint("empty height")
            return
        }
        guard let weightString = weightTF.text, !weightString.isEmpty else {
            debugPrint("empty height")
            return
        }
        
        height = (heightString as NSString).doubleValue / 100
          weight = (weightString as NSString).doubleValue 
        self.calcuateImcFromFields(height: height, weight: weight) { (result) in
            self.imc = result
            self.dismiss(animated: true, completion: {
                self.imcDelegate?.calculateImc(height: self.height, weight: self.weight, imc: self.imc)
            })
        }
    }
    
    
    @IBAction func exitBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    func  calcuateImcFromFields(height: Double, weight: Double, completion: @escaping (Double) -> Void) {
        let imc = weight / (height * height)
        completion(imc)
    }
 

}
