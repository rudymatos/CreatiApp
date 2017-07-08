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
    private let creatiBoxImpl = CreatiBoxAppImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    func configureView(){
        branchOfficeLBL.text = getCurrentBranchOfficeText()
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let yesAction = UIAlertAction(title: "Si", style: .default) { (action) in
            self.logout()
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertViewHelper.createGenericMessage(showOnVC: self, title: "Cerrar Sesion", message: "Seguro que desea cerrar sesion?", buttons: [yesAction, noAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reportType = ReportType(rawValue: segue.identifier!){
            let reportVC = segue.destination as! ReportVC
            reportVC.reportType = reportType
        }
    }
    
    @IBAction func authorizeExtraStock(_ sender: UIButton) {
        //FIX THIS CODE
        let nextVisit = try! creatiBoxImpl.getVisit(bySupervisor: getAppControl().currentUser!, nextAvailableVisit: true)
        nextVisit.authorized = true
        creatiBoxImpl.persistData()
    }
    
}
