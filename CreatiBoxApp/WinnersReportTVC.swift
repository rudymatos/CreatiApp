//
//  WinnersReportTVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class WinnersReportTVC: UITableViewCell {
    
    @IBOutlet weak var spanishDateLBL: UILabel!
    @IBOutlet weak var branchOfficeIV: UIImageView!
    @IBOutlet weak var prizeIV: UIImageView!
    @IBOutlet weak var givenAtLBL: UILabel!
    @IBOutlet weak var givenByLBL: UILabel!
    @IBOutlet weak var customerNameLBL: UILabel!
    @IBOutlet weak var customerIdLBL: UILabel!
    @IBOutlet weak var customerEmailLBL: UILabel!
    @IBOutlet weak var customerPhoneLBL: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    var winnerReportDTO: WinnerReportDTO?{
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
        if let winnerReportDTO = winnerReportDTO{
            spanishDateLBL.text = winnerReportDTO.spanishDate
            branchOfficeIV.image = UIImage(named: winnerReportDTO.branchOfficeImage)
            prizeIV.image = UIImage(named: winnerReportDTO.prizeImage)
            givenAtLBL.text = getNAString(currentString: winnerReportDTO.givenAt)
            givenByLBL.text = getNAString(currentString: winnerReportDTO.givenBy)
            customerNameLBL.text = getNAString(currentString: winnerReportDTO.winnerName)
            customerIdLBL.text = getNAString(currentString: winnerReportDTO.winnerId)
            customerEmailLBL.text = getNAString(currentString: winnerReportDTO.winnerEmail)
            customerPhoneLBL.text = getNAString(currentString: winnerReportDTO.winnerPhone)
        }
    }
    
    func getNAString(currentString: String) -> String{
        var newString = currentString
        if currentString.trimmingCharacters(in: CharacterSet.whitespaces) == ""{
            newString = "NO ESPECIFICADO"
        }
        return newString
    }
}
