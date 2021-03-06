//
//  LoginTableView.swift
//  FindHome
//
//  Created by phungducchinh on 3/13/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class RegisterTableView: UITableView {
    
    var imgname = [UIImage(named: "user")!,UIImage(named: "pass")!, UIImage(named: "pass")! ]
    var holder = ["Email", "Mật khẩu", "Nhập lại mật khẩu" ]
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.delegate = self
        self.register(RegisterCell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegisterTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RegisterCell
            
            cell.txf.isSecureTextEntry = false
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            return cell
            
        }else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RegisterCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            cell.txf.isSecureTextEntry = true
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RegisterCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            cell.txf.isSecureTextEntry = true
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgname.count
    }
    
}
