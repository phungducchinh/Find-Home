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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
        
        cell.imaname = imgname[indexPath.row]
        cell.txfname = holder[indexPath.row]
        cell.backgroundColor = .white
        
        cell.txf.delegate = self
        cell.txf.tag = indexPath.row
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
//    override func numberOfRows(inSection section: Int) -> Int {
//        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func textFieldDidEndEditing(textField: UITextField) {
        print("TextField did end editing method called")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
        
        if !cell.t.isEmpty // check textfield contains value or not
        {
            if textField.tag == 0
            {
                username = textField.text!
            }
            else
            {
                password = textField.text!
            }
        }
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            
            textField.resignFirstResponder();
            return true;
        }
        
        func textFieldDidBeginEditing(textField: UITextField!) {
            if textField.tag == 0
            {
                username = ""
            }
            else
            {
                password = ""
            }
        }

    }
}
