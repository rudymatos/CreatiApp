//
//  ViewStockVC.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/4/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import UIKit

class ReportVC: UIViewController {
    
    @IBOutlet weak var viewTitle: UILabel!
    var reportType : ReportType?
    var currentBranchOffice : BranchOffice!
    fileprivate var prizeList : [Prize]?
    fileprivate let creatiBoxImpl = CreatiBoxAppImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        currentBranchOffice = getAppControl().currentBranchOffice
        if let reportType = reportType{
            switch reportType {
            case .stockReport:
                prizeList = try! creatiBoxImpl.getPrizes(forDate: Date(), byBranchOffice: getAppControl().currentBranchOffice!, forReport: true)
                viewTitle.text = "Inventario \(currentBranchOffice.name ?? "NA") \(currentBranchOffice.address ?? "NA")"
            case .scheduleReport:
                print("scheduleReport")
            case .authorizedExtraStock:
                print("authorizedExtraStock")
            }
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension ReportVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let reportType = reportType{
            switch reportType {
            case .stockReport:
                return prizeList!.count
            case .scheduleReport:
                print("scheduleReport")
            case .authorizedExtraStock:
                print("authorizedExtraStock")
            }
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
}
