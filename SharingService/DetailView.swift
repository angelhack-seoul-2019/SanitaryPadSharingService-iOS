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
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setLabels(){
//        distanceLabel.text = "반경 \(distance)m 이내"
//        nameLabel.text = name
//        addressLabel.text = address
//        opentimeLabel.text = opentime
//        countLabel.text = "\(count)개"
//
//        switch type {
//        case 0:
//            typeLabel.text = "코인 자판기형"
//        default:
//            typeLabel.text = "일반 자판기형"
//        }
    }
}

