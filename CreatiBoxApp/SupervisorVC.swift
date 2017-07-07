//
//  SupervisorVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/3/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class SupervisorVC: UIViewController {

    private let alertViewHelper = AlertViewHelper.sharedInstance
    @IBOutlet weak var authorizedExtraStockButton: UIButton!
    @IBOutlet weak var branchOfficeLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    
    func configureView(){
        branchOfficeLBL.text = getCurrentBranchOfficeText()
        //if there is an authorizable stock show button
//        authorizedExtraStockButton.alpha = 0
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let yesAction = UIAlertAction(title: "Si", style: .default) { (action) in
            self.logout()
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertViewHelper.createGenericMessage(showOnVC: self, title: "Cerrar Sesion", message: "Seguro que desea cerrar sesion?", buttons: [yesAction, noAction])
    }
    
    @IBAction func generateStockReport(_ sender: UIButton) {
        performSegue(withIdentifier: "currentStockSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentStockSegue" {
            let reportVC = segue.destination as! ReportVC
            reportVC.reportType = ReportType.stockReport
        }
    }
    
    @IBAction func authorizeExtraStock(_ sender: UIButton) {
    }
   
}
