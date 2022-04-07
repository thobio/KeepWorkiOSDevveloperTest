//
//  ListofEventViewModel.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 23/03/22.
//

import UIKit
import CoreData

protocol ListofEventViewModelDelegate {
    func reloadTableViewOrTheCollectionView()
}

class ListofEventViewModel {
    static let shared = ListofEventViewModel()
    var delegate:ListofEventViewModelDelegate?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    var eventList:[Event]? {
        didSet {
            if eventList?.count == 0 {
                addEventListToTheDB()
            }else{
                delegate?.reloadTableViewOrTheCollectionView()
            }
        }
    }
    
    // init and check if there events in the DB
    init() {
        featchAllEvent()
    }
    
    // Featch All The Event in the DB
    func featchAllEvent(){
        do {
            self.eventList =  try context.fetch(Event.fetchRequest())
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    // Adding all The Event to the DB
    
    func addEventListToTheDB(){
        for dataItem in dataEventList {
            let addNewEvent = Event(context: self.context)
            addNewEvent.eventName = dataItem[0] as? String
            addNewEvent.subTitle = dataItem[1] as? String
            addNewEvent.type = dataItem[2] as! Bool
            addNewEvent.imageName = dataItem[3] as? String
            addNewEvent.loc = dataItem[4] as? String
            addNewEvent.id = UUID().uuidString
            do {
                try self.context.save()
                self.featchAllEvent()
            }catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func numberOfItemsInSection() -> Int{
        return self.eventList?.count ?? 0
    }
    
    func cellTableView(cell:ListOfEventsInTheLocationCell,indexPath:IndexPath) -> ListOfEventsInTheLocationCell{
        cell.eventNameLabel.text = self.eventList![indexPath.row].eventName
        cell.thumbnailImage.image = UIImage(named: self.eventList![indexPath.row].imageName!)
        cell.eventSubTitleLabel.text = self.eventList![indexPath.row].loc
        let imageString = self.eventList![indexPath.row].type == true ? "paid" : "free"
        cell.paidOrFree.image = UIImage(named: imageString)
        return cell
    }
    
    func cellColloctionView(cell:ListOfEventCollectionViewCell,indexPath:IndexPath) -> ListOfEventCollectionViewCell {
        cell.eventNameLabel.text = self.eventList![indexPath.row].eventName
        cell.thumbnailImage.image = UIImage(named: self.eventList![indexPath.row].imageName!)
        return cell
    }
    
    func selectTheIteams(indexs:Int) -> Event {
        return self.eventList![indexs]
    }
}
