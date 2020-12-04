

import Foundation
import UIKit
class AlertPopUp {
    init() {
    }
    
    func getAlertWithOkMessage(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        viewController.present(alert, animated: true)
        
    }
    func showValidationAlert(title: String, msg: String , viewController: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
        })
        
        alert.addAction(alertAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    func showValidationAlertYesNo(title: String, msg: String , viewController: UIViewController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertActionYes = UIAlertAction(title: "Yes", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
            
        })
        let alertActionNo = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alert.addAction(alertActionYes)
        alert.addAction(alertActionNo)
        viewController.present(alert, animated: true, completion: nil)
    }
}
