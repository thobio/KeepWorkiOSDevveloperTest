//
//  DetailEventViewController.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 23/03/22.
//

import UIKit
import JCTTool

class DetailEventViewController :UIViewController {
    //MARK:- Property

    let scrollView = UIScrollView()
    let contentView = UIView()
    var id:Event?{
        didSet {
            thumbnailImage.image = UIImage(named: (id?.imageName)!)
            eventNameLabel.text = id?.eventName!
            eventSubTitleLabel.text = id?.loc!
            let imageString = id!.type == true ? "paid" : "free"
            paidOrFree.image = UIImage(named: imageString)
            DetailsViewModel.shared.featchAllTracking(event: id!)
        }
    }
    
    lazy var thumbnailImage:UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "1")
        imgView.backgroundColor = .gray.withAlphaComponent(0.5)
        return imgView
    }()
    
    lazy var eventNameLabel :UILabel = {
       let lbl = UILabel()
        lbl.text = "Party With Aliya"
        lbl.textColor =  .black
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var views:UIView = {
        let vw = UIView()
        vw.backgroundColor = .white
        vw.heightAnchor.constraint(equalToConstant: 600).isActive = true
        return vw
    }()
    
    lazy var eventSubTitleLabel :UILabel = {
       let lbl = UILabel()
        lbl.text = "Party With Aliya"
        lbl.textColor =  .gray
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var paidOrFree:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    lazy var buttonSubmitTheName : UIButton = {
        let btn = UIButton()
        btn.setTitle("Track The Event", for: [])
        btn.setTitleColor(.black, for: [])
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.addTarget(self, action: #selector(trackButtonAction(sender: )), for: .touchUpInside)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth =  0.6
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailsViewModel.shared.delegate = self
        congfigUI()
    }
    // MARK:- Helper Function
    func setupScrollView(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func congfigUI(){
        
        setupScrollView()
        contentView.addSubview(views)
        views.addSubview(thumbnailImage)
        views.addSubview(eventNameLabel)
        views.addSubview(eventSubTitleLabel)
        views.addSubview(paidOrFree)
        views.addSubview(buttonSubmitTheName)
        
        views.anchor(top:contentView.topAnchor,left: contentView.leftAnchor,bottom: contentView.bottomAnchor,right: contentView.rightAnchor,paddingTop: 10,paddingLeft: 20,paddingBottom: 20,paddingRight: 20)
        
        thumbnailImage.centerX(inView: views, topAnchor: views.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        thumbnailImage.anchor(width: (view.frame.width*0.3) + 200,height: (view.frame.width*0.2)+200)
        
        eventNameLabel.centerX(inView: views, topAnchor: thumbnailImage.bottomAnchor, paddingTop: 15)
        eventSubTitleLabel.centerX(inView: views, topAnchor: eventNameLabel.bottomAnchor, paddingTop: 15)
        
        eventNameLabel.anchor(left: views.leftAnchor,right: views.rightAnchor)
        eventSubTitleLabel.anchor(left: views.leftAnchor,right: views.rightAnchor)
        
        paidOrFree.anchor(top:thumbnailImage.topAnchor,right: views.safeAreaLayoutGuide.rightAnchor,paddingRight: 30,width: 100,height: 100)
        
        buttonSubmitTheName.centerX(inView: views, topAnchor: eventSubTitleLabel.bottomAnchor, paddingTop: 30)
        buttonSubmitTheName.anchor(width:(view.frame.width*0.5),height: 60)
        swipAction()
    }
    
    func swipAction(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK:- Selection
    @objc func trackButtonAction(sender:UIButton){
        guard let event = id else{return}
        DetailsViewModel.shared.addTracking(event: event)
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

extension DetailEventViewController : DetailsViewModelDelegate {
    
    func successFullyAddedTODB() {
        buttonSubmitTheName.setTitle("Event Is Tracking", for: [])
        buttonSubmitTheName.isUserInteractionEnabled = false
        buttonSubmitTheName.layer.borderColor = UIColor.gray.cgColor
        buttonSubmitTheName.setTitleColor(UIColor.gray, for: [])
    }
    
    func errorOnTheSave(errorMessage: String) {
        Alerts.showSmapleAlert(on: self, with: "Sorry!", message: errorMessage)
    }
    
    func isTheEventAlreadyTracking() {
        buttonSubmitTheName.setTitle("Event Is Tracking", for: [])
        buttonSubmitTheName.isUserInteractionEnabled = false
        buttonSubmitTheName.layer.borderColor = UIColor.gray.cgColor
        buttonSubmitTheName.setTitleColor(UIColor.gray, for: [])
    }
}
