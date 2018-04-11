//
//  ListViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit
import Alamofire
//mport SwiftyJSON

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
        //tbvListView.isScrollEnabled = false
        return tbvListView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        apitoken = MyApi.appApi
        view.addSubview(tbvListView)
        
        print("apilogin ne " + apitoken)
        print("Myapi in List" + MyApi.appApi)
        tbvListView.dataSource = self
        tbvListView.delegate = self
        tbvListView.register(ListCell.self, forCellReuseIdentifier: "Cell")
        tbvListView.register(NulCellTableViewCell.self, forCellReuseIdentifier: "Cellnul")
        if apitoken == "" {
            print("Chua load duoc api")
            var alert = UIAlertView(title: "Không lấy được thông tin user", message: "Vui lòng thử lại", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else
        {
            loadApi()
        }
        navigationController?.navigationItem.title = "Đăng bài"
        //self.navigationItem.title = "Tìm nhà trọ"
        //self.navigationController?.navigationBar.topItem?.title = "Tìm nhà trọ"

        self.tbvListView.allowsSelection = true
        
        let views = ["tbv" : self.tbvListView]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[tbv]-0-|", options: [], metrics: nil, views: views))
        
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
                print(response)
                if let json = response.result.value as? [String: Any]
                {
                    //print(json)
                    let dict = json as NSDictionary
                    let name = dict["message"] as? String //[String: Any]
                    
                    let data = dict["data"] as! NSArray
                    self.dataShow = (dict["data"] as! NSArray) as! [NSDictionary]
                   // print(self.dataShow[0])
                  //  self.info = self.dataShow[0] as! NSDictionary
                   // print(self.info["title"])
                   // if (self.dataShow.count > 0 ){
                        self.tbvListView.reloadData()
                   // }
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dataShow.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListCell
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
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cellnul") as! NulCellTableViewCell
            return cell
        }
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
        if self.dataShow.count > 0 {
            return self.dataShow.count
        }
        else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tab tab tab")
        let vc = DetailViewController() // Your destination
        self.info = self.dataShow[indexPath.row] as! NSDictionary
        vc.infoDetail = self.info
        vc.co = "1"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

