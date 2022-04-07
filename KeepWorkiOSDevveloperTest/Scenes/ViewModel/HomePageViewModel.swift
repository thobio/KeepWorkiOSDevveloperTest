//
//  HomePageViewModel.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 23/03/22.
//

import CoreData
import Foundation
import UIKit

protocol HomePageViewModelDelegate {
    func callBackWithSuccess()
}

class HomePageViewModel {
    
    static let shared = HomePageViewModel()
    var userName:String?
    var delegate:HomePageViewModelDelegate?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var userList:[User]? {
        didSet {
            if userList?.count == 0 {
                addNewUser(userName: self.userName!)
            }else{
                let udid = userList?.first?.id
                UserDefaults.standard.set(udid, forKey: UserId)
                delegate?.callBackWithSuccess()
            }
        }
    }
    
    // Getting all UserData from the CoreData
    func featchUserName(userName:String){
        self.userName = userName
        let fetchRequestUser = User.fetchRequest()
        fetchRequestUser.predicate = NSPredicate(format: "name == %@", userName)
        do {
            self.userList =  try context.fetch(fetchRequestUser)
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    // Add new User to coredata base
    func addNewUser(userName:String){
        let newUserAdded = User(context: self.context)
        newUserAdded.name = userName
        newUserAdded.id = UUID().uuidString
        UserDefaults.standard.set(newUserAdded.id, forKey: UserId)
        delegate?.callBackWithSuccess()
        do{
            try self.context.save()
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
