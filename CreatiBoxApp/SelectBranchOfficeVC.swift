//
//  SelectBranchOfficeVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class SelectBranchOfficeVC: UIViewController {
    private let alertViewHelper = AlertViewHelper.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToNextViewBasedOnProfile(_ sender: UIButton) {
        if getAppControl().currentBranchOffice != nil{
            if getAppControl().currentUser?.type == LoginUser.userType.supervisor.rawValue{
                performSegue(withIdentifier: "supervisorVCSegue", sender: nil)
            }else{
                performSegue(withIdentifier: "promotionPersonVCSegue", sender: nil)
            }
        }else{
            alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Sucursal Invalida", message: "Favor seleccionar una sucursal antes de proseguir")
        }
    }
    
    
    @IBAction func goBackToBranchOfficeSelection(segue: UIStoryboardSegue){
        
    }
    
    
    
}


extension SelectBranchOfficeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAppControl().branchOfficeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getAppControl().currentBranchOffice = getAppControl().branchOfficeList?[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentBranchOffice = getAppControl().branchOfficeList?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "branchOfficeCell", for: indexPath) as! BranchOfficeTVC
        cell.currentBranchOffice = currentBranchOffice
        return cell
    }
    
}
