

import Foundation
enum BaseUrlApi: String {
    
    case baseUrl
    var base: String {
        switch self {
        case .baseUrl:
            return "http://wesportiftif.eu-4.evennode.com"
        }
    }
}
extension BaseUrlApi: CustomStringConvertible {
    var description: String {
        return base
    }
    var baseDescription: String { return  base }
}

enum Route {
    case login
    case signUp
    case imageEventFolder
    case imageUserFolder
    case getEvents
    case nearEvents
    case profileUser
    case commentPath
    case addCommentUrl
    case imcPath
    case categoriesPath
    case coachesList
    case addeventPath
    case updateUserPath
    
    var path: String {
        
        switch self {
          case .login :
            return "/login"
        case .signUp:
            return "/register"
        case .imageEventFolder:
            return "/uploads/events/"
        case .imageUserFolder:
            return "/uploads/users/"
        case .getEvents:
            return "/getevents"
        case .nearEvents:
            return "/getnearevents"
        case .profileUser:
            return "/getuserdetails"
        case .commentPath:
            return "/geteventreactions"
        case .addCommentUrl:
            return "/addcomment"
        case .imcPath:
            return "/getimc"
        case .categoriesPath:
            return "/getcategories"
        case .coachesList:
            return "/getcoachs"
        case .addeventPath:
            return "/addevent"
        case .updateUserPath:
            return "/updateuser"
            
        }
    }
    
}
extension Route: CustomStringConvertible {
    var description: String { return  BaseUrlApi.baseUrl.description.appending(path) }
}


