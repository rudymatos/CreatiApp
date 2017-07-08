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
    fileprivate var dataReportList : [DataReportDTO]?
    fileprivate let creatiBoxImpl = CreatiBoxAppImpl()
    fileprivate let dateHelper = DateHelper.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        if let reportType = reportType{
            switch reportType {
            case .stockReport:
                viewTitle.text = "Inventario de Articulos"
                dataReportList = generateScheduleReportDTOList(countStock: true)
            case .scheduleReport:
                viewTitle.text = "Agenda de Visitas"
                dataReportList = generateScheduleReportDTOList()
            case .winnersReport:
                print("authorizedExtraStock")
            }
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ReportVC{
    
    
    private func getGenericPrizeCounter() -> [(name: String, quantity: Int)]{
        var prizeCounter = [(name: String, quantity: Int)]()
        for prizeType in Prize.getAllPrizeTypes(){
            prizeCounter.append((name: prizeType.rawValue , quantity: 0))
            
        }
        return prizeCounter
    }
    
    func generateScheduleReportDTOList(countStock: Bool = false) -> [DataReportDTO]{
        var scheduleReportList = [DataReportDTO]()
        let visits = (getAppControl().currentUser?.visits.allObjects as! [Visit]).sorted { (visit1, visit2) -> Bool in
            let date1 = visit1.date as Date
            let date2 = visit2.date as Date
            return date1 < date2
        }
        for currentVisit in visits{
            var prizeCounter = getGenericPrizeCounter()
            for currentPrize in currentVisit.prizes.allObjects as! [Prize]{
                if let index = prizeCounter.index(where: {$0.name == currentPrize.type}){
                    if countStock{
                        if !currentPrize.redeemed{
                            prizeCounter[index].quantity += 1
                        }
                    }else{
                        prizeCounter[index].quantity += 1
                    }
                }
            }
            let spanishDate = dateHelper.getSpanishReadeableDate(fromDate: currentVisit.date as Date)
            let dataReport = DataReportDTO(branchOfficeName: currentVisit.branchOffice.name, branchOfficeAddress: currentVisit.branchOffice.address, branchOfficeImage: currentVisit.branchOffice.image, prizeCounter: prizeCounter, spanishDate: spanishDate)
            
            scheduleReportList.append(dataReport)
            
        }
        return scheduleReportList
    }
}


extension ReportVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        if let reportType = reportType{
            switch reportType {
            case .stockReport, .scheduleReport:
                counter = dataReportList?.count ?? 0
            case .winnersReport:
                print("authorizedExtraStock")
            }
        }
        return counter
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 80
        if let reportType = reportType{
            switch reportType {
            case .scheduleReport, .stockReport:
                height = 200
            case .winnersReport:
                print("authorizedExtraStock")
            }
        }
        return CGFloat(height)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let reportType = reportType{
            switch reportType {
            case .scheduleReport, .stockReport:
                let currentDataReport = dataReportList?[indexPath.row]
                let cell = (tableView.dequeueReusableCell(withIdentifier: "scheduleReportCell", for: indexPath) as! ScheduleReportTVC)
                cell.dataReport = currentDataReport
            case .winnersReport:
                print("authorizedExtraStock")
            }
        }
        
        return UITableViewCell()
    }
    
    
    
}
