//
//  DetailsViewModel.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 28/03/22.
//

import UIKit
import CoreData

protocol DetailsViewModelDelegate {
    func successFullyAddedTODB()
    func errorOnTheSave(errorMessage:String)
    func isTheEventAlreadyTracking()
}

class DetailsViewModel {
    
    static let shared = DetailsViewModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate:DetailsViewModelDelegate?
    
    var tracking:[Tracking]?{
        didSet {
            if tracking?.count == 0 {
                
            }else{
                delegate?.isTheEventAlreadyTracking()
            }
        }
    }
    
    func addTracking(event:Event){
        let addNewTracking = Tracking(context: self.context)
        addNewTracking.addToEvent(event)
        addNewTracking.trackingId = UUID().uuidString
        addNewTracking.userId = UserDefaults.standard.string(forKey: UserId)
        do{
            try self.context.save()
            delegate?.successFullyAddedTODB()
        }catch {
            delegate?.errorOnTheSave(errorMessage: error.localizedDescription)
        }
    }
    
    // Featch All The Event in the DB
    func featchAllTracking(event:Event){
        guard let userId:String = UserDefaults.standard.string(forKey: UserId) else {return}
        guard let eventId:String = event.id else {return}
        let fetchRequestUser = Tracking.fetchRequest()
        fetchRequestUser.predicate = NSPredicate(format: "userId == %@ AND ANY event.id == %@",userId, eventId)
        do {
            self.tracking =  try context.fetch(fetchRequestUser)
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
}
