//
//  ListOfEventsInTheLocationCell.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 23/03/22.
//

import UIKit

class ListOfEventsInTheLocationCell : UITableViewCell {
    
    //MARK:- Property
    lazy var thumbnailImage:UIImageView = {
        let imgView = UIImageView()
        imgView.setDimensions(width: 100, height: 100)
        imgView.image = UIImage(named: "img")
        return imgView
    }()
    
    lazy var paidOrFree:UIImageView = {
        let imgView = UIImageView()
        imgView.setDimensions(width: 60, height: 60)
        imgView.image = UIImage(named: "1")
        return imgView
    }()
    
    lazy var eventNameLabel :UILabel = {
       let lbl = UILabel()
        lbl.text = "Party With Aliya"
        lbl.textColor =  .black
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        return lbl
    }()
    
    
    lazy var eventSubTitleLabel :UILabel = {
       let lbl = UILabel()
        lbl.text = "Party With Aliya"
        lbl.textColor =  .gray
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    // MARK:- LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Helper Function
    func configUI() {
        
        addSubview(thumbnailImage)
        addSubview(eventNameLabel)
        addSubview(eventSubTitleLabel)
        addSubview(paidOrFree)
        
        thumbnailImage.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 20, constant: 0)
        eventNameLabel.centerY(inView: self, leftAnchor: thumbnailImage.rightAnchor, paddingLeft: 20, constant: -20)
        eventSubTitleLabel.centerY(inView: self, leftAnchor: thumbnailImage.rightAnchor, paddingLeft: 20, constant: 10)
        
        eventNameLabel.anchor(right:paidOrFree.leftAnchor,paddingRight: 10)
        eventSubTitleLabel.anchor(right:paidOrFree.leftAnchor,paddingRight: 10)
        paidOrFree.anchor(right:rightAnchor,paddingRight: 10)
        paidOrFree.centerY(inView: self)
        
    }
    
}
