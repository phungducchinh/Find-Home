//
//  DetailViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/27/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let detail = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = self.detail
        navigationItem.title = "Thông tin chi tiết"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
