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
        self.tbv.allowsSelection = true
        let views = ["tbv" : self.tbv]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[tbv]-50-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tbv]-0-|", options: [], metrics: nil, views: views))
        
        
        
        navigationItem.title = "Các tin đã đăng"
        // Do any additional setup after loading the view.
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
            cell.img = img[indexPath.row]
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
                sua.more = self.info["description"] as! String
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
            navigationController?.pushViewController(vc, animated: true)
       }else {
            print("nothing tab")
        }
    }
}

