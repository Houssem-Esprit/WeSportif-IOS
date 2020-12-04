

import Foundation
import UIKit

extension String {
    
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // check if full name is alphabetic
    func isValidName() -> Bool {
        // Alphabetic
        let alphabeticRegEx  = ".*[A-Za-z]+.*"
        let alphabeticTest = NSPredicate(format: "SELF MATCHES %@", alphabeticRegEx)
        return alphabeticTest.evaluate(with: self)
    }
    
    // checking password format
    func isValidPassword() -> Bool {
        
        return self.count > 7
    }
    
    
    func GetFormatedDate()-> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateFromInputString = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd" // Here you can use any dateformate for output date
        if(dateFromInputString != nil){
            return dateFormatter.string(from: dateFromInputString!)
        }
        else{
            debugPrint("could not convert date")
            return "N/A"
        }
    }
    
    
}

