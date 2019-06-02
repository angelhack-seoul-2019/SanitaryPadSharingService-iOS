//
//  DetailView.swift
//  SharingService
//
//  Created by 임수현 on 02/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var opentimeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var organiId = Int()
    var type = -1
    var scheduleCount = 0
    var count = 0
    let dateFormatter = DateFormatter()
    
    class func instanceFromNib() -> DetailView {
        return UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DetailView
    }
    
    func setLabels(organiId id:Int, dis d:Double, name n:String, address addr:String, opentime ot:String, count c:Int, type t:Int){
        organiId = id
        let disInt = String(format: "%.2f", d)
        distanceLabel.text = "반경 \(disInt)km 이내"
        nameLabel.text = n
        addressLabel.text = addr
        opentimeLabel.text = ot
        countLabel.text = ""
        self.count = c
        self.type = t
        
        switch self.type {
        case 0:
            typeLabel.text = "코인 자판기형"
            countLabel.text = "\(self.count)개"
        case 1:
            typeLabel.text = "일반 자판기형"
            countLabel.text = "\(self.scheduleCount)개의 일정"
        case 2:
            typeLabel.text = ""
            countLabel.text = ""
            
        default:
            return
        }
        
        
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateInt = Int(dateFormatter.string(from: Date())) ?? 0
        
        OrgScheduleService.shared.getSchedule(id, dateInt){
            data in
            //data 배열은 해당마커를 클릭했을때 나오는 일정들
            
            self.scheduleCount = data.count
            
        
            
        }
        
        
    }
   
}

