//
//  ListViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

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
        
        view.addSubview(tbvListView)
        
        tbvListView.dataSource = self
        tbvListView.delegate = self
        tbvListView.register(ListCell.self, forCellReuseIdentifier: "Cell")
        
        navigationController?.navigationItem.title = "Đăng bài"
        //self.navigationItem.title = "Tìm nhà trọ"
        //self.navigationController?.navigationBar.topItem?.title = "Tìm nhà trọ"

        self.tbvListView.allowsSelection = true
        
        let views = ["tbv" : self.tbvListView]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[tbv]-0-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tbv]-0-|", options: [], metrics: nil, views: views))
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListCell
        
        cell.img = img[indexPath.row]
        cell.address = address[indexPath.row]
        cell.money = money[indexPath.row]
        cell.acreage = acreage[indexPath.row]
        cell.title = titleN[indexPath.row]
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
        return img.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tab tab tab")
        let vc = DetailViewController() // Your destination
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

