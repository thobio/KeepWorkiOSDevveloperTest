//
//  ListOfEventViewController.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 22/03/22.
//

import UIKit

class ListOfEventViewController:UIViewController{
    
    //MARK:- Property
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var collectionViews:UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    var layoutTableView = 0
    let listofEventViewModel = ListofEventViewModel()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK:- Helper Function
    func configUI() {
        listofEventViewModel.delegate = self
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(changeTheLayOut(sender: )))
        addTableView()
        swipAction()
    }
    func swipAction(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeft)
    }
    func addCollectionView(){
        collectionViews.register(ListOfEventCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionViews)
        collectionViews.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    func addTableView(){
        tableView.register(ListOfEventsInTheLocationCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    // MARK:- Selection
    @objc func changeTheLayOut(sender:UIBarButtonItem){
        if layoutTableView == 0 {
            DispatchQueue.main.async {
                self.tableView.removeFromSuperview()
                sender.image =  UIImage(systemName: "list.dash")
                self.addCollectionView()
            }
            layoutTableView = 1
        }else{
            DispatchQueue.main.async {
                self.collectionViews.removeFromSuperview()
                sender.image =  UIImage(systemName: "square.grid.2x2")
                self.addTableView()
            }
            layoutTableView = 0
        }
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizer.Direction.right:
                debugPrint("Swiped right")
            case UISwipeGestureRecognizer.Direction.left:
                self.trackingAction()
                default:
                    break
            }
        }
    }
    
    func trackingAction(){
        DispatchQueue.main.async {
            let vc = TrackingEventViewController()
            vc.view.backgroundColor = .white
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:- TableView Delegate and DataSource

extension ListOfEventViewController:UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listofEventViewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListOfEventsInTheLocationCell
        return listofEventViewModel.cellTableView(cell: cell,indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = listofEventViewModel.selectTheIteams(indexs: indexPath.row)
        DispatchQueue.main.async {
            let vc = DetailEventViewController()
            vc.view.backgroundColor = .white
            vc.id = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:- UICollectionView Delegate and DataSource

extension ListOfEventViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listofEventViewModel.numberOfItemsInSection()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ListOfEventCollectionViewCell
        return listofEventViewModel.cellColloctionView(cell: cell, indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = 5
        let width = (collectionView.frame.size.width/2 - CGFloat(padding) * 2) / CGFloat(2)
        let height = 220.0 // or what height you want to do
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = listofEventViewModel.selectTheIteams(indexs: indexPath.row)
        DispatchQueue.main.async {
            let vc = DetailEventViewController()
            vc.view.backgroundColor = .white
            vc.id = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}


extension ListOfEventViewController:ListofEventViewModelDelegate {
    
    func reloadTableViewOrTheCollectionView() {
        DispatchQueue.main.async {
            if self.layoutTableView == 0 {
                self.collectionViews.reloadData()
            }else{
                self.tableView.reloadData()
            }
            
        }
    }
}
