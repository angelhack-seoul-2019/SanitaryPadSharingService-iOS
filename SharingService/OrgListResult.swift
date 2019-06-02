//
//  ResponseString.swift
//  SharingService
//
//  Created by 임수현 on 02/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import Foundation

struct OrgDatas: Codable {
    let id: Int
    let name: String
    let lat: Double
    let lon: Double
    let address: String
    let phone: String
    let type: Int
    let opentime: String
    let curcount: Int
    let totalcount: Int
    let dist: Double
}

struct OrgListResult: Codable {
    let result: Int
    let data: [OrgDatas]
}
