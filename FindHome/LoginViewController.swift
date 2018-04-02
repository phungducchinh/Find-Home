//
//  LoginViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    let login = LoginView()
    
    var username = ""
    var password = ""
    
    var imgname = [UIImage(named: "user")!,UIImage(named: "pass")! ]
    var holder = ["Email/Số điện thoại", "Mật khẩu" ]

    
    fileprivate let tbvLogin : LoginTableView = {
        let tbvLogin = LoginTableView()
        tbvLogin.translatesAutoresizingMaskIntoConstraints = false
        tbvLogin.layer.cornerRadius = 7
        tbvLogin.isScrollEnabled = false
        tbvLogin.contentInset = UIEdgeInsets.zero
        return tbvLogin
    }()
    
    fileprivate let btnLogin : UIButton = {
        let btnLogin = UIButton()
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.setTitle("Đăng nhập", for: .normal)
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.titleLabel?.font = btnLogin.titleLabel?.font.withSize(17)
        btnLogin.layer.cornerRadius = 7
        btnLogin.backgroundColor = UIColor(red: 0/255, green: 143/255, blue: 255/255, alpha: 1)
        btnLogin.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return btnLogin
    }()
    
    fileprivate let btnRegister : UIButton = {
        let btnRegister = UIButton()
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.setTitle("Đăng ký", for: .normal)
        btnRegister.setTitleColor(.white, for: .normal)
        btnRegister.titleLabel?.font = btnRegister.titleLabel?.font.withSize(15)
        btnRegister.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchUpInside)
        btnRegister.backgroundColor = nil
        return btnRegister
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.automaticallyAdjustsScrollViewInsets = false
        
       // self.view = self.login
        navigationItem.title = "Đăng nhập"
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        }else {
            print("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

        view.addSubview(tbvLogin)
        view.addSubview(btnLogin)
        view.addSubview(btnRegister)
        
        view.backgroundColor = UIColor(red: 254/255, green: 80/255, blue: 4/255, alpha: 1)
        
        tbvLogin.dataSource = self
        tbvLogin.delegate = self
        tbvLogin.register(LoginCell.self, forCellReuseIdentifier: "Cell")

        
        self.tbvLogin.allowsSelection = false
        let views = ["tbv" : self.tbvLogin, "btnLogin" : self.btnLogin, "btnFogot" : self.btnRegister] as [String : Any]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[tbv(80)]-40-[btnLogin(40)]-5-[btnFogot(40)]", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[tbv]-5-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnLogin]-5-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnFogot]-5-|", options: [], metrics: nil, views: views))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signInButtonTapped() {
        
        tbvLogin.reloadData()
        let destination = TabBarViewController() // Your destination
        navigationController?.pushViewController(destination, animated: true)
        
//        if(tbvLogin.username == "" || tbvLogin.password == ""){
//            print("error")
//            var alert = UIAlertView(title: "Chưa nhập đủ thông tin", message: "Nhập đủ các thông tin trước khi đăng nhập", delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
//        }else{
//            print(tbvLogin.username)
//            print(tbvLogin.password)
//            
//            let url = URL(string: "https://matas-app.herokuapp.com/api/v1/auth/sign_in")
//            let session = URLSession.shared
//            
//            let request = NSMutableURLRequest(url: url!)
//            request.httpMethod = "POST"
//            
//            let paramTosend = "email" + tbvLogin.username + "password" +  tbvLogin.password
//            request.httpBody = paramTosend.data(using: String.Encoding.utf8)
//            
//            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
//                
//                guard let _:Data = data else
//                {
//                    return
//                }
//                
//                let json:Any?
//                
//                do{
//                    json = try JSONSerialization.jsonObject(with: data!, options: [])
//                }
//                catch
//                {
//                    return
//                }
//                
//                guard let server_response = json as? NSDictionary else
//                {
//                    return
//                }
//                
//                if let data_block = server_response["data"] as? NSDictionary
//                {
//                    if let session_data = data_block["session"] as? String
//                    {
//                        let preferences = UserDefaults.standard
//                        preferences.set(session_data, forKey: "session")
//                        
//                        DispatchQueue.main.sync (
//                            execute:self.LoginDone
//                        )
//                    }
//                }
//            })
//            
//            task.resume()
//            
//        }

    }
    func RegisterButtonTapped() {
        print("next to view dang ky")
        let destination = RegisterViewController() // Your destination
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func LoginDone(){
        print("Login thanh cong")
        
    }
    
    func LoginTodo(){
        print("Login khong thanh cong")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController : UITableViewDelegate, UITableViewDataSource {
    
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
    
    //    override func numberOfRows(inSection section: Int) -> Int {
    //        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holder.count
    }
    
}
