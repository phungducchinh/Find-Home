//
//  MyApi.swift
//  FindHome
//
//  Created by phungducchinh on 4/7/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

struct MyApi {
    static var appApi = ""
    
    public var apiname : String?{
        didSet{
            MyApi.appApi = apiname!
        }
    }
}
