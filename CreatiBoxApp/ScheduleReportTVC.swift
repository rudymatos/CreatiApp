//
//  ScheduleReportTVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/7/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class ScheduleReportTVC: UITableViewCell {
    
    @IBOutlet weak var branchOfficeNameAddressLBL: UILabel!
    @IBOutlet weak var branchOfficeIV: UIImageView!
    @IBOutlet weak var spanishDateLBL: UILabel!
    @IBOutlet weak var glovesCounterLBL: UILabel!
    @IBOutlet weak var spoonCounterLBL: UILabel!
    @IBOutlet weak var lunchBoxCounterLBL: UILabel!
    @IBOutlet weak var plasticContainerCounterLBL: UILabel!
    @IBOutlet weak var promotionalKitCounterLBL: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    var dataReport : DataReportDTO?{
        didSet{
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    
    func configureView(){
        format(cardView: cardView)
        if let dataReport = dataReport{
            branchOfficeNameAddressLBL.text = "\(dataReport.branchOfficeName) \(dataReport.branchOfficeAddress)"
            spanishDateLBL.text = dataReport.spanishDate
            branchOfficeIV.image = UIImage(named: dataReport.branchOfficeImage)
            for currentPrizeCounter in dataReport.prizeCounter{
                if  let prizeType = Prize.PrizeType(rawValue: currentPrizeCounter.name){
                    switch prizeType {
                    case .spoon:
                        spoonCounterLBL.text = "\(currentPrizeCounter.quantity)"
                    case .kitchen_glove:
                        glovesCounterLBL.text = "\(currentPrizeCounter.quantity)"
                    case .lunch_box:
                        lunchBoxCounterLBL.text = "\(currentPrizeCounter.quantity)"
                    case .plastic_container:
                        plasticContainerCounterLBL.text = "\(currentPrizeCounter.quantity)"
                    case .promotional_kit:
                        promotionalKitCounterLBL.text = "\(currentPrizeCounter.quantity)"
                    }
                }
            }
        }
    }
}
