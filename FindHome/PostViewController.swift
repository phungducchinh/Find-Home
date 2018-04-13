//
//  PostViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit
import Alamofire

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var apitoken = ""
    var infoPost = NSDictionary()
    
    var coP = "0"
    var titleName = ""
    var price = ""
    var area : Float = 0
    var address = ""
    var phone = ""
    var more = ""
    var id = ""
    
    let td = ["Tiêu đề:","Giá phòng:","Diện tích:","Điện thoại:","Địa chỉ:"]
    let placehoder = ["Cho thuê nhà nguyên căn", "1.500.000 đ", "12 mét vuông", "01234567899", "Lã Xuân Oai, Quận 9"]
    
    var imageList = [UIImage]()
    
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
        btnADd.backgroundColor = UIColor(red: 1/255.0, green: 143/255.0, blue: 255/255.0, alpha: 1.0)
        btnADd.setTitleColor(.white , for: .normal)
        btnADd.translatesAutoresizingMaskIntoConstraints = false
        btnADd.layer.cornerRadius = 7
        return btnADd
    }()
    
    func actionPost()
    {
        let index1 = IndexPath(row: 0, section: 0)
        if let cell = tbvPost.cellForRow(at: index1) as? PostCell {
            titleName = cell.txfInfo.text!
        }
        let index2 = IndexPath(row: 1, section: 0)
        if let cell = tbvPost.cellForRow(at: index2) as? PostCell {
            price = cell.txfInfo.text!
        }
        let index3 = IndexPath(row: 2, section: 0)
        if let cell = tbvPost.cellForRow(at: index3) as? PostCell {
            area = Float(cell.txfInfo.text!)!
        }
        let index4 = IndexPath(row: 3, section: 0)
        if let cell = tbvPost.cellForRow(at: index4) as? PostCell {
            phone = cell.txfInfo.text!
        }
        let index5 = IndexPath(row: 4, section: 0)
        if let cell = tbvPost.cellForRow(at: index5) as? PostCell {
            address = cell.txfInfo.text!
        }
        
        
        let destination = DetailViewController() // Your destination
        PostData.imageList = imageList
        PostData.title = titleName
        PostData.price = price
        PostData.area = area
        PostData.address = address
        PostData.phone = phone
        PostData.more = txfMore.text!
        destination.co = "0"
        self.navigationController?.pushViewController(destination, animated: true)

    }
    
    func postInfo() {
       actionPost()
        
    }
    
    func PutInfo(){
        actionPost()
        
        let abc = "https://matas-app.herokuapp.com/api/v1/purchase/"
        let defaultUrl = URL(string: abc)
        
        let headers: HTTPHeaders = [
            "Http-Auth-Token": self.apitoken,
            "Accept": "application/json"
        ]
        
        let param = ["title" : PostData.title , "price" : PostData.price , "acreage": PostData.area , "address" : PostData.address , "phone" : PostData.phone , "description" : PostData.more] as [String : Any]
        
        Alamofire.request((defaultUrl?.appendingPathComponent(id))!, method: HTTPMethod.put, parameters: param, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any]
            {
                let dict = json as NSDictionary
                let status = dict["status"] as? Bool //[String: Any]
                if status == true{
                   
                    let alert = UIAlertController(title: "Bạn đã cập nhật thành công", message:"", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                        print("Cập nhật thành công")
                    })
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    let alert = UIAlertController(title: "Cập nhật không thành công", message: "Vui lòng kiểm tra và cập nhật lại!", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Huỷ")
                    })
                    alert.addAction(ok)
                    alert.present(self, animated: true, completion: nil)
                }
            }
        }

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
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        }else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "Chưa có kết nối mạng internet", message:"Vui lòng kiểm tra lại kết nối mạng", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                print("Kiểm tra kết nối internet")
            })
            self.present(alert, animated: true, completion: nil)
        }

        
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
        apitoken = MyApi.appApi
        
        if coP == "0"{
            btnADd.setTitle("Đăng tin", for: .normal)
            btnADd.addTarget(self , action: #selector(postInfo), for: .touchUpInside)
        }else{
            btnADd.setTitle("Cập nhật", for: .normal)
            self.navigationItem.title = "Chỉnh sửa thông tin"
            imgADd.isEnabled = false
            txfMore.text! = more
            btnADd.addTarget(self , action: #selector(PutInfo), for: .touchUpInside)
        }
        
        tbvPost.delegate = self
        tbvPost.dataSource = self
        tbvPost.reloadData()
        tbvPost.register(PostCell.self, forCellReuseIdentifier: "Cell")
        
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
            if coP == "1" {
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
                     cell.name = td[indexPath.row]
                    cell.txfInfo.text! = titleName
                    return cell
                }else if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
                    cell.name = td[indexPath.row]
                    cell.txfInfo.text! = price
                    return cell
                }else if indexPath.row == 2{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
                    cell.name = td[indexPath.row]
                    cell.txfInfo.text = String(area)
                    return cell
                }else if indexPath.row == 3{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
                    cell.name = td[indexPath.row]
                    cell.txfInfo.text! = phone
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
                    cell.name = td[indexPath.row]
                    cell.txfInfo.text! = address
                    return cell
                }
            }else{
                let cell = tbvPost.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
            
                cell.name = td[indexPath.row]
                cell.hiden = placehoder[indexPath.row]
            
                return cell
            }
    }
}
