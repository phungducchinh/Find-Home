//
//  PostViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var apitoken = ""
    
    let td = ["Tiêu đề:","Giá phòng:","Diện tích:","Điện thoại:","Địa chỉ:"]
    let placehoder = ["Cho thuê nhà nguyên căn", "1.500.000 đ", "12 mét vuông", "01234567899", "Lã Xuân Oai, Quận 9"]
    
    var imageList = [UIImage]()
    var data = PostData(imageList: [UIImage(named: "1")!], info: PostInfo(title: "abc", price: "avc", area: "acc", address: "aa", phone: "sfe"), more: "asda")
    var info = PostInfo(title: "sasdas", price: "asdad", area: "asda", address: "asda", phone: "asdd")
    
    //let postView = PostView()
    fileprivate let lblAddImg : UILabel = {
        let lblAddImg = UILabel()
        lblAddImg.text = "Thêm hình ảnh:"
        lblAddImg.textColor = .black
        lblAddImg.translatesAutoresizingMaskIntoConstraints = false
        lblAddImg.font = lblAddImg.font.withSize(15)
        return lblAddImg
    }()
    
    fileprivate let imgADd : UIButton = {
        let imgADd = UIButton()
        imgADd.setImage(#imageLiteral(resourceName: "postimg"), for: .normal)
        imgADd.translatesAutoresizingMaskIntoConstraints = false
        imgADd.addTarget(self, action: #selector(showAlert) , for: .touchUpInside)
        return imgADd
    }()
    
    
    func showAlert(){
        print("Button tapped")
        let alertController = UIAlertController(title: "Thông báo", message: "ABC", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Chụp ảnh", style: .default, handler: { (action) -> Void in
            
            print("Chụp ảnh")
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = false
            self.present(picker, animated: true)
            {
                
            }
            
            
        })
        let  libraryAction = UIAlertAction(title: "Thư viện ảnh", style: .default) { (action) -> Void in
            
            print("Thư viện ảnh")
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            self.present(picker, animated: true)
            {
                
            }
            
        }
        
        let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: { (action) -> Void in
            
            print("Huỷ")
            
        })
        
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    
    }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
           imageList.append(image)
            if(imageList.count == 1)
            {
                self.image1.image = image
            }
            else if(imageList.count == 2)
            {
                self.image2.image = image
            }
            else if(imageList.count == 3)
            {
                self.image3.image = image
            }
        }
        else
        {
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButt(sender: AnyObject) {
        let imageData = UIImageJPEGRepresentation(image1.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Wow", message: "Your image has been saved to Photo Library!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            print("Huỷ")
            
        })
        alert.addAction(ok)
        alert.present(self, animated: true, completion: nil)
    }
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
        tbvPost.layer.cornerRadius = 7
        tbvPost.isScrollEnabled = false
        tbvPost.contentInset = UIEdgeInsets.zero
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
        txfMore.layer.cornerRadius = 7
        return txfMore
    }()
    
    fileprivate let btnADd : UIButton = {
        let btnADd = UIButton()
        btnADd.setTitle("Đăng tin", for: .normal)
        btnADd.backgroundColor = UIColor(red: 1/255.0, green: 143/255.0, blue: 255/255.0, alpha: 1.0)
        //btnADd.backgroundColor = .blue
        btnADd.setTitleColor(.white , for: .normal)
        btnADd.translatesAutoresizingMaskIntoConstraints = false
        btnADd.layer.cornerRadius = 7
        return btnADd
    }()
    
    func actionPost()
    {
        tbvPost.reloadData()
        //let cell = tbvPost.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
        let destination = DetailViewController() // Your destination
        data.imageList = imageList
        data.info = info
        data.more = txfMore.text!
        destination.dataD = data
        self.navigationController?.pushViewController(destination, animated: true)
        print(info.price)
    }
    
    func loadInfo(){
        
    }
    
    fileprivate let image1 : UIImageView = {
        var image1 = UIImageView()
        image1.image = UIImage(named: "placeholderimg")
        image1.translatesAutoresizingMaskIntoConstraints = false
        return image1
    }()
    fileprivate let image2 : UIImageView = {
        var image2 = UIImageView()
        image2.image = UIImage(named: "placeholderimg")
        image2.translatesAutoresizingMaskIntoConstraints = false
        return image2
    }()
    fileprivate let image3 : UIImageView = {
        var image3 = UIImageView()
        image3.image = UIImage(named: "placeholderimg")
        image3.translatesAutoresizingMaskIntoConstraints = false
        return image3
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 238/255.0, green: 231/255.0, blue: 231/255.0, alpha: 1.0)
        view.addSubview(lblInfo)
        view.addSubview(lblAddImg)
        view.addSubview(imgADd)
        view.addSubview(tbvPost)
        view.addSubview(lblMore)
        view.addSubview(txfMore)
        view.addSubview(btnADd)
        view.addSubview(image1)
        view.addSubview(image2)
        view.addSubview(image3)
        
        print(apitoken)
        
        tbvPost.delegate = self
        tbvPost.dataSource = self
        tbvPost.reloadData()
        tbvPost.register(PostCell.self, forCellReuseIdentifier: "Cell")
        
        btnADd.addTarget(self , action: #selector(actionPost), for: .touchUpInside)


        let View = ["lblinfo" : self.lblInfo, "lblAdd" : self.lblAddImg, "imgADd" : self.imgADd, "tbv" : self.tbvPost, "lblMore" : self.lblMore, "txfMore": self.txfMore, "btnAdd" : self.btnADd, "img1" : self.image1, "img2" : self.image2, "img3" : self.image3] as [String : Any]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[lblAdd(30)]-100-[lblinfo(30)]-5-[tbv(125)]-5-[lblMore(30)]-5-[txfMore(60)]-20-[btnAdd(30)]", options: [], metrics: nil, views: View))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblinfo]-15-|", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblAdd]-15-|", options: [], metrics: nil, views: View))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[tbv]-15-|", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblMore]-15-|", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[txfMore]-15-|", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[btnAdd]-15-|", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-110-[imgADd(60)]", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imgADd(60)]-10-[img1(70)]-10-[img2(70)]-10-[img3(70)]", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-105-[img1(70)]", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-105-[img2(70)]", options: [], metrics: nil, views: View))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-105-[img3(70)]", options: [], metrics: nil, views: View))
        
//        self.automaticallyAdjustsScrollViewInsets = false
//        navigationItem.title = "Đăng tin"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PostViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return td.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tbvPost.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
            
            cell.name = td[indexPath.row]
            cell.hiden = placehoder[indexPath.row]
            
            info.title = cell.txfInfo.text!
            return cell
            
        }else if (indexPath.row == 1){
            let cell = tbvPost.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
            
            cell.name = td[indexPath.row]
            cell.hiden = placehoder[indexPath.row]
            
            info.price = cell.txfInfo.text!
            return cell
        }else if (indexPath.row == 2){
            let cell = tbvPost.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
            
            cell.name = td[indexPath.row]
            cell.hiden = placehoder[indexPath.row]
            
            info.area = cell.txfInfo.text!
            return cell
        }else if (indexPath.row == 3){
            let cell = tbvPost.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
            
            cell.name = td[indexPath.row]
            cell.hiden = placehoder[indexPath.row]
            
            info.phone = cell.txfInfo.text!
            return cell
        }else {
            let cell = tbvPost.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
            
            cell.name = td[indexPath.row]
            cell.hiden = placehoder[indexPath.row]
            
            info.address = cell.txfInfo.text!
            return cell
        }
    }
    
}

