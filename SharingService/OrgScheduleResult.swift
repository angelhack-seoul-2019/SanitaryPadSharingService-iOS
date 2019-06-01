//
//  OrgScheduleResult.swift
//  SharingService
//
//  Created by 남수김 on 02/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import Foundation

struct OrgSchedules: Codable {
    let id: Int
    let organiId: Int
    let schedule: Int
    let memo: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case organiId = "organi_id"
        case schedule, memo, title
    }
}

struct OrgScheduleResult: Codable {
    let result: Int
    let data: [OrgSchedules]
}
