

import Foundation
import UIKit
extension HomeViewController {
    
    func getAllEvents() {
        ApiManager.shared.getAllEventsWS { (eventsResponse) in
            if let eventsResp = eventsResponse, let events = eventsResp.events, !events.isEmpty {
                self.eventsArray = events
            }
        }
    }
    func getAllNearEvents() {
        ApiManager.shared.getAllNearEventsWS{ (eventsResponse) in
            if let eventsResp = eventsResponse, let events = eventsResp.events, !events.isEmpty {
                self.nearEventsArray = events
            }
            debugPrint(eventsResponse, "near event response")
        }
    }

    
}
