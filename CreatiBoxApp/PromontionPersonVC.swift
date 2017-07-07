//
//  PromontionPersonVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class PromontionPersonVC: UIViewController {
    
    @IBOutlet weak var winnerName: UITextField!
    @IBOutlet weak var winnerId: UITextField!
    @IBOutlet weak var winnerPhone: UITextField!
    @IBOutlet weak var winnerEmail: UITextField!
    @IBOutlet weak var winnerNif: UITextField!
    private let creatiBoxImpl = CreatiBoxAppImpl()
    private let alertViewHelper = AlertViewHelper.sharedInstance
    @IBOutlet weak var branchOfficeLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        branchOfficeLBL.text = getCurrentBranchOfficeText()
    }
    
    @IBAction func comeBackFromGameScreen(segue : UIStoryboardSegue){
        winnerName.text = ""
        winnerId.text = ""
        winnerPhone.text = ""
        winnerEmail.text = ""
        winnerNif.text = ""
        getAppControl().currentPrize = nil
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let yesAction = UIAlertAction(title: "Si", style: .default) { (action) in
            self.logout()
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alertViewHelper.createGenericMessage(showOnVC: self, title: "Cerrar Sesion", message: "Seguro que desea cerrar sesion?", buttons: [yesAction, noAction])
    }
    
    @IBAction func play(_ sender: UIButton) {
        if winnerName.text != "", let name = winnerName.text{
            let winner = creatiBoxImpl.createWinner(name: name, id: winnerId.text, email: winnerEmail.text, phone: winnerPhone.text, nif: winnerNif.text)
            let prize = try! creatiBoxImpl.selectedRandomPrizeFromBranchOffice(branchOffice: getAppControl().currentBranchOffice!)
            prize.redeemed = true
            prize.givenBy = getAppControl().currentUser
            prize.winner = winner
            creatiBoxImpl.persistData()
            getAppControl().currentPrize = prize
            performSegue(withIdentifier: "gameVCSegue", sender: nil)
        }else{
            alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Campos Invalidos", message: "Jugador debe introducir al menos el nombre para poder jugar")
        }
    }
    
}
