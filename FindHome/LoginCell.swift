//
//  LoginCell.swift
//  FindHome
//
//  Created by phungducchinh on 3/13/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class LoginCell: UITableViewCell{
    
    public var txftext = ""
    
    fileprivate let img : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    public let txf : UITextField = {
        let txf = UITextField()
        txf.translatesAutoresizingMaskIntoConstraints = false
        txf.font = txf.font?.withSize(15)
        txf.text = ""
        return txf
    }()
    
    public var imaname : UIImage?{
        didSet{
            img.image = imaname
        }
    }
    
    public var txfname : String?{
        didSet{
            txf.placeholder = txfname
        }
    }
    
    
    public var txfuser : String?{
        didSet{
            txfuser = txf.text!
        }
    }
    
    public func  getText() {
        txftext = txf.text!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        getText()
        contentView.addSubview(img)
        contentView.addSubview(txf)
        contentView.layer.cornerRadius = 7
        
        let View = ["img" : self.img, "txf" : self.txf] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[img(25)]-7-[txf]-0-|", options: [], metrics: nil, views: View))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[img(25)]", options: [], metrics: nil, views: View))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[txf]", options: [], metrics: nil, views: View))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
