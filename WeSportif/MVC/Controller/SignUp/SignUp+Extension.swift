

import Foundation
import UIKit

extension SignUpViewController {
    
    
   
    public func showErrorEmailMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong email", message: "Please fill with a valid email", viewController: self)
    }
    public func showErrorPasswordMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong password", message: "your password must be at least 8 characters", viewController: self)
    }

    public func showErrorUserNameMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong userName", message: "Please fill with a valid userName", viewController: self)
    }
    public func showErrorConfirmPasswordMSG() {
        AlertPopUp().getAlertWithOkMessage(title: "Wrong password", message: "Please confirm with the same passwords", viewController: self)
    }

}
