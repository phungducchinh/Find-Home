//
//  HistoryCell.swift
//  FindHome
//
//  Created by phungducchinh on 1/24/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class HistoryCell: UITableViewCell {
    
    fileprivate let imgHome : UIImageView = {
        let imgHome   =  UIImageView()
        imgHome.translatesAutoresizingMaskIntoConstraints = false
        return imgHome
    }()
    
    fileprivate let lblAddress : UILabel = {
        let lblAddress = UILabel()
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        lblAddress.font = lblAddress.font.withSize(13)
        //lblAddress.font = UIFont.boldSystemFont(ofSize: 15)
        lblAddress.textColor = .black
        lblAddress.sizeToFit()
        return lblAddress
    }()
    
    
    fileprivate let imgMoney : UIImageView = {
        let imgMoney   =  UIImageView()
        imgMoney.translatesAutoresizingMaskIntoConstraints = false
        imgMoney.image = UIImage(named: "money")
        return imgMoney
    }()
    
    fileprivate let lblMoney : UILabel = {
        let lblMoney = UILabel()
        lblMoney.translatesAutoresizingMaskIntoConstraints = false
        lblMoney.font = lblMoney.font.withSize(13)
        lblMoney.textColor = .black
        // lblMoney.textAlignment = NSTextAlignment.center
        return lblMoney
    }()
    
    fileprivate let imgAcreage : UIImageView = {
        let imgAcreage   =  UIImageView()
        imgAcreage.translatesAutoresizingMaskIntoConstraints = false
        imgAcreage.image = UIImage(named: "dientich")
        return imgAcreage
    }()
    
    fileprivate let lblAcreage: UILabel = {
        let lblAcreage = UILabel()
        lblAcreage.translatesAutoresizingMaskIntoConstraints = false
        lblAcreage.font = lblAcreage.font.withSize(13)
        lblAcreage.textColor = .black
        //lblAcreage.textAlignment = NSTextAlignment.center
        return lblAcreage
    }()
    
    fileprivate let lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        // lblTitle.font = lblTitle.font.withSize(13)
        lblTitle.textColor = .black
        lblTitle.font = UIFont.boldSystemFont(ofSize: 13)
        // lblTitle.textAlignment = NSTextAlignment.center
        return lblTitle
    }()
    
    public var address : String?{
        didSet{
            lblAddress.text = address
        }
    }
    public var title : String?{
        didSet{
            lblTitle.text = title
        }
    }
    
    public var money : String?{
        didSet{
            lblMoney.text = money
        }
    }
    
    public var acreage : String?{
        didSet{
            lblAcreage.text = acreage
        }
    }
    
    public var img : UIImage?{
        didSet{
            imgHome.image = img
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgHome)
        contentView.addSubview(lblAddress)
        contentView.addSubview(imgMoney)
        contentView.addSubview(lblMoney)
        contentView.addSubview(imgAcreage)
        contentView.addSubview(lblAcreage)
        contentView.addSubview(lblTitle)
        
        
        let views = ["img": self.imgHome, "lblAddress" : self.lblAddress , "imgtien" : self.imgMoney, "lblMoney" : self.lblMoney, "imgAcreage" : self.imgAcreage , "lblAcreage" : self.lblAcreage , "lbltitle" : self.lblTitle] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[img(80)]", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[lbltitle(20)]-5-[lblMoney(15)]-5-[lblAcreage(15)]-5-[lblAddress]", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lbltitle]-3-[imgtien(17)]-3-[imgAcreage(20)]", options: [], metrics: nil, views: views))
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[img(80)]-5-[lbltitle]-5-|", options: [], metrics: nil, views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[img]-7-[imgtien(17)]-5-[lblMoney]-5-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[img]-5-[imgAcreage(20)]-5-[lblAcreage]-5-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[img(80)]-5-[lblAddress]-5-|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

