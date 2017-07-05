//
//  BranchOfficeTVCTableViewCell.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/3/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class BranchOfficeTVC: UITableViewCell {
    
    @IBOutlet weak var branchOfficeName: UILabel!
    @IBOutlet weak var branchOfficeLocation: UILabel!
    
    var currentBranchOffice : BranchOffice?{
        didSet{
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView(){
        if let currentBranchOffice = currentBranchOffice{
            branchOfficeName.text = currentBranchOffice.name
            branchOfficeLocation.text = currentBranchOffice.address
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.backgroundColor = UIColor.clear
        if selected{
            branchOfficeName.textColor = UIColor(red:0.61, green:0.20, blue:0.10, alpha:1.0)
            branchOfficeLocation.textColor = UIColor(red:0.61, green:0.20, blue:0.10, alpha:1.0)
        }else{
            branchOfficeName.textColor = UIColor(red:0.98, green:0.92, blue:0.08, alpha:1.0)
            branchOfficeLocation.textColor = UIColor(red:0.98, green:0.92, blue:0.08, alpha:1.0)
        }
        
    }
}
