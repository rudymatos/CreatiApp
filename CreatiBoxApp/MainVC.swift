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
    private var currentUser : LoginUser?
    private let initDateHelper = InitialDataCreatorHelper.sharedInstance
    private var branchOfficeList : [BranchOffice]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initDateHelper.createPrizes()
    }
    
    
    @IBAction func logout(segue: UIStoryboardSegue){
    }
    
    @IBAction func login(_ sender: UIButton) {
        if let currentUsername = username.text, let currentPassword = password.text , currentUsername != "" && currentPassword != ""{
            do{
                currentUser = try creatiBoxImpl.login(username: currentUsername, password: currentPassword)
                if currentUser?.type == LoginUser.userType.supervisor.rawValue{
                    branchOfficeList = try creatiBoxImpl.getAllBranchOfficesByDate(date: Date(),authorized: false)
                }else{
                    branchOfficeList = try creatiBoxImpl.getAllBranchOfficesByDate(date: Date(),authorized: true)
                }
                performSegue(withIdentifier: "selectBranchOfficeSegue", sender: nil)
            }catch LoginExceptions.InvalidUsernameOrPassword(let message){
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Error Autenticando", message: message ?? "Usuario y Contrasena incorrectos")
            }catch CleanDataException.NoBranchOfficeFound{
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "No sucursales disponibles", message: "No existen surcursales con premios para entregar en el dia de hoy")
            }catch let error as NSError{
                alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Error Autenticando", message: error.description)
            }
        }else{
            alertViewHelper.createGenericMessageWithOkButton(showOnVC: self, title: "Error Autenticando", message: "Asegurese de que haya introducido el nombre de usuario y la contrasena")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectBranchOfficeSegue"{
            getAppControl().branchOfficeList = branchOfficeList
            getAppControl().currentUser = currentUser
        }
    }
    
    
}

