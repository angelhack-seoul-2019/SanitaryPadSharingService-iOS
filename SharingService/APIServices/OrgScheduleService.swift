//
//  OrgScheduleService.swift
//  SharingService
//
//  Created by 남수김 on 02/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import Foundation
import Alamofire

struct OrgScheduleService {
    
    static let shared = OrgScheduleService()
    
    func getSchedule(_ organiId: Int, _ today: Int, completion: @escaping (_ data: [OrgSchedules]) -> Void) {
        
        Alamofire.request("\(APIConstants.OrgScheduleURL)/\(organiId)/\(today)").responseJSON {
            response in
            
            switch response.result{
            case .success:
                
                    guard let result = response.data else {return}
                    do{
                        let decoder = JSONDecoder()
                        let json = try decoder.decode(OrgScheduleResult.self, from: result)
                        
                        if json.result == 200 {
                            completion(json.data)
                        }
                    } catch {
                        fatalError()
                    }
                
                break
            default:
                break
            }
        }
    }
    
    
}
