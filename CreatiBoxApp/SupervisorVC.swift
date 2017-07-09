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
    private let dateHelper = DateHelper.sharedInstance
    
    @IBOutlet weak var authorizedExtraStockButton: UIButton!
    @IBOutlet weak var branchOfficeLBL: UILabel!
    private let creatiBoxImpl = CreatiBoxAppImpl()
    private var currentVisit : Visit?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        branchOfficeLBL.text = getCurrentBranchOfficeText()
        if getAppControl().usingStockFromDifferrentBranchOffice{
            currentVisit = getAppControl().originalVisit
        }else{
            currentVisit = getAppControl().currentVisit
        }
        authorizedExtraStockButton.alpha = 0
        if (currentVisit?.prizes.allObjects as! [Prize]).filter({!$0.redeemed}).count == 0{
            authorizedExtraStockButton.alpha = 1
        }
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
        do{
            let nextVisit = try creatiBoxImpl.getVisit(bySupervisor: getAppControl().currentUser!, nextAvailableVisit: true)
            if nextVisit.authorized{
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Visita Autorizada", message: "La visita de manana ya fue autorizada previamente.")
            }else{
                let cancelButton = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
                let continueButton = UIAlertAction(title: "Continuar", style: .default, handler: { (action) in
                    nextVisit.authorized = true
                    self.creatiBoxImpl.persistData()
                })
                let branchOfficeName = "\(nextVisit.branchOffice.name) \(nextVisit.branchOffice.address)"
                let dateString = dateHelper.getSpanishReadeableDate(fromDate: nextVisit.date as Date)
                alertViewHelper.createGenericMessage(showOnVC: self, title: "Confirmacion", message: "Seguro que desea autorizar la visita del dia \(dateString)) a \(branchOfficeName)", buttons: [continueButton, cancelButton])
                
            }
        }catch CleanDataException.NoAvailableVisits{
            alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Sin Visitas", message: "No existe una proxima visita para autorizar")
        }catch let error as NSError{
            alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Error autorizando visita", message: "\(error). Favor contacte al administrador")
        }
    }
    
}
