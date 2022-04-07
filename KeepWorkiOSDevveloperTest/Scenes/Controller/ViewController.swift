//
//  ViewController.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 22/03/22.
//

import UIKit
import JCTTool

class ViewController: UIViewController,HomePageViewModelDelegate {
    //MARK:- Property
    lazy var  nameTextField : UITextField = {
       let txt = UITextField()
       txt.placeholder = "Enter your name."
       txt.font = UIFont.systemFont(ofSize: 30)
       return txt
    }()
    
    lazy var viewNameTextField:UIView = {
       let view = UIView()
       view.heightAnchor.constraint(equalToConstant: 65).isActive = true
       view.addSubview(self.nameTextField)
       self.nameTextField.anchor(top:view.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingTop: 10,paddingLeft: 15,paddingBottom: 10,paddingRight: 15)
       view.layer.borderWidth = 0.5
       view.layer.borderColor = UIColor.gray.cgColor
       view.layer.cornerRadius = 15
       return view
    }()
    
    lazy var buttonSubmitTheName : UIButton = {
        let btn = UIButton()
        btn.setTitle("Submit", for: [])
        btn.setTitleColor(.black, for: [])
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.addTarget(self, action: #selector(actionOnSubmitingName), for: .touchUpInside)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth =  0.6
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK:- Helper Function
    
    func configUI(){
        view.backgroundColor = .white
        
        // adding TextField to the View
        view.addSubview(viewNameTextField)
        viewNameTextField.center(inView: self.view)
        viewNameTextField.anchor(width: (view.frame.width/2))
        
        // Adding Button to the View
        view.addSubview(buttonSubmitTheName)
        buttonSubmitTheName.centerX(inView: view, topAnchor: viewNameTextField.bottomAnchor, paddingTop: 30)
        buttonSubmitTheName.setDimensions(width: view.frame.width/2, height: 55)
    }
    
    // MARK:- Selection
    
    @objc func actionOnSubmitingName(){
        guard let userName = self.nameTextField.text else{return}
        if userName.isEmpty{
            //TODO :- AlertBox
        }else{
            HomePageViewModel.shared.delegate = self
            HomePageViewModel.shared.featchUserName(userName: userName)
        }
    }
    
    func callBackWithSuccess() {
        let vc = ListOfEventViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

