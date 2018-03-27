//
//  LoginTableView.swift
//  FindHome
//
//  Created by phungducchinh on 3/13/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class LoginTableView: UITableView {
    
    var username = ""
    var password = ""
    
    var imgname = [UIImage(named: "user")!,UIImage(named: "pass")! ]
    var holder = ["Email/Số điện thoại", "Mật khẩu" ]
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.delegate = self
        self.register(LoginCell.self, forCellReuseIdentifier: "Cell")
        
      
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            
            username = cell.txf.text!
            return cell
           
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            
            password = cell.txf.text!
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
//    override func numberOfRows(inSection section: Int) -> Int {
//        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    }
