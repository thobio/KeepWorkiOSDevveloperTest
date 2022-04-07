//
//  TrackingViewModel.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 28/03/22.
//

import UIKit
import CoreData

protocol TrackingViewModelDelegate {
    func reloadTableViewOrTheCollectionView()
}
class TrackingViewModel {
    
    static let shared = TrackingViewModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate:TrackingViewModelDelegate?
    
    var tracking:[Tracking]?{
        didSet {
            if tracking?.count != 0 {
                delegate?.reloadTableViewOrTheCollectionView()
            }else{
                
            }
        }
    }
    
    func featchAllTracking(){
        guard let userId:String = UserDefaults.standard.string(forKey: UserId) else {return}
        let fetchRequestUser = Tracking.fetchRequest()
        fetchRequestUser.predicate = NSPredicate(format: "userId == %@",userId)
        do {
            self.tracking =  try context.fetch(fetchRequestUser)
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func numberOfItemsInSection() -> Int{
        return self.tracking?.count ?? 0
    }
    
    func cellTableView(cell:ListOfEventsInTheLocationCell,indexPath:IndexPath) -> ListOfEventsInTheLocationCell{
        let events = self.tracking![indexPath.row].event?.allObjects as! [Event]
        cell.eventNameLabel.text = events[0].eventName
        cell.thumbnailImage.image = UIImage(named: events[0].imageName!)
        cell.eventSubTitleLabel.text = events[0].loc
        let imageString = events[0].type == true ? "paid" : "free"
        cell.paidOrFree.image = UIImage(named: imageString)
        return cell
    }
    
    func cellDeleteFromTableView(indexPath:IndexPath){
        guard let deleteIteams = self.tracking?[indexPath.row] else { return }
        self.context.delete(deleteIteams)
        do {
            try context.save()
            self.tracking?.remove(at: indexPath.row)
        }catch {
            debugPrint("Error")
        }
    }
    func selectTheIteams(indexs:Int) -> Event {
        let events = self.tracking![indexs].event?.allObjects as! [Event]
        return events[0]
    }
}
