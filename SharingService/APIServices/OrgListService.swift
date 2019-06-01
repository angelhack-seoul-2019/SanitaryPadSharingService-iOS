//
//  OrgListService.swift
//  SharingService
//
//  Created by 임수현 on 01/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import Foundation
import Alamofire

struct OrgListService {
    
    static let shared = OrgListService()
    
    func getList(_ lat: Double, _ lon: Double, _ type: Int, completion: @escaping (_ data: [OrgDatas]) -> Void) {
        
        Alamofire.request("\(APIConstants.OrgURL)/\(lat)/\(lon)/\(type)").responseJSON {
            response in
            print("response: \(response)")
            print("response.result : \(response.result)")
            
            switch response.result{
            case .success:
                
                guard let result = response.data else {return}
                print(result)
                do{
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(OrgListResult.self, from: result)
                    print("json : \(json)")
                    
                    completion(json.data)
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
