//
//  HistoryViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit
import Alamofire

class HistoryViewController: UIViewController {
    var img : [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!]
    var apitoken = ""
    var dataShow = [NSDictionary]()
    var info = NSDictionary()
    
    let tbv : HistoryTableView = {
        let tbv = HistoryTableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.backgroundColor = .clear
        tbv.separatorStyle = .none
        return tbv
    }()
    
    
//    public let lblPhone : UILabel = {
//        let lblPhone = UILabel()
//        lblPhone.translatesAutoresizingMaskIntoConstraints = false
//        lblPhone.text = "01234456569"
//        lblPhone.font = lblPhone.font.withSize(15)
//        return lblPhone
//    }()
//    
//    public let lblname : UILabel = {
//        let lblname = UILabel()
//        lblname.translatesAutoresizingMaskIntoConstraints = false
//        lblname.text = "Phùng Đức Chính"
//        lblname.font = lblname.font.withSize(15)
//        return lblname
//    }()
//    
//    public let lblEmal : UILabel = {
//        let lblEmal = UILabel()
//        lblEmal.translatesAutoresizingMaskIntoConstraints = false
//        lblEmal.text = "chinh@gmail.com"
//        lblEmal.font = lblEmal.font.withSize(15)
//        return lblEmal
//    }()
//    
//    fileprivate let btnADd : UIButton = {
//        let btnADd = UIButton()
//        btnADd.backgroundColor = UIColor(red: 1/255.0, green: 143/255.0, blue: 255/255.0, alpha: 1.0)
//        btnADd.setTitleColor(.white , for: .normal)
//        btnADd.translatesAutoresizingMaskIntoConstraints = false
//        btnADd.setTitle("Cập nhật", for: .normal)
//        btnADd.layer.cornerRadius = 7
//        return btnADd
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apitoken = MyApi.appApi

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

        tbv.dataSource = self
        tbv.delegate = self
        tbv.register(HistoryCell.self, forCellReuseIdentifier: "Cell")
        tbv.register(NulCellTableViewCell.self, forCellReuseIdentifier: "Cellnul")
        if apitoken == "" {
            print("Chua load duoc api")
            let alert = UIAlertController(title: "Không lấy được thông tin api", message:"Vui lòng thử lại", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                print("Kiểm tra kết nối api")
            })
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            loadApi()
        }
        
        view.addSubview(tbv)
//        view.addSubview(lblPhone)
//        view.addSubview(lblname)
//        view.addSubview(lblEmal)
//        view.addSubview(btnADd)
        self.tbv.allowsSelection = true
        let views = ["tbv" : self.tbv]
//        
//        let views = ["tbv" : self.tbv, "phone" : self.lblPhone, "name" : self.lblname, "email" : self.lblEmal, "btn" : self.btnADd]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[tbv]-50-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tbv]-0-|", options: [], metrics: nil, views: views))
//        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[name(20)]-5-[email(20)]-5-[phone(20)]-10-[tbv]-50-|", options: [], metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[btn(40)]", options: [], metrics: nil, views: views))
//        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tbv]-0-|", options: [], metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[name]-20-[btn(100)]-20-|", options: [], metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[email]-0-|", options: [], metrics: nil, views: views))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[phone]-0-|", options: [], metrics: nil, views: views))

        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"camera"), style: .plain, target: self, action: #selector(Logout))
        
        navigationItem.title = "Cá nhân"
        // Do any additional setup after loading the view.
    }
    
    func Logout(){
        print("log out")
    }

    func loadApi(){
        let headers: HTTPHeaders = [
            "Http-Auth-Token": self.apitoken,
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://matas-app.herokuapp.com/api/v1/purchase/my_purchases", headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any]
                {
                    let dict = json as NSDictionary
                    self.dataShow = (dict["data"] as! NSArray) as! [NSDictionary]
                    self.tbv.reloadData()
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.dataShow.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HistoryCell
            self.info = self.dataShow[indexPath.row] 
            //cell.img = img[indexPath.row]
            cell.img = UIImage(named: "1")
            cell.address = self.info["address"] as? String
            cell.money = self.info["price"] as? String
            let number = self.info["acreage"] as! CFNumber
            cell.acreage = String(describing: number)
            cell.title = self.info["title"] as? String
            cell.backgroundColor = .white
            
            return cell
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cellnul") as! NulCellTableViewCell
            return cell
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataShow.count > 0 {
            return self.dataShow.count
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.dataShow.count > 0 {
            return true
        }else{
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
                let edit = UITableViewRowAction(style: .normal, title: "Sửa") { action, index in
                self.info = self.dataShow[indexPath.row]
                let sua = PostViewController()
                sua.coP = "1"
                let idnumber = self.info["id"] as! Int
                sua.id = String(describing: idnumber)
                //sua.imageList = (self.info["image"] as! NSArray) as! [UIImage]
                sua.titleName = self.info["title"] as! String
                sua.price = self.info["price"] as! String
                sua.area = self.info["acreage"] as! Float
                sua.phone = self.info["phone"] as! String
                sua.address = self.info["address"] as! String
                //sua.more = self.info["description"] as! String
                let descrip = String(describing: self.info["description"]!)
                    if descrip == "<null>"{
                       sua.more  = "Không có mô tả thêm"
                    }else{
                        sua.more = descrip
                    }

                self.navigationController?.pushViewController(sua, animated: true)
            }
            edit.backgroundColor = .red
            let delete = UITableViewRowAction(style: .normal, title: "Xoá") { action, index in
                self.info = self.dataShow[indexPath.row] 
                let idnumber = self.info["id"] as! Int
                let abc = "https://matas-app.herokuapp.com/api/v1/purchase/"
                let defaultUrl = URL(string: abc)
                let id = String(describing: idnumber)
            
                let headers: HTTPHeaders = [
                    "Http-Auth-Token": self.apitoken,
                    "Accept": "application/json"
                ]

                Alamofire.request((defaultUrl?.appendingPathComponent(id))!, method: HTTPMethod.delete, headers: headers).responseJSON { response in
                                if let json = response.result.value as? [String: Any]
                                    {
                                        let dict = json as NSDictionary
                                        let name = dict["message"] as? String //[String: Any]
                                        self.loadApi()
                                        self.tbv.reloadData()
                                        print(name!)
                                    }
                }
                print("delete button tapped")
            }
            delete.backgroundColor = .red
            
            return [edit, delete]
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if self.dataShow.count > 0 {
            let vc = DetailViewController() // Your destination
            self.info = self.dataShow[indexPath.row] 
            vc.infoDetail = self.info
            vc.co = "2"
            vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        
            navigationController?.pushViewController(vc, animated: true)
       }else {
            print("nothing tab")
        }
    }
}

