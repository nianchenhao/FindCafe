//
//  Data.swift
//  FindCafe
//
//  Created by 粘辰晧 on 2021/6/9.
//

import Foundation

struct CafeInfo:Codable {
    let name: String
    let address: String
    let limited_time: String
    let latitude: String
    let longitude: String
    let open_time: String
}
