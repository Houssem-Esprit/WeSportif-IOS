

import UIKit
import LocalAuthentication

protocol TouchDelegate: class {
    func redirectToHome(isSuccess: Bool)
}

class TouchIdViewController: UIViewController {
    weak var touchDelegate: TouchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startScanClicked(_ sender: UIButton) {
        self.authenticateUser()
        
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Authenticication method
    
    func authenticateUser() {
        // get context
        
        let context = LAContext()
        var error: NSError?
        
        /// check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthentication , error: &error) {
            
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthentication , localizedReason: reason, reply:
                {(success, error) in
                    
                    /// Result must be handled in main thread
                    
                    DispatchQueue.main.async {
                        let messageToShow = success ? "Touch ID Authentication Succeeded" : "Touch ID Authentication Failed"
                        if success {
                            self.dismiss(animated: true, completion: {
                                self.touchDelegate?.redirectToHome(isSuccess: true)
                            })
                        } else {
                             self.showAlertController(messageToShow)
                        }
                    }
            })
        }
        else {
            showAlertController("Touch ID not available")
        }
    }
    
}
