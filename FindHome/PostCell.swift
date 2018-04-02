//
//  PostCell.swift
//  PhongTroOnline
//
//  Created by TaNhi on 3/13/18.
//  Copyright © 2018 TaNhi. All rights reserved.
// edit by ducchinh

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    fileprivate let lblInfo : UILabel = {
        let lblInfo = UILabel()
        lblInfo.textColor = .black
        //lblInfo.text = "abc"
        lblInfo.translatesAutoresizingMaskIntoConstraints = false
        lblInfo.font = lblInfo.font.withSize(15)
        return lblInfo
    }()
    
    public var name : String?{
        didSet{
            lblInfo.text = name
        }
    }
    
    fileprivate let txfInfo : UITextField = {
        let txfInfo = UITextField()
        txfInfo.translatesAutoresizingMaskIntoConstraints = false
        txfInfo.font = txfInfo.font?.withSize(15)
        return txfInfo
    }()
    
    public var hiden : String?{
        didSet{
            txfInfo.placeholder = hiden
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblInfo)
        contentView.addSubview(txfInfo)
        
        contentView.backgroundColor = .white
        
        let View = ["lblinfo" : self.lblInfo, "txfinfo" : self.txfInfo] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[lblinfo]-0-|", options: [], metrics: nil, views: View))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[txfinfo]-0-|", options: [], metrics: nil, views: View))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[lblinfo(80)]-10-[txfinfo]-10-|", options: [], metrics: nil, views: View))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
