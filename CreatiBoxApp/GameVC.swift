//
//  GameVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/2/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var activateThanksAnimationBTN: UIButton!
    @IBOutlet weak var cardView1: UIImageView!
    @IBOutlet weak var cardView2: UIImageView!
    @IBOutlet weak var cardView3: UIImageView!
    @IBOutlet weak var backgroundRectangle: UIView!
    @IBOutlet weak var thanksForPlayingLBL: UILabel!
    @IBOutlet weak var cardsStackView: UIStackView!
    
    private let creatiBoxImpl = CreatiBoxAppImpl()
    private let alertViewHelper = AlertViewHelper.sharedInstance
    
    private var currentPrize : Prize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        activateThanksAnimationBTN.isHidden = true
        thanksForPlayingLBL.alpha = 0
        currentPrize = getAppControl().currentPrize
        createCardFromView(view: backgroundRectangle)
        cardView1.alpha = 0
        cardView2.alpha = 0
        cardView3.alpha = 0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        cardView1.isUserInteractionEnabled = false
        cardView2.isUserInteractionEnabled = false
        cardView3.isUserInteractionEnabled = false
        
        cardView1.transform = CGAffineTransform(translationX: -200, y: 0)
        cardView2.transform = CGAffineTransform(translationX: -300, y: 0)
        cardView3.transform = CGAffineTransform(translationX: -400, y: 0)
        
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.cardView1.alpha = 1
            self.cardView1.transform = .identity
        }, completion:nil)
        
        UIView.animate(withDuration: 0.9, delay: 0.5, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.cardView2.alpha = 1
            self.cardView2.transform = .identity
        }, completion:nil)
        
        UIView.animate(withDuration: 0.9, delay: 0.8, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.cardView3.alpha = 1
            self.cardView3.transform = .identity
        }, completion:{(success) in
            self.cardView1.isUserInteractionEnabled = true
            self.cardView2.isUserInteractionEnabled = true
            self.cardView3.isUserInteractionEnabled = true
        })
        
    }
    
    func createCardFromView(view: UIView){
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.6
        view.layer.shadowOffset = CGSize.zero
        view.layer.masksToBounds = false
    }
    
    @IBAction func goBack(_ sender: UITapGestureRecognizer) {
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
    @IBAction func activateThanksAnimation(_ sender: UIButton) {
        self.activateThanksAnimationBTN.isHidden = true
        self.thanksForPlayingLBL.isUserInteractionEnabled = false
        UIView.animate(withDuration: 5, animations: {
            self.cardsStackView.alpha = 0
        }, completion: { (complete) in
            self.thanksForPlayingLBL.transform = CGAffineTransform(translationX: 0, y: 200)
            UIView.animate(withDuration: 1, animations: {
                self.thanksForPlayingLBL.transform = CGAffineTransform.identity
                self.thanksForPlayingLBL.alpha = 1
            }, completion:{(success) in
                self.thanksForPlayingLBL.isUserInteractionEnabled = true
            })
        })
        
    }
    
    @IBAction func revealPrize(_ sender: UITapGestureRecognizer) {
        if let currentView = sender.view{
            let imageView = currentView as! UIImageView
            self.cardView1.isUserInteractionEnabled = false
            self.cardView2.isUserInteractionEnabled = false
            self.cardView3.isUserInteractionEnabled = false
            self.activateThanksAnimationBTN.isHidden = false
            
            UIView.transition(with: imageView, duration: 1, options: .transitionFlipFromRight, animations: {
                if let imageName = self.currentPrize?.type{
                    imageView.image = UIImage(named: "winner_\(imageName)")
                }
            }, completion: nil)
        }
    }
}
