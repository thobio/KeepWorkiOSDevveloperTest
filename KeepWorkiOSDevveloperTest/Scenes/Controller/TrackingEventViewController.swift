//
//  TrackingEventViewController.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 26/03/22.
//

import UIKit

class TrackingEventViewController :UIViewController {
    //MARK:- Property
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        swipAction()
    }
    // MARK:- Helper Function
    func swipAction(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
    }
    func addTableView(){
        TrackingViewModel.shared.delegate = self
        TrackingViewModel.shared.featchAllTracking()
        tableView.register(ListOfEventsInTheLocationCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    func dismissPage(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Selection
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizer.Direction.right:
                dismissPage()
            case UISwipeGestureRecognizer.Direction.left:
                debugPrint("Swiped left")
                default:
                    break
            }
        }
    }
    
    
}

extension TrackingEventViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TrackingViewModel.shared.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListOfEventsInTheLocationCell
        return TrackingViewModel.shared.cellTableView(cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event =  TrackingViewModel.shared.selectTheIteams(indexs: indexPath.row)
        DispatchQueue.main.async {
            let vc = DetailEventViewController()
            vc.view.backgroundColor = .white
            vc.id = event
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            TrackingViewModel.shared.cellDeleteFromTableView(indexPath: indexPath)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
}

extension TrackingEventViewController:TrackingViewModelDelegate {
    func reloadTableViewOrTheCollectionView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
