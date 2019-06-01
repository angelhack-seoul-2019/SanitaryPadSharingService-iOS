//
//  APIConstants.swift
//  SharingService
//
//  Created by 임수현 on 01/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import Foundation

struct APIConstants {
    static let BaseURL = "http://13.59.243.151/api"
    static let OrgURL = BaseURL + "/organization/around"
    static let OrgScheduleURL = BaseURL + "/organization/schedule"
    static let AuthURL = BaseURL + "/auth"
    static let LoginURL = AuthURL + "/signin"
    static let WebtoonURL = BaseURL + "/webtoons"
    static let EpisodeURL = WebtoonURL + "/episodes"
    static let CommentURL = EpisodeURL + "/cmts"
}

