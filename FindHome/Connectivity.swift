//
//  Connectivity.swift
//  FindHome
//
//  Created by phungducchinh on 3/21/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
