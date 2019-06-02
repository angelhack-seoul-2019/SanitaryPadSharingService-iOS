//
//  ScheduleViewController.swift
//  SharingService
//
//  Created by 남수김 on 02/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var name = String()
    var image = UIImage()
    var addr = String()
    var openTime = String()
    var organiId = Int()
    
    var dateFormatter = DateFormatter()
    var dateInt = Int()
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "yyyyMMdd"
        dateInt = Int(dateFormatter.string(from: Date())) ?? 0
        
        nameLabel.text = name
        addressLabel.text = addr
        openTimeLabel.text = openTime
        
        //기업의 이벤트 받아오는 통신
        OrgScheduleService.shared.getSchedule(organiId, self.dateInt){
            data in
            //data 배열은 해당마커를 클릭했을때 나오는 일정들
            OperationQueue.main.addOperation {
                
                for schedule in data {
                    self.titleLabel.text = schedule.title 
                    self.textView.text = schedule.memo 
                    
                }
            }
            
        }
    }
    @IBAction func backBtnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
