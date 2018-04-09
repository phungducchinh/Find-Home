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
        //tbvListView.isScrollEnabled = false
        return tbv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apitoken = MyApi.appApi

        print("apilogin ne " + apitoken)
        print("History api " + MyApi.appApi)
        tbv.dataSource = self
        tbv.delegate = self
        tbv.register(HistoryCell.self, forCellReuseIdentifier: "Cell")
        if apitoken == "" {
            print("Chua load duoc api")
            var alert = UIAlertView(title: "Không lấy được thông tin user", message: "Vui lòng thử lại", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else
        {
            loadApi()
        }
        
        view.addSubview(tbv)
        self.tbv.allowsSelection = true
        let views = ["tbv" : self.tbv]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[tbv]-0-|", options: [], metrics: nil, views: views))
        
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
                print(response)
                if let json = response.result.value as? [String: Any]
                {
                    print(json)
                    let dict = json as NSDictionary
                    let name = dict["message"] as? String //[String: Any]
                    
                    let data = dict["data"] as! NSArray
                    self.dataShow = (dict["data"] as! NSArray) as! [NSDictionary]
                    print(self.dataShow[0])
                    self.info = self.dataShow[0] as! NSDictionary
                    print(self.info["title"])
                    if (self.dataShow.count > 0 ){
                        self.tbv.reloadData()
                    }
                    //print(data[1])
                    //print(name)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HistoryCell
        self.info = self.dataShow[indexPath.row] as! NSDictionary
        
        cell.img = img[indexPath.row]
        cell.address = self.info["address"] as! String
        cell.money = self.info["price"] as! String
        let number = self.info["acreage"] as! CFNumber
        print(number)
        cell.acreage = String(describing: number)
        cell.title = self.info["title"] as! String
        cell.backgroundColor = .white

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return CGFloat(UITableViewAutomaticDimension)
    //    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataShow.count
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Sửa") { action, index in
            //self.isEditing = false
            print("edit button tapped")
        }
        edit.backgroundColor = .red
        let delete = UITableViewRowAction(style: .normal, title: "Xoá") { action, index in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! HistoryCell
            self.info = self.dataShow[indexPath.row] as! NSDictionary
            let idnumber = self.info["id"] as! CFNumber
            print(idnumber)
            let defaultUrl = "https://matas-app.herokuapp.com/api/v1/purchase/"
            let id = String(describing: idnumber)
            print(id)
            let url = URL(string: defaultUrl + String(describing: idnumber))
                //(defaultUrl + String(describing: idnumber)) as! URL
            print("the url = \(url!)")
            
            let headers: HTTPHeaders = [
                "Http-Auth-Token": self.apitoken,
                "Accept": "application/json"
            ]
//            Alamofire.request(url!, headers: headers)
//                .responseJSON { response in
//                    print(response)
//                    if let json = response.result.value as? [String: Any]
//                    {
//                        print(json)
//                        let dict = json as NSDictionary
//                        let name = dict["message"] as? String //[String: Any]
//                            self.tbv.reloadData()
//                        print(name)
//                    }
//            }
            //Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [AUTH_TOKEN_KEY : AUTH_TOKEN])
            Alamofire.request(url!, headers: headers).responseJSON { response in
                                print(response)
                                if let json = response.result.value as? [String: Any]
                                {
                                    print(json)
                                    let dict = json as NSDictionary
                                    let name = dict["message"] as? String //[String: Any]
                                        self.tbv.reloadData()
                                    print(name)
                                }
            }
            print("delete button tapped")
        }
        delete.backgroundColor = .red
        
        return [edit, delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("history tab")
        let vc = DetailViewController() // Your destination
        self.info = self.dataShow[indexPath.row] as! NSDictionary
        vc.infoDetail = self.info
        vc.co = "2"
        navigationController?.pushViewController(vc, animated: true)

    }
}

