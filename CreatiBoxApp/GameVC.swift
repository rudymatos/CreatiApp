//
//  GameVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/2/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var cardView1: UIImageView!
    @IBOutlet weak var cardView2: UIImageView!
    @IBOutlet weak var cardView3: UIImageView!
    @IBOutlet weak var goBackButton: UIButton!
    
    private let creatiBoxImpl = CreatiBoxAppImpl()
    private let alertViewHelper = AlertViewHelper.sharedInstance
    
    private var currentPrize : Prize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        currentPrize = getAppControl().currentPrize
        createCardFromView(view: cardView1)
        createCardFromView(view: cardView2)
        createCardFromView(view: cardView3)
        goBackButton.alpha = 0
        cardView1.alpha = 0
        cardView2.alpha = 0
        cardView3.alpha = 0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        cardView1.transform = CGAffineTransform(translationX: -200, y: 0)
        cardView2.transform = CGAffineTransform(translationX: -300, y: 0)
        cardView3.transform = CGAffineTransform(translationX: -400, y: 0)
        
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.cardView1.alpha = 1
            self.cardView1.transform = .identity
        }, completion:nil)
        
        UIView.animate(withDuration: 0.9, delay: 1.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.cardView2.alpha = 1
            self.cardView2.transform = .identity
        }, completion:nil)
        
        UIView.animate(withDuration: 0.9, delay: 2.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.cardView3.alpha = 3
            self.cardView3.transform = .identity
        }, completion:nil)
        
    }
    
    func createCardFromView(view: UIImageView){
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor  = UIColor.black.withAlphaComponent(0.5).cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        if creatiBoxImpl.doesVisitHaveAvailablePrizes(visit: getAppControl().currentVisit!){
            performSegue(withIdentifier: "promotionPersonVCSegue", sender: nil)
        }else{
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.logout()
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            })
            alertViewHelper.createGenericMessage(showOnVC: self, title: "Sin Premios", message: "La sucursal seleccionada no tiene mas premios para este dia. Favor comuniquese con su superisor", buttons: [okAction])
        }
    }
    
    @IBAction func revealPrize(_ sender: UITapGestureRecognizer) {
        if let currentView = sender.view{
            let imageView = currentView as! UIImageView
            UIView.transition(with: imageView, duration: 1, options: .transitionFlipFromRight, animations: {
                if let imageName = self.currentPrize?.type{
                    imageView.image = UIImage(named: imageName)
                    imageView.contentMode = .center
                }
            }, completion: {(completed) in
                
                self.cardView1.backgroundColor = self.cardView1.backgroundColor?.withAlphaComponent(0.8)
                self.cardView2.backgroundColor = self.cardView2.backgroundColor?.withAlphaComponent(0.8)
                self.cardView3.backgroundColor = self.cardView3.backgroundColor?.withAlphaComponent(0.8)
                
                self.cardView1.isUserInteractionEnabled = false
                self.cardView2.isUserInteractionEnabled = false
                self.cardView3.isUserInteractionEnabled = false
                
                UIView.animate(withDuration: 1, animations: {
                    self.goBackButton.alpha = 1
                })
            })
        }
    }
}
