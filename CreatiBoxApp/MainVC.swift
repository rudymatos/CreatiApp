//
//  ViewController.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 6/28/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private let creatiBoxImpl = CreatiBoxAppImpl()
    private let alertViewHelper = AlertViewHelper.sharedInstance
    private let initDateHelper = InitialDataCreatorHelper.sharedInstance
    private let dateHelper = DateHelper.sharedInstance
    private let coreDataHelper = CoreDataHelper.sharedInstance
    private var isKeyboardBeingShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if getAppControl().isFirstLaunch(){
            initDateHelper.createInitialData()
        }
        configureView()
    }
    
    func configureView(){
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(MainVC.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardTap)
        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.keyboardWillShow(sender:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.keyboardWillHide(sender:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillHide(sender: Notification){
        isKeyboardBeingShown = false
        self.view.frame.origin.y += 100
        
    }
    
    func keyboardWillShow(sender: Notification){
        if !isKeyboardBeingShown{
            isKeyboardBeingShown = true
            UIView.animate(withDuration: 0.1, animations: {
                self.view.frame.origin.y -= 100
            })
        }
    }
    
    @IBAction func logout(segue: UIStoryboardSegue){
        username.text = ""
        password.text = ""
    }
    
    
    private func restock(supervisor: LoginUser){
        print("restocking")
        do{
            let todaysVisit = try creatiBoxImpl.getVisit(forDate: Date(), bySupervisor: supervisor)
            if !todaysVisit.restoked{
                let redeemedPrizes = (todaysVisit.prizes.allObjects as! [Prize]).filter({$0.redeemed}).map({$0.type})
                let currentDateString = dateHelper.getDateString(fromDate: Date())
                var prizeTypeList: [Prize.PrizeType] = []
                for currentRedeemedPrize in redeemedPrizes{
                    print("following prize should be restoked : \(currentRedeemedPrize)")
                    if let currentPrizeType = Prize.PrizeType(rawValue: currentRedeemedPrize){
                        prizeTypeList.append(currentPrizeType)
                    }
                }
                initDateHelper.regenerateStockForDays(username: supervisor.username, date: currentDateString, restockItems: prizeTypeList)
            }
            todaysVisit.restoked = true
            creatiBoxImpl.persistData()
        }catch{
            print("No hay visitas para llenar el inventario")
        }
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        var visit : Visit!
        if let currentUsername = username.text, let currentPassword = password.text , currentUsername != "" && currentPassword != ""{
            do{
                let currentUser = try creatiBoxImpl.login(username: currentUsername, password: currentPassword)
                let userType = LoginUser.UserType(rawValue: currentUser.type)!
                getAppControl().currentUser = currentUser
                restock(supervisor: userType.isSupervisor() ? currentUser : currentUser.supervisor!)
                if userType.isSupervisor() {
                    do{
                        visit = try creatiBoxImpl.getVisit(bySupervisor: userType.isSupervisor() ? currentUser : currentUser.supervisor!)
                        getAppControl().currentVisit = visit
                        performSegue(withIdentifier: "supervisorSegue", sender: nil)
                    }catch CleanDataException.NoAvailableVisits{
                        let access = UIAlertAction(title: "Acceder", style: .default, handler: { (action) in
                            self.performSegue(withIdentifier: "supervisorSegue", sender: nil)
                        })
                        let dismiss = UIAlertAction(title: "No gracias", style: .default, handler:nil)
                        alertViewHelper.createGenericMessage(showOnVC: self, title: "Visita no Disponible", message: "No existen visitas disponibles para el dia de hoy. Desea acceder al sistema de todas formas?", buttons: [access, dismiss])
                    }
                }else{
                    visit = try creatiBoxImpl.getVisit(bySupervisor: userType.isSupervisor() ? currentUser : currentUser.supervisor!)
                    if creatiBoxImpl.doesVisitHaveAvailablePrizes(visit: visit){
                        print("using original visit")
                        getAppControl().currentVisit = visit
                        performSegue(withIdentifier: "promotionPersonSegue", sender: nil)
                    }else{
                        print("using next visit")
                        let nextVisit = try creatiBoxImpl.getVisit(bySupervisor: currentUser.supervisor!, nextAvailableVisit: true)
                        
                        if !nextVisit.authorized{
                            throw CleanDataException.NoAuthorizedVisits
                        }
                        
                        if creatiBoxImpl.doesVisitHaveAvailablePrizes(visit: nextVisit){
                            getAppControl().usingStockFromDifferrentBranchOffice = true
                            getAppControl().originalVisit = visit
                            getAppControl().currentVisit = nextVisit
                            performSegue(withIdentifier: "promotionPersonSegue", sender: nil)
                        }else{
                            throw CleanDataException.NoPrizeFound
                        }
                        
                    }
                }
                
            }catch CleanDataException.NoAuthorizedVisits{
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Sucursales no disponibles", message: "No existen visitas a surcursales/premios en el dia de hoy ni futuras visitas autorizadas.")
            }catch CleanDataException.NoPrizeFound{
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Premios no disponibles", message: "No existen visitas a surcursales en el dia de hoy ni manana.")
            }catch LoginExceptions.InvalidUsernameOrPassword(let message){
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Error Autenticando", message: message ?? "Usuario y Contrasena incorrectos")
            }catch CleanDataException.NoAvailableVisits{
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Sucursales no disponibles", message: "No existen visitas a surcursales en el dia de hoy.")
            }catch let error as NSError{
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Error Autenticando", message: error.description)
            }
        }else{
            alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Error Autenticando", message: "Asegurese de que haya introducido el nombre de usuario y la contrasena")
        }
    }
    
}

