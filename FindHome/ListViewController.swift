//
//  ListViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {
    var apitoken = ""
    var dataShow = [NSDictionary]()
    var info = NSDictionary()
    
    var img : [UIImage] = [UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "1")!,UIImage(named: "2")!,UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!]
    var address = ["Hiệp Phú, Quận 9, TP.Hồ Chí Minh","Thảo Điền, Quận 2, TP.Hồ Chí Minh","Bến Thành, Quận 1, TP.Hồ Chí Minh","Bình Thọ, Thủ Đức, TP.Hồ Chí Minh","Phú Xuân, Nhà Bè, TP.Hồ Chí Minh","Hiệp Phú, Quận 9, TP.Hồ Chí Minh","Thảo Điền, Quận 2, TP.Hồ Chí Minh","Bến Thành, Quận 1, TP.Hồ Chí Minh","Bình Thọ, Thủ Đức, TP.Hồ Chí Minh","Phú Xuân, Nhà Bè, TP.Hồ Chí Minh"]
    var money = ["3.000.000đ","4.500.000đ", "6.800.000đ", "2.400.000đ", "1.600.000đ","3.000.000đ","4.500.000đ", "6.800.000đ", "2.400.000đ", "1.600.000đ"]
    var acreage = ["24 m2", "18 m2", "15 m2", "30 m2", "20 m2","24 m2", "18 m2", "15 m2", "30 m2", "20 m2"]
    var titleN = ["Cho thue nha nguyen can", "Nha tro gia re", "Nha tro quan 1", "Nha nguyen can Thu Duc", "Nha nguyen can gia re","Cho thue nha nguyen can", "Nha tro gia re", "Nha tro quan 1", "Nha nguyen can Thu Duc", "Nha nguyen can gia re",]

    
    let tbvListView : ListTableView = {
        let tbvListView = ListTableView()
        tbvListView.translatesAutoresizingMaskIntoConstraints = false
        tbvListView.backgroundColor = .clear
        tbvListView.separatorStyle = .none
        return tbvListView
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
        print(MyApi.appApi)
        apitoken = MyApi.appApi
        view.addSubview(tbvListView)
        
        tbvListView.dataSource = self
        tbvListView.delegate = self
        tbvListView.register(ListCell.self, forCellReuseIdentifier: "Cell")
        tbvListView.register(NulCellTableViewCell.self, forCellReuseIdentifier: "Cellnul")
        if apitoken == "" {
            print("Chua load duoc api")
            let alert = UIAlertController(title: "Không lấy được thông tin", message:"Vui lòng thử lại", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                print("Kiểm tra lấy api user")
            })
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            loadApi()
        }
        navigationController?.navigationItem.title = "Đăng bài"

        self.tbvListView.allowsSelection = true
        
        let views = ["tbv" : self.tbvListView]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[tbv]-50-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tbv]-0-|", options: [], metrics: nil, views: views))
        
        // Do any additional setup after loading the view.
        
    }
    
    func loadApi(){
        let headers: HTTPHeaders = [
            "Http-Auth-Token": self.apitoken,
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://matas-app.herokuapp.com/api/v1/purchase", headers: headers)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any]
                {
                    let dict = json as NSDictionary
                    let name = dict["message"] as? String 
                    print(name!)
                    self.dataShow = (dict["data"] as! NSArray) as! [NSDictionary]
                    self.tbvListView.reloadData()
                }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dataShow.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListCell
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
        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataShow.count > 0 {
            return self.dataShow.count
        }
        else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController() // Your destination
        self.info = self.dataShow[indexPath.row] 
        vc.infoDetail = self.info
        vc.co = "1"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

