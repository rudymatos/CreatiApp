//
//  AlertViewHelper.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import UIKit

class AlertViewHelper{
    
    static let sharedInstance = AlertViewHelper()
    
    private init(){
    }
    
    func createGenericMessageWithOkButton(showOnVC : UIViewController, title: String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        showOnVC.present(alert, animated: true, completion: nil)
    }
    
    func createGenericMessage(showOnVC : UIViewController, title: String, message : String, buttons: [UIAlertAction]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for button in buttons{
            alert.addAction(button)
        }
        showOnVC.present(alert, animated: true, completion: nil)
    }
    
}
