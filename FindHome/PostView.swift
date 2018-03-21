//
//  PostView.swift
//  PhongTroOnline
//
//  Created by TaNhi on 3/13/18.
//  Copyright © 2018 TaNhi. All rights reserved.
//

import Foundation
import UIKit

class PostView: UIView {
    
    fileprivate let lblAddImg : UILabel = {
        let lblAddImg = UILabel()
        lblAddImg.text = "Thêm hình ảnh:"
        lblAddImg.textColor = .black
        lblAddImg.translatesAutoresizingMaskIntoConstraints = false
        lblAddImg.font = lblAddImg.font.withSize(15)
        return lblAddImg
    }()
    
    fileprivate let imgADd : UIImageView = {
        let imgADd = UIImageView()
        imgADd.image = #imageLiteral(resourceName: "imgAdd")
        imgADd.translatesAutoresizingMaskIntoConstraints = false
        return imgADd
    }()
    
    fileprivate let lblInfo : UILabel = {
        let lblInfo = UILabel()
        lblInfo.text = "Thông tin cơ bản:"
        lblInfo.translatesAutoresizingMaskIntoConstraints = false
        lblInfo.font = lblInfo.font.withSize(15)
        return lblInfo
    }()
    
    fileprivate let tbvPost : PostTableView = {
        let tbvPost = PostTableView()
        tbvPost.translatesAutoresizingMaskIntoConstraints = false
        return tbvPost
    }()
    
    fileprivate let lblMore : UILabel = {
        let lblMore = UILabel()
        lblMore.text = "Mô tả thêm:"
        lblMore.translatesAutoresizingMaskIntoConstraints = false
        lblMore.font = lblMore.font.withSize(15)
        return lblMore
    }()
    
    fileprivate let txfMore : UITextField = {
        let txfMore = UITextField()
        txfMore.translatesAutoresizingMaskIntoConstraints = false
        txfMore.backgroundColor = .white
        return txfMore
    }()
    
    fileprivate let btnADd : UIButton = {
        let btnADd = UIButton()
        btnADd.setTitle("Đăng tin", for: .normal)
        btnADd.backgroundColor = UIColor(red: 1/255.0, green: 143/255.0, blue: 255/255.0, alpha: 1.0)
        //btnADd.backgroundColor = .blue
        btnADd.setTitleColor(.white , for: .normal)
        btnADd.translatesAutoresizingMaskIntoConstraints = false
        return btnADd
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = .white
    
        self.backgroundColor = UIColor(red: 238/255.0, green: 231/255.0, blue: 231/255.0, alpha: 1.0)
        self.addSubview(lblInfo)
        self.addSubview(lblAddImg)
        self.addSubview(imgADd)
        self.addSubview(tbvPost)
        self.addSubview(lblMore)
        self.addSubview(txfMore)
        self.addSubview(btnADd)
        
        let View = ["lblinfo" : self.lblInfo, "lblAdd" : self.lblAddImg, "imgADd" : self.imgADd, "tbv" : self.tbvPost, "lblMore" : self.lblMore, "txfMore": self.txfMore, "btnAdd" : self.btnADd] as [String : Any]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[lblAdd(30)]-3-[imgADd(90)]-7-[lblinfo(30)]-5-[tbv(125)]-5-[lblMore(30)]-5-[txfMore(60)]-30-[btnAdd(40)]", options: [], metrics: nil, views: View))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblinfo]-15-|", options: [], metrics: nil, views: View))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblAdd]-15-|", options: [], metrics: nil, views: View))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-110-[imgADd(90)]", options: [], metrics: nil, views: View))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[tbv]-15-|", options: [], metrics: nil, views: View))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblMore]-15-|", options: [], metrics: nil, views: View))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[txfMore]-15-|", options: [], metrics: nil, views: View))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[btnAdd]-15-|", options: [], metrics: nil, views: View))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
