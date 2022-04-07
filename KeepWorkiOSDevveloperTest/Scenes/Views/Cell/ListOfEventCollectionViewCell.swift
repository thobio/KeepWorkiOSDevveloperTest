//
//  ListOfEventCollectionViewCell.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 23/03/22.
//

import UIKit

class ListOfEventCollectionViewCell :UICollectionViewCell {
    
    //MARK:- Property
    lazy var thumbnailImage:UIImageView = {
        let imgView = UIImageView()
        imgView.setDimensions(width: 100, height: 100)
        imgView.image = UIImage(named: "img")
        return imgView
    }()
    
    lazy var eventNameLabel :UILabel = {
       let lbl = UILabel()
        lbl.text = "Party With Aliya"
        lbl.textColor =  .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        
        addSubview(thumbnailImage)
        addSubview(eventNameLabel)
        
        thumbnailImage.centerX(inView: self, topAnchor: self.topAnchor, paddingTop: 10)
        eventNameLabel.centerX(inView: self, topAnchor: thumbnailImage.bottomAnchor, paddingTop: 10)
        eventNameLabel.anchor(left:self.leftAnchor,bottom: self.bottomAnchor,right: self.rightAnchor,paddingLeft: 10,paddingBottom: 10,paddingRight: 10)
    }
}
