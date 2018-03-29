//
//  File.swift
//  FindHome
//
//  Created by phungducchinh on 3/27/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIView {
    let imageList : [UIImage]  = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!]
    fileprivate let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    public var setImage : UIImage?{
        didSet{
            imageView.image = setImage
        }
    }
    fileprivate let lblName : UILabel = {
        let lblName = UILabel()
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.text = "Nhà nguyên căn"
        lblName.textAlignment = NSTextAlignment.center
        lblName.font = lblName.font.withSize(16)
        return lblName
    }()
    
    fileprivate let imgPrice : UIImageView = {
        let imgPrice = UIImageView()
        imgPrice.image = #imageLiteral(resourceName: "money")
        imgPrice.translatesAutoresizingMaskIntoConstraints = false
        
        return imgPrice
    }()
    fileprivate let lblPrice : UILabel = {
        let lblPrice = UILabel()
        lblPrice.translatesAutoresizingMaskIntoConstraints = false
        lblPrice.text = "2.500.000"
        lblPrice.font = lblPrice.font.withSize(15)
        lblPrice.sizeToFit()
        return lblPrice
    }()
    fileprivate let imgArea : UIImageView = {
        let imgArea = UIImageView()
        imgArea.image = #imageLiteral(resourceName: "dientich")
        imgArea.translatesAutoresizingMaskIntoConstraints = false
        
        return imgArea
    }()
    fileprivate let lblArea : UILabel = {
        let lblArea = UILabel()
        lblArea.translatesAutoresizingMaskIntoConstraints = false
        lblArea.text = "Nhà nguyên căn"
        lblArea.font = lblArea.font.withSize(15)
        return lblArea
    }()
    fileprivate let imgAddress : UIImageView = {
        let imgAddress = UIImageView()
        imgAddress.image = UIImage(named: "address")!
        imgAddress.translatesAutoresizingMaskIntoConstraints = false
        
        return imgAddress
    }()
    fileprivate let lblAddress : UILabel = {
        let lblAddress = UILabel()
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        lblAddress.text = "97 Man Thiện, P. Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh"
        lblAddress.font = lblAddress.font.withSize(15)
        lblAddress.sizeToFit()
        return lblAddress
    }()
    fileprivate let txtAdd : UITextView = {
        let txtAdd = UITextView()
        txtAdd.translatesAutoresizingMaskIntoConstraints = false
        txtAdd.text = "97 Man Thiện, P. Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh"
        txtAdd.font = txtAdd.font?.withSize(15)
        txtAdd.isUserInteractionEnabled = false //ko hiển thị bàn phím, ko cuộn được
        txtAdd.sizeToFit() //tự điều chỉnh dòng
        return txtAdd
    }()
    
    fileprivate let imgPhone : UIImageView = {
        let imgPhone = UIImageView()
        imgPhone.image = UIImage(named: "phone")!
        imgPhone.translatesAutoresizingMaskIntoConstraints = false
        
        return imgPhone
    }()
    fileprivate let lblPhone : UILabel = {
        let lblPhone = UILabel()
        lblPhone.translatesAutoresizingMaskIntoConstraints = false
        lblPhone.text = "01234456569"
        lblPhone.font = lblPhone.font.withSize(15)
        return lblPhone
    }()
    fileprivate let txtDetail : UITextView = {
        let txtDetail = UITextView()
        txtDetail.translatesAutoresizingMaskIntoConstraints = false
        txtDetail.text = "Căn hộ thuộc chung cư Jamona City đường Đào Trí, quận 7 gồm 2 phòng ngủ, 2 toilet, bếp, phòng khách, nhà trống, nội thất cơ bản như hình, có khu phơi quần áo, ban công thoáng mát. Di chuyển qua quận 1, 8, ,4, 2, bình chánh, nhà bè rất gần, gần siêu thị, chợ, trường học và bệnh viện quận 7, gần trung tâm phú mỹ hưng. Thích hợp cho gia đình ở thuê lâu dài. Tiếp người thiện chí"
        txtDetail.font = txtDetail.font?.withSize(15)
        txtDetail.isEditable = false //ko hiển thị bàn phím, cuộn được
        txtDetail.sizeToFit() //tự điều chỉnh dòng
        return txtDetail
    }()
    var dem = 0
    fileprivate let btnNext : UIButton = {
        let btnNext = UIButton()
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.setImage(#imageLiteral(resourceName: "next"), for: .normal)
        btnNext.addTarget(self, action: #selector(nextImage), for: .touchUpInside)

        return btnNext
    }()
    fileprivate let btnBack : UIButton = {
        let btnBack = UIButton()
        btnBack.translatesAutoresizingMaskIntoConstraints = false
        btnBack.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        btnBack.addTarget(self, action: #selector(backImage), for: .touchUpInside)
        return btnBack
    }()
    
    
    func backImage(){
        print("back")
        if (self.dem == 0) {
            dem = imageList.count-1
            setImage = imageList[dem]
        }
        else
        {
            dem -= 1
            setImage = imageList[dem]
        }
    }
    func nextImage(){
        print("next")
        if (dem == self.imageList.count-1) {
            dem = 0
            setImage = imageList[dem]
        }
        else
        {
            dem += 1
            setImage = imageList[dem]
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.backgroundColor = UIColor(red: 238/255.0, green: 231/255.0, blue: 231/255.0, alpha: 1.0)
        self.backgroundColor = .white
        self.addSubview(self.imageView)
        self.addSubview(self.lblName)
        self.addSubview(self.imgPrice)
        self.addSubview(self.lblPrice)
        self.addSubview(self.imgArea)
        self.addSubview(self.lblArea)
        self.addSubview(self.imgAddress)
        //        self.addSubview(self.lblAddress)
        self.addSubview(self.txtAdd)
        self.addSubview(self.imgPhone)
        self.addSubview(self.lblPhone)
        self.addSubview(self.txtDetail)
        self.addSubview(self.btnNext)
        self.addSubview(self.btnBack)
        let View = ["img" : self.imageView, "lblName" : self.lblName, "imgPrice" : self.imgPrice, "lblPrice" : self.lblPrice, "imgArea" : self.imgArea, "lblArea":self.lblArea,"imgAdd":self.imgAddress, "lblAdd":self.txtAdd, "imgPhone":self.imgPhone, "lblPhone" : self.lblPhone, "detail" : self.txtDetail, "next" : self.btnNext, "back" : self.btnBack] as [String : Any]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[img]-15-|", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblName]-15-|", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgPrice(20)]-3-[lblPrice]-50-[imgArea(20)]-3-[lblArea]-15-|", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgAdd(20)]-3-[lblAdd]-15-|", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgPhone(20)]-3-[lblPhone]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[detail]-15-|", options: [], metrics: nil, views: View))
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[imgPrice(20)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblPrice]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[imgArea(20)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[imgAdd(20)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd(40)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[imgPhone(20)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[lblPhone]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[lblPhone]-10-[detail(100)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-145-[next(70)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[back(50)]", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[next(50)]-0-|", options: [], metrics: nil, views: View))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-145-[back(70)]", options: [], metrics: nil, views: View))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

