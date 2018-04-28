//detail
//
//  DetailViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/27/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var co = "" // nhan gia tri co tu bien Post (0 )hoac List(1) hoac History(2)
    var imageListDt : [UIImage] = []
    var infoDetail = NSDictionary()
    
    var img : [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!]
    
    fileprivate var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholderimg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public var setImage : UIImage?{
        didSet{
            imageView.image = setImage
        }
    }
    public let lblName : UILabel = {
        let lblName = UILabel()
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.text = ""
        lblName.textAlignment = NSTextAlignment.center
        lblName.font = UIFont.boldSystemFont(ofSize: 16)
        return lblName
    }()
    
    public var setTitle : String?{
        didSet{
            lblName.text = setTitle
        }
    }
    
    fileprivate let imgPrice : UIImageView = {
        let imgPrice = UIImageView()
        imgPrice.image = #imageLiteral(resourceName: "money")
        imgPrice.translatesAutoresizingMaskIntoConstraints = false
        
        return imgPrice
    }()
    public let lblPrice : UILabel = {
        let lblPrice = UILabel()
        lblPrice.translatesAutoresizingMaskIntoConstraints = false
        lblPrice.text = "2.500.000"
        lblPrice.font = lblPrice.font.withSize(15)
        lblPrice.sizeToFit()
        return lblPrice
    }()
    
    public var setPrice : String?{
        didSet{
            lblPrice.text = setPrice
        }
    }
    
    fileprivate let imgArea : UIImageView = {
        let imgArea = UIImageView()
        imgArea.image = #imageLiteral(resourceName: "dientich")
        imgArea.translatesAutoresizingMaskIntoConstraints = false
        
        return imgArea
    }()
    public let lblArea : UILabel = {
        let lblArea = UILabel()
        lblArea.translatesAutoresizingMaskIntoConstraints = false
        lblArea.text = "Nhà nguyên căn"
        lblArea.font = lblArea.font.withSize(15)
        return lblArea
    }()
    
    public var setArea : String?{
        didSet{
            lblArea.text = setArea
        }
    }
    
    fileprivate let imgAddress : UIImageView = {
        let imgAddress = UIImageView()
        imgAddress.image = UIImage(named: "address")!
        imgAddress.translatesAutoresizingMaskIntoConstraints = false
        
        return imgAddress
    }()
    public let txtDetail : UITextView = {
        let txtDetail = UITextView()
        txtDetail.translatesAutoresizingMaskIntoConstraints = false
        txtDetail.text = ""
        txtDetail.isEditable = false //ko hiển thị bàn phím, cuộn được
        txtDetail.sizeToFit() //tự điều chỉnh dòng
        txtDetail.font = .systemFont(ofSize: 15)
        return txtDetail
    }()
    
    public let txtAdd : UITextView = {
        let txtAdd = UITextView()
        txtAdd.translatesAutoresizingMaskIntoConstraints = false
        txtAdd.text = ""
        txtAdd.textContainer.maximumNumberOfLines = 2
        txtAdd.font = .systemFont(ofSize: 15)
        txtAdd.sizeToFit() //tự điều chỉnh dòng
        txtAdd.isEditable = false
        txtAdd.isScrollEnabled = true
        return txtAdd
    }()
    
    public var setAdd : String?{
        didSet{
            txtAdd.text = setAdd
        }
    }
    
    fileprivate let imgPhone : UIImageView = {
        let imgPhone = UIImageView()
        imgPhone.image = UIImage(named: "phone")!
        imgPhone.translatesAutoresizingMaskIntoConstraints = false
        
        return imgPhone
    }()
    public let lblPhone : UILabel = {
        let lblPhone = UILabel()
        lblPhone.translatesAutoresizingMaskIntoConstraints = false
        lblPhone.text = "01234456569"
        //lblPhone.font = lblPhone.font.withSize(15)
        lblPhone.font = UIFont.italicSystemFont(ofSize: 15)
        lblPhone.textColor = UIColor(red: 1/255.0, green: 143/255.0, blue: 255/255.0, alpha: 1.0)
        return lblPhone
    }()
    
    public let lblMet : UILabel = {
        let lblMet = UILabel()
        lblMet.translatesAutoresizingMaskIntoConstraints = false
        lblMet.text = "m2"
        lblMet.font = lblMet.font.withSize(15)
        return lblMet
    }()
    public var setPhone : String?{
        didSet{
            lblPhone.text = setPhone
        }
    }
    
    
    public var setDetail : String?{
        didSet{
            txtDetail.text = setDetail
        }
    }
    
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
    
    func loadImage(){
        if co == "0"
        {
            self.imageListDt = PostData.imageList
        }
        else {
            self.imageListDt = self.img
        }
    }
    
    
    func backImage()
    {
        loadImage()
        if (self.dem == 0) {
            dem = imageListDt.count-1
            setImage = imageListDt[dem]
        }
        else
        {
            dem -= 1
            setImage = imageListDt[dem]
        }
    }
    func nextImage()
    {
        loadImage()
        // imageListDt = dataD.imageList
        print("next")
        if (dem == self.imageListDt.count-1) {
            dem = 0
            setImage = imageListDt[dem]
        }
        else
        {
            dem += 1
            setImage = imageListDt[dem]
        }
    }
    
    func loadInfo(){
        if (co == "0"){
            lblName.text = PostData.title
            let number = PostData.area
            lblArea.text = String(describing: number)
            lblPrice.text = PostData.price
            lblPhone.text = PostData.phone
            txtAdd.text = PostData.address
            txtDetail.text = PostData.more
            imageListDt = PostData.imageList
            print("Chuyen tu view Post sang view Detail")
        }
        else if co == "1"
        {
            lblName.text = self.infoDetail["title"] as? String
            let number = self.infoDetail["acreage"] as! CFNumber
            print(number)
            lblArea.text = String(describing: number)
            lblPrice.text = self.infoDetail["price"] as? String
            lblPhone.text = self.infoDetail["phone"] as? String
            txtAdd.text = self.infoDetail["address"] as! String
            let descrip = String(describing: self.infoDetail["description"]!)
            if descrip == "<null>"{
                txtDetail.text = "Không có mô tả thêm"
            }else{
                txtDetail.text = descrip
            }
            print("Chuyen tu view List sang view Detail")
        }
        else if co == "2"
        {
            lblName.text = self.infoDetail["title"] as? String
            let number = self.infoDetail["acreage"] as! CFNumber
            lblArea.text = String(describing: number)
            lblPrice.text = self.infoDetail["price"] as? String
            lblPhone.text = self.infoDetail["phone"] as? String
            txtAdd.text = self.infoDetail["address"] as! String
            let descrip = String(describing: self.infoDetail["description"]!)
            if descrip == "<null>"{
                txtDetail.text = "Không có mô tả thêm"
            }else{
                txtDetail.text = descrip
            }
            print("Chuyen tu view List sang view Detail")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.lblName)
        self.view.addSubview(self.imgPrice)
        self.view.addSubview(self.lblPrice)
        self.view.addSubview(self.imgArea)
        self.view.addSubview(self.lblArea)
        self.view.addSubview(self.imgAddress)
        self.view.addSubview(self.txtAdd)
        self.view.addSubview(self.imgPhone)
        self.view.addSubview(self.lblPhone)
        self.view.addSubview(self.txtDetail)
        self.view.addSubview(self.btnNext)
        self.view.addSubview(self.btnBack)
        self.view.addSubview(self.lblMet)
        loadInfo()// load data truyen tu view PostController
        
        let View = ["img" : self.imageView, "lblName" : self.lblName, "imgPrice" : self.imgPrice, "lblPrice" : self.lblPrice, "imgArea" : self.imgArea, "lblArea":self.lblArea,"imgAdd":self.imgAddress, "lblAdd":self.txtAdd, "imgPhone":self.imgPhone, "lblPhone" : self.lblPhone, "detail" : self.txtDetail, "next" : self.btnNext, "back" : self.btnBack, "m2" : self.lblMet] as [String : Any]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[img]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblName]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgPrice(20)]-3-[lblPrice]-30-[imgArea(20)]-3-[lblArea]-13-[m2]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgAdd(20)]-3-[lblAdd]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgPhone(20)]-3-[lblPhone]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[detail]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[imgPrice(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblPrice]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[imgArea(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[m2(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-15-[imgAdd(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd(40)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[imgPhone(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[lblPhone]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[lblPhone]-10-[detail]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-145-[next(70)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[back(50)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[next(50)]-0-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-145-[back(70)]", options: [], metrics: nil, views: View))
        self.navigationItem.title = "Thông tin chi tiết"
        self.navigationController?.navigationBar.backItem?.hidesBackButton = false
        self.navigationController?.navigationBar.backItem?.title = "Back"
        
        if self.co == "0" && self.imageListDt.count == 0{
                btnBack.isEnabled = false
                btnNext.isEnabled = false
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapFunction))
        lblPhone.isUserInteractionEnabled = true
        lblPhone.addGestureRecognizer(tap)
        
    }
    
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap call")
        let number = self.infoDetail["phone"] as? String
        let call = ("tel://" + number!)
        print(call)
        let url: NSURL = NSURL(string: call )!
        UIApplication.shared.open(url as URL)
        
    }
    
}

extension UILabel{
    
    func underLine(){
        if let textUnwrapped = self.text{
            let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
            let underlineAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute)
            self.attributedText = underlineAttributedString
        }
    }
}
