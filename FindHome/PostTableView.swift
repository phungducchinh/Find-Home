//
//  PostTableView.swift
//  PhongTroOnline
//
//  Created by TaNhi on 3/13/18.
//  Copyright © 2018 TaNhi. All rights reserved.
//

import Foundation
import UIKit

class PostTableView: UITableView {

    let td = ["Tiêu đề:","Giá phòng:","Diện tích:","Điện thoại:","Địa chỉ:"]
    let placehoder = ["Cho thuê nhà nguyên căn", "1.500.000 đ", "12 mét vuông", "01234567899", "Lã Xuân Oai, Quận 9"]
    
    //var infotbv = PostInfo(title: "dssdf", price: "sdfsdf" as! CFNumber, area: "sdfsdf", address: "sdfsdf", phone: "sdfsdf")
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        //self.delegate = self
        
        self.register(PostCell.self, forCellReuseIdentifier: "cell")
        
       // self.dataSource = self
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//extension PostTableView : UITableViewDelegate, UITableViewDataSource{
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 25
//    }
//    
//    override func numberOfRows(inSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return td.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath.row == 0) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
//            
//            cell.name = td[indexPath.row]
//            cell.hiden = placehoder[indexPath.row]
//            
//            infotbv.title = cell.txfInfo.text!
//            return cell
//            
//        }else if (indexPath.row == 1){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
//            
//            cell.name = td[indexPath.row]
//            cell.hiden = placehoder[indexPath.row]
//            
//            infotbv.price = cell.txfInfo.text!
//            return cell
//        }else if (indexPath.row == 2){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
//            
//            cell.name = td[indexPath.row]
//            cell.hiden = placehoder[indexPath.row]
//            
//            infotbv.area = cell.txfInfo.text!
//            return cell
//        }else if (indexPath.row == 3){
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
//            
//            cell.name = td[indexPath.row]
//            cell.hiden = placehoder[indexPath.row]
//            
//            infotbv.phone = cell.txfInfo.text!
//            return cell
//        }else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PostCell
//            
//            cell.name = td[indexPath.row]
//            cell.hiden = placehoder[indexPath.row]
//            
//            infotbv.address = cell.txfInfo.text!
//            return cell
//        }
//    }
    
//}
