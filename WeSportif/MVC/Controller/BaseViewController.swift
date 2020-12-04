

import UIKit

class BaseViewController: UIViewController{
    // MARK: VARIABLES
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(handleBackAction(sender:)))
        
        return button
    }()
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add title controller
        setUpClassName(className: "Base")
        //set up buttons of navigation bar
        setUpNavigationItems()
        // Do any additional setup after loading the view.
    }
    // MARK: - Views methods
    func setUpNavigationItems() {
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    
    func setUpClassName(className: String) {
        
        self.title = className
        
    }
    
    func showAlertWithMsg(title: String, msg: String, cancelButtonTitle: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
        let action = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showValidationAlert(title: String, msg: String, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion()
            }
            
        })
        
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showChoicesAlert(title: String, msg: String,yesBtnTitle: String, noBtnTitle: String, completion: @escaping ((Bool) -> Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let noAlertAction = UIAlertAction(title: noBtnTitle, style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion(false)
            }
            
        })
        let yesAlertAction = UIAlertAction(title: yesBtnTitle, style: .default, handler: { _ in
            DispatchQueue.main.async {
                completion(true)
            }
            
        })
        
        
        alert.addAction(noAlertAction)
        alert.addAction(yesAlertAction)
        
        
        
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions methods
    @objc func handleBackAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    
    
}
