

import Foundation
import Alamofire

class ApiManager {
    
    let decoder: JSONDecoder
    static let shared = ApiManager()
    
    init() {
        decoder = JSONDecoder()
    }
    
    
    // MARK: - Request login
    func  login (username:String ,password:String ,completion: @escaping (UserStats?)-> Void) {
        let url_service: String = Route.login.description
        let user_id: [String: Any] = ["login": username, "pass": password]
        Alamofire.request(url_service, method: .post, parameters: user_id, encoding: URLEncoding(), headers: ["Content-Type":"application/x-www-form-urlencoded"])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        
                        guard let data = response.data else { return }
                        do {
                            
                            let responseRequest = try self.decoder.decode(UserStats.self, from: data)
                            if (responseRequest.userInformations ?? "") == "Connection success" {
                                
                                completion(responseRequest)
                            } else {
                                completion(nil)
                            }
                            
                            
                        } catch let error {
                            print(error)
                            UserDefaults.standard.set(false, forKey: "loggedIn")
                            completion(nil)
                        }
                    }
                case .failure( _):
                    
                    UserDefaults.standard.set(false, forKey: "loggedIn")
                    completion(nil)
                }
        }
    }
    
    
    func  signUpUser (userParams: [String: Any], completion: @escaping (String?)-> Void) {
        //        let url_service: String = Route.signUp.description
        //        let user_id: [String: Any] = userParams
        //        Alamofire.request(url_service, method: .post, parameters: user_id, encoding: URLEncoding(), headers: ["Content-Type":"application/json"])
        //            .validate(statusCode: 200...500)
        //            .responseJSON { response in
        //                switch response.result {
        //                case .success( _):
        //                    if response.result.value != nil{
        //                        guard let data = response.data else { return }
        //                        do {
        //
        //                            let responseUser = try self.decoder.decode(UserStats.self, from: data)
        //                            completion(responseUser.userInformations)
        //                        } catch let error {
        //                            print(error)
        //                            completion("")
        //                        }
        //                    }
        //                case .failure( _):
        //                    completion(nil)
        //                }
        //        }
        
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "cin=\(userParams["cin"]!)&nom=\(userParams["nom"]!)&prenom=\(userParams["prenom"]!)&login=\(userParams["login"]!)&pass=\(userParams["pass"]!)&email=\(userParams["email"]!)&numTel=\(userParams["numTel"]!)&date_naissance=\(userParams["date_naissance"]!)&img=img.jpg&role=\(userParams["role"]!)&cat=%5B%7B%22idCat%22%3A%201%7D%5D&coverImg=cover.jpg"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://wesportiftif.eu-4.evennode.com/register")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                
                let responseUser = try self.decoder.decode(UserStats.self, from: data)
                completion(responseUser.userInformations)
            } catch let error {
                print(error)
                completion("")
            }
            
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    
    
    //    func  updateUserWS (userParams: [String: Any], completion: @escaping (UpdateResponse?)-> Void) {
    //        let url_service: String = Route.updateUserPath.description
    //        let user_id: [String: Any] = userParams
    //        Alamofire.request(url_service, method: .post, parameters: user_id, encoding: URLEncoding(), headers: ["Content-Type":"application/json"])
    //            .validate(statusCode: 200...500)
    //            .responseJSON { response in
    //                switch response.result {
    //                case .success( _):
    //                    if response.result.value != nil{
    //                        guard let data = response.data else { return }
    //                        do {
    //
    //                            let responseUser = try self.decoder.decode(UpdateResponse.self, from: data)
    //                            completion(responseUser)
    //                        } catch let error {
    //                            print(error)
    //                            completion(nil)
    //                        }
    //                    }
    //                case .failure( _):
    //                    completion(nil)
    //                }
    //        }
    //    }
    //
    func updateUser(cin: String,email:String,tel: String,birthday: String, completion: @escaping (UpdateResponse?)-> Void)  {
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "cin=\(cin)&email=\(email)&numTel=\(tel)&date_naissance=\(birthday)"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://wesportiftif.eu-4.evennode.com/updateuser")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                
                let responseEvents = try self.decoder.decode(UpdateResponse.self, from: data)
                completion(responseEvents)
            } catch let error {
                print(error)
                completion(nil)
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
    
    func  getAllEventsWS (completion: @escaping (EventResponse?)-> Void) {
        let url_service: String = Route.getEvents.description
        let user_id: [String: Any] = [:]
        Alamofire.request(url_service, method: .get, parameters: user_id, encoding: URLEncoding(), headers: [:])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        guard let data = response.data else { return }
                        do {
                            
                            let responseEvents = try self.decoder.decode(EventResponse.self, from: data)
                            completion(responseEvents)
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    completion(nil)
                }
        }
    }
    
    func  getACategoriesWS (completion: @escaping (Category?)-> Void) {
        let url_service: String = Route.categoriesPath.description
        debugPrint(url_service)
        Alamofire.request(url_service, method: .get, parameters: [:], encoding: URLEncoding(), headers: [:])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        guard let data = response.data else { return }
                        do {
                            
                            let responseEvents = try self.decoder.decode(Category.self, from: data)
                            completion(responseEvents)
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    completion(nil)
                }
        }
    }
    
    // MARK: - Request login
    func  addEventWS (params: [String: Any] ,completion: @escaping (AddEventResponse?)-> Void) {
        let url_service: String = Route.addeventPath.description
        Alamofire.request(url_service, method: .post, parameters: params, encoding: URLEncoding(), headers: ["Content-Type":"application/x-www-form-urlencoded"])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        guard let data = response.data else { return }
                        do {
                            let responseRequest = try self.decoder.decode(AddEventResponse.self, from: data)
                            if (responseRequest.eventInformations ?? "") == "Event added" {
                                completion(responseRequest)
                            } else {
                                completion(nil)
                            }
                            
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    
                    UserDefaults.standard.set(false, forKey: "loggedIn")
                    completion(nil)
                }
        }
    }
    
    
    func participateToEvent(idEvent: String, userId: String ,completion: @escaping (ParticipationResponse?)-> Void) {
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "cin=\(userId)&eventId=\(idEvent)"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://wesportiftif.eu-4.evennode.com/joinevent")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            
            do {
                let responseRequest = try self.decoder.decode(ParticipationResponse.self, from: data)
                if (responseRequest.eventInformations ?? "") == "User registered" {
                    completion(responseRequest)
                } else {
                    completion(nil)
                }
                
            } catch let error {
                print(error)
                completion(nil)
            }
            
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
    
    func removeParticipationEvent(idEvent: String, userId: String ,completion: @escaping (ParticipationResponse?)-> Void) {
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "cin=\(userId)&eventId=\(idEvent)"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://wesportiftif.eu-4.evennode.com/delparticipation")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            
            do {
                let responseRequest = try self.decoder.decode(ParticipationResponse.self, from: data)
                if (responseRequest.eventInformations ?? "") == "Participation deleted" {
                    completion(responseRequest)
                } else {
                    completion(nil)
                }
                
            } catch let error {
                print(error)
                completion(nil)
            }
            
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
    func checkParticipation(idEvent: String, userId: String ,completion: @escaping (Bool?)-> Void) {
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "cin=\(userId)&eventId=\(idEvent)"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://wesportiftif.eu-4.evennode.com/checkparticipation")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
    }
    
    
    func addNewEvent(titre: String,desc: String,lat: Double, lang: Double,date: String,coachId: String, userId: String ,completion: @escaping (AddEventResponse?)-> Void) {
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "titre=\(titre)&desc=\(desc)&capacite=20&lat=\(lat)&lng=\(lang)&lieu=&dateDeb_event=\(date)&dateFin_event=2020-01-06&heureDeb_event=09%3A00&heureFin_event=12%3A30&coach=\(coachId)&e_admin=\(userId)&cat=3&img=img.jpg"
        let postData =  parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://wesportiftif.eu-4.evennode.com/addevent")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let responseRequest = try self.decoder.decode(AddEventResponse.self, from: data)
                if (responseRequest.eventInformations ?? "") == "Event added" {
                    completion(responseRequest)
                } else {
                    completion(nil)
                }
                
            } catch let error {
                print(error)
                completion(nil)
            }
            
            
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    
    func  getAllNearEventsWS (completion: @escaping (EventResponse?)-> Void) {
        let url_service: String = Route.nearEvents.description
        debugPrint(url_service)
        let user_id: [String: Any] = [:]
        Alamofire.request(url_service, method: .get, parameters: user_id, encoding: URLEncoding(), headers: [:])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        guard let data = response.data else { return }
                        do {
                            
                            let responseEvents = try self.decoder.decode(EventResponse.self, from: data)
                            completion(responseEvents)
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    completion(nil)
                }
        }
    }
    
    
    func  getAllCoachesWS (completion: @escaping (Coaches?)-> Void) {
        let url_service: String = Route.coachesList.description
        debugPrint(url_service)
        Alamofire.request(url_service, method: .get, parameters: [:], encoding: URLEncoding(), headers: [:])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        guard let data = response.data else { return }
                        do {
                            
                            let responseEvents = try self.decoder.decode(Coaches.self, from: data)
                            completion(responseEvents)
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    completion(nil)
                }
        }
    }
    
    // MARK: - Request login
    func  getUserProfile (cin:Int, completion: @escaping (Profile?)-> Void) {
        let url_service: String = Route.login.description
        debugPrint("0\(cin)", "cin in url")
        debugPrint(String(format: "%01d", cin), "cin in url")
        debugPrint(Int(String(format: "%01d", cin)), "cin in url")
        
        let user_id: [String: Any] = ["cin": "0\(cin)"]
        Alamofire.request(url_service, method: .post, parameters: user_id, encoding: URLEncoding(), headers: ["Content-Type":"application/x-www-form-urlencoded"])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        
                        guard let data = response.data else { return }
                        do {
                            
                            let responseRequest = try self.decoder.decode(Profile.self, from: data)
                            debugPrint(responseRequest, "response User")
                            if (responseRequest.userInformations ?? "") == "Connection success" {
                                
                                completion(responseRequest)
                            } else {
                                completion(nil)
                            }
                            
                            
                        } catch let error {
                            print(error)
                            UserDefaults.standard.set(false, forKey: "loggedIn")
                            completion(nil)
                        }
                    }
                case .failure( _):
                    
                    UserDefaults.standard.set(false, forKey: "loggedIn")
                    completion(nil)
                }
        }
    }
    
    
    
    ////    // MARK: - Request login
    func  uploadImage (image: UIImage,imageName: String, completion: @escaping (String?)-> Void) {
        let url_service: String = Route.login.description
        
        
        let params: [String: String] = ["upload": imageName,"id": "07480126"]
        
        
        if let data = image.jpegData(compressionQuality: 0.2) {
            
            
            Alamofire.upload(multipartFormData: { MultipartFormData in
                
                
                
                MultipartFormData.append(data, withName: imageName , fileName: "image.jpeg" , mimeType: "image/jpeg")
                for(key,value) in params{
                    
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)}
                
            }, to: "http://wesportiftif.eu-4.evennode.com/uploadUserImg", encodingCompletion: {
                EncodingResult in
                switch EncodingResult{
                case .success(let upload, _, _):
                    upload.responseString{ response in
                        debugPrint("SUCCESS RESPONSE: \(response.value)")
                    }
                case .failure(let encodingError):
                    
                    print("ERROR RESPONSE: \(encodingError)")
                    
                }        })
            
            
        }
        
        
        
    }
    func uploadVideo(imageData: Data, fileName: String, onProgressUpdates: @escaping ((Double)->()), onComplition: @escaping ((UploadResult, String?)->())){
        uploadData(data: imageData, fileName: fileName, mimeType: "image/jpeg", onProgressUpdates: onProgressUpdates, onComplition: onComplition)
    }
    //        uploadData(data: videoData, fileName: fileName, mimeType: "video/quicktime", onProgressUpdates: onProgressUpdates, onComplition: onComplition)
    //    }
    
    func uploadData(data: Data, fileName: String, mimeType: String, onProgressUpdates: @escaping ((Double)->()), onComplition: @escaping ((UploadResult, String?)->())){
        let uploadUrl = "http://wesportiftif.eu-4.evennode.com/uploadUserImg"
        
        Alamofire.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            
            multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
            
        }, to: uploadUrl, method: .post, headers: ["Content-Type":"application/x-www-form-urlencoded"]) { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
            
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    onProgressUpdates(progress.fractionCompleted)
                })
                upload.responseJSON { dataResponse in
                    
                    guard let statusCode = dataResponse.response?.statusCode else {
                        onComplition(.unknownError, nil)
                        return
                    }
                    let result = dataResponse.result.value
                    debugPrint(dataResponse.response?.statusCode)
                    switch statusCode {
                    case 200:
                        
                        if var topController = UIApplication.shared.keyWindow?.rootViewController {
                            while let presentedViewController = topController.presentedViewController {
                                topController = presentedViewController
                            }
                            DispatchQueue.main.async {
                                AlertPopUp().showValidationAlert(title: "success", msg: "Your video is uploaded", viewController: topController , completion: {
                                    debugPrint("uploaded successfuly in bg")                            })
                            }}
                        
                        
                        
                        onComplition(.succes, "File uploaded with success")
                    case 500:
                        if var topController = UIApplication.shared.keyWindow?.rootViewController {
                            while let presentedViewController = topController.presentedViewController {
                                topController = presentedViewController
                            }
                            DispatchQueue.main.async {
                                AlertPopUp().showValidationAlert(title: "Fail", msg: "Your Fail upload", viewController: topController , completion: {
                                })
                            }}
                        onComplition(.serverError, nil)
                        debugPrint("error uploading")
                    default:
                        
                        onComplition(.unknownError, nil)
                        debugPrint("error upload")
                    }
                    
                }
            case .failure(let error):
                print("$ uploadData failed")
                print(error)
                debugPrint("fatal error")
                onComplition(.unknownError, nil)
            }
            
        }
    }
    
    enum UploadResult {
        case succes
        case serverError
        case unknownError
    }
    
    
    // MARK: - Request login
    func  getAllComments (idEvent:Int, completion: @escaping (Comment?)-> Void) {
        let url_service: String = Route.commentPath.description
        
        
        let user_id: [String: Any] = ["eventId": idEvent]
        Alamofire.request(url_service, method: .post, parameters: user_id, encoding: URLEncoding(), headers: ["Content-Type":"application/x-www-form-urlencoded"])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        
                        guard let data = response.data else { return }
                        do {
                            
                            let responseRequest = try self.decoder.decode(Comment.self, from: data)
                            debugPrint(responseRequest, "response User")
                            if (responseRequest.reactionInformations ?? "") == "Reactions retrieved" {
                                
                                completion(responseRequest)
                            } else {
                                completion(nil)
                            }
                            
                            
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    
                    completion(nil)
                }
        }
    }
    
    func  addComments (text: String,idEvent:Int, completion: @escaping (AddComment?)-> Void) {
        let url_service: String = Route.addCommentUrl.description
        let cinInt = Int(UserDefaults.standard.string(forKey: "cin")!)!
        
        let user_id: [String: Any] = ["eventId": idEvent,"comment":text, "cin": cinInt]
        debugPrint(user_id, "params")
        Alamofire.request(url_service, method: .post, parameters: user_id, encoding: URLEncoding(), headers: ["Content-Type":"application/x-www-form-urlencoded"])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        
                        guard let data = response.data else { return }
                        do {
                            
                            let responseRequest = try self.decoder.decode(AddComment.self, from: data)
                            debugPrint(responseRequest, "add comment")
                            if (responseRequest.reactionInformations ?? "") == "Reactions added" {
                                
                                completion(responseRequest)
                            } else {
                                completion(nil)
                            }
                            
                            
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    
                    completion(nil)
                }
        }
    }
    
    
    func  getImc ( completion: @escaping (Imc?)-> Void) {
        let url_service: String = Route.imcPath.description
        let cinInt = Int(UserDefaults.standard.string(forKey: "cin")!)!
        
        let user_id: [String: Any] = [ "cin": cinInt]
        debugPrint(user_id, "paramsimc")
        Alamofire.request(url_service, method: .post, parameters: user_id, encoding: URLEncoding(), headers: ["Content-Type":"application/x-www-form-urlencoded"])
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success( _):
                    if response.result.value != nil{
                        
                        guard let data = response.data else { return }
                        do {
                            
                            let responseRequest = try self.decoder.decode(Imc.self, from: data)
                            debugPrint(responseRequest, "get imc")
                            if responseRequest  != nil {
                                
                                completion(responseRequest)
                            } else {
                                completion(nil)
                            }
                            
                            
                        } catch let error {
                            print(error)
                            completion(nil)
                        }
                    }
                case .failure( _):
                    
                    completion(nil)
                }
        }
    }
}

