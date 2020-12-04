

import UIKit

class tabBarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let isCoach: Bool = UserDefaults.standard.bool(forKey: "Coach"), isCoach == false {
            self.navigationController?.viewControllers = []
            let indexToRemove = 3
            if indexToRemove < self.viewControllers?.count ?? 0 {
                var viewControllers = self.viewControllers
                viewControllers?.remove(at: indexToRemove)
                self.navigationController?.setViewControllers(self.viewControllers!, animated: true)
                self.viewControllers = viewControllers
            }
        }
     
        
    }
}
