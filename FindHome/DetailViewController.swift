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
    
    var dataD = PostData(imageList: [UIImage(named: "imageListDt")!], info: PostInfo(title: "sdfs", price: "sdfsdf", area: "sdfsf", address: "sdfsdf", phone: "sdfsdf"), more: "sdfsdf")
    //    let detail = DetailView()
//    let imageList : [UIImage]  = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!]
    
    var imageListDt : [UIImage] = []
    
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
    public let lblName : UILabel = {
        let lblName = UILabel()
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblName.text = ""
        lblName.textAlignment = NSTextAlignment.center
        lblName.font = lblName.font.withSize(16)
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
    public let lblAddress : UILabel = {/// khong su dug
        let lblAddress = UILabel()
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        lblAddress.text = "97 Man Thiện, P. Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh"
        lblAddress.font = lblAddress.font.withSize(15)
        lblAddress.sizeToFit()
        return lblAddress
    }()
    
    public var setAddress : String?{
        didSet{
            lblAddress.text = setAddress
        }
    }
    
    public let txtAdd : UITextView = {
        let txtAdd = UITextView()
        txtAdd.translatesAutoresizingMaskIntoConstraints = false
        txtAdd.text = "97 Man Thiện, P. Hiệp Phú, Quận 9, Thành phố Hồ Chí Minh"
        txtAdd.font = txtAdd.font?.withSize(15)
        txtAdd.isUserInteractionEnabled = false //ko hiển thị bàn phím, ko cuộn được
        txtAdd.sizeToFit() //tự điều chỉnh dòng
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
        lblPhone.font = lblPhone.font.withSize(15)
        return lblPhone
    }()
    
    public var setPhone : String?{
        didSet{
            lblPhone.text = setPhone
        }
    }
    
    public let txtDetail : UITextView = {
        let txtDetail = UITextView()
        txtDetail.translatesAutoresizingMaskIntoConstraints = false
        txtDetail.text = "Căn hộ thuộc chung cư Jamona City đường Đào Trí, quận 7 gồm 2 phòng ngủ, 2 toilet, bếp, phòng khách, nhà trống, nội thất cơ bản như hình, có khu phơi quần áo, ban công thoáng mát. Di chuyển qua quận 1, 8, ,4, 2, bình chánh, nhà bè rất gần, gần siêu thị, chợ, trường học và bệnh viện quận 7, gần trung tâm phú mỹ hưng. Thích hợp cho gia đình ở thuê lâu dài. Tiếp người thiện chí"
        txtDetail.font = txtDetail.font?.withSize(15)
        txtDetail.isEditable = false //ko hiển thị bàn phím, cuộn được
        txtDetail.sizeToFit() //tự điều chỉnh dòng
        return txtDetail
    }()
    
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
        for var i in (0..<dataD.imageList.count) {
            imageListDt.append(dataD.imageList[i])
        }
    }
    
    
    func backImage()
    {
        loadImage()
        imageListDt = dataD.imageList
        print("back")
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
        imageListDt = dataD.imageList
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
        lblName.text = dataD.info.title
        lblArea.text = dataD.info.area
        lblPrice.text = dataD.info.price
        lblPhone.text = dataD.info.phone
        txtAdd.text = dataD.info.address
        txtDetail.text = dataD.more
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
        //        self.addSubview(self.lblAddress)
        self.view.addSubview(self.txtAdd)
        self.view.addSubview(self.imgPhone)
        self.view.addSubview(self.lblPhone)
        self.view.addSubview(self.txtDetail)
        self.view.addSubview(self.btnNext)
        self.view.addSubview(self.btnBack)
        
        loadInfo()// load data truyen tu view PostController
        
        let View = ["img" : self.imageView, "lblName" : self.lblName, "imgPrice" : self.imgPrice, "lblPrice" : self.lblPrice, "imgArea" : self.imgArea, "lblArea":self.lblArea,"imgAdd":self.imgAddress, "lblAdd":self.txtAdd, "imgPhone":self.imgPhone, "lblPhone" : self.lblPhone, "detail" : self.txtDetail, "next" : self.btnNext, "back" : self.btnBack] as [String : Any]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[img]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblName]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgPrice(20)]-3-[lblPrice]-50-[imgArea(20)]-3-[lblArea]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgAdd(20)]-3-[lblAdd]-15-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[imgPhone(20)]-3-[lblPhone]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[detail]-15-|", options: [], metrics: nil, views: View))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[imgPrice(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblPrice]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[imgArea(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[imgAdd(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd(40)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[imgPhone(20)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[lblPhone]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[img(200)]-3-[lblName]-[lblArea]-[lblAdd]-[lblPhone]-10-[detail(100)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-145-[next(70)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[back(50)]", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[next(50)]-0-|", options: [], metrics: nil, views: View))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-145-[back(70)]", options: [], metrics: nil, views: View))
        
        //        self.view = self.detail
        //        navigationItem.title = "Thông tin chi tiết"
    }
    //}
    
    //    func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //}
}
