//  HistoryView.swift
//  FindHome
//
//  Created by phungducchinh on 3/13/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class HistoryView: UIView {
    
    let tbvListView : HistoryTableView = {
        let tbvListView = HistoryTableView()
        tbvListView.translatesAutoresizingMaskIntoConstraints = false
        tbvListView.backgroundColor = .clear
        tbvListView.separatorStyle = .none
        //tbvListView.isScrollEnabled = false
        return tbvListView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(tbvListView)
        //self.addSubview(btnBack)
        //btnBack.addTarget(self, action: #selector(BackView), for: .touchUpInside)
        self.tbvListView.allowsSelection = false
        let views = ["tbv" : self.tbvListView]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tbv]-0-|", options: [], metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tbv]-0-|", options: [], metrics: nil, views: views))
        //self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-70-[btn]-70-|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}