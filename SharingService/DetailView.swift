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
        countLabel.text = "\(c)개"

        switch t {
        case 0:
            typeLabel.text = "코인 자판기형"
        default:
            typeLabel.text = "일반 자판기형"
        }
    }
    
}

