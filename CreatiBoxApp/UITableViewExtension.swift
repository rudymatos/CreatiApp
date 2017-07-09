//
//  UITableViewExtension.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell{
    func format(cardView : UIView){
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = true
        cardView.layer.borderColor = UIColor.black.cgColor
        cardView.layer.borderWidth = 0.5
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 3
        cardView.layer.shadowOpacity = 0.6
        cardView.layer.masksToBounds = false
    }
}
