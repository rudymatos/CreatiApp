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
    
    private let creatiBoxImpl = CreatiBoxAppImpl()
    private let alertViewHelper = AlertViewHelper.sharedInstance
    private var isKeyboardBeingShown = false
    
    @IBOutlet weak var branchOfficeLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillHide(sender:Notification){
        print("hiding keyboard")
        isKeyboardBeingShown = false
        self.view.frame.origin.y += 270
    }
    
    func keyboardWillShow(sender: Notification){
        if !isKeyboardBeingShown{
            isKeyboardBeingShown = true
            UIView.animate(withDuration: 0.1, animations: {
                self.view.frame.origin.y -= 270
            })
        }
    }
    
    func configureView(){
        let dismissTap = UITapGestureRecognizer.init(target: self, action: #selector(PromontionPersonVC.dismissKeyboard))
        self.view.addGestureRecognizer(dismissTap)
        NotificationCenter.default.addObserver(self, selector: #selector(PromontionPersonVC.keyboardWillShow(sender:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PromontionPersonVC.keyboardWillHide(sender:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        branchOfficeLBL.text = getCurrentBranchOfficeText()
        if getAppControl().usingStockFromDifferrentBranchOffice{
            branchOfficeLBL.textColor = UIColor(red:0.17, green:0.49, blue:0.25, alpha:1.0)
        }
    }
    
    @IBAction func comeBackFromGameScreen(segue : UIStoryboardSegue){
        winnerName.text = ""
        winnerId.text = ""
        winnerPhone.text = ""
        winnerEmail.text = ""
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
        if winnerName.text?.trimmingCharacters(in: CharacterSet.whitespaces) != "" && winnerId.text?.trimmingCharacters(in: CharacterSet.whitespaces) != "", let name = winnerName.text, let id = winnerId.text{
            let winner = creatiBoxImpl.createWinner(name: name, id: id, email: winnerEmail.text, phone: winnerPhone.text, nif: nil)
            let prize = try! creatiBoxImpl.getRandomPrizeFromVisit(visit: getAppControl().currentVisit!)
            prize.redeemed = true
            prize.givenBy = getAppControl().currentUser
            prize.winner = winner
            if getAppControl().usingStockFromDifferrentBranchOffice{
                prize.givenAt = getAppControl().originalVisit?.branchOffice
            }else{
                prize.givenAt = getAppControl().currentVisit?.branchOffice
            }
            creatiBoxImpl.persistData()
            getAppControl().currentPrize = prize
            performSegue(withIdentifier: "gameVCSegue", sender: nil)
        }else{
            alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Campos Invalidos", message: "Jugador debe introducir al menos el nombre y la cedula para poder jugar")
        }
    }
    
}
