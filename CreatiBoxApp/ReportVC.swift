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
    fileprivate var winnerReportList : [WinnerReportDTO]?
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
                viewTitle.text = "Lista de Ganadores"
                winnerReportList = generateWinnerReportDTOList()
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
    
    func generateWinnerReportDTOList() -> [WinnerReportDTO]{
        var winnerReportList = [WinnerReportDTO]()
        
        let notFound = "NO ENCONTRADO"
        
        let visits = getSortedVisits()
        for currentVisit in visits{
            for currentPrize in currentVisit.prizes.allObjects as! [Prize]{
                if currentPrize.redeemed {
                    let branchOfficeName = currentVisit.branchOffice.name
                    let branchOfficeAddress = currentVisit.branchOffice.address
                    let branchOfficeImage = currentVisit.branchOffice.image
                    let spanishDate = dateHelper.getSpanishReadeableDate(fromDate: currentVisit.date as Date)
                    let prizeName = currentPrize.name
                    let prizeImage = currentPrize.type
                    let winnerName = currentPrize.winner?.name ?? notFound
                    let winnerId = currentPrize.winner?.id ?? notFound
                    let winnerEmail = currentPrize.winner?.email ?? notFound
                    let winnerPhone = currentPrize.winner?.phone ?? notFound
                    var givenAt = notFound
                    if let givenBOName = currentPrize.givenAt?.name, let givenBOAddress = currentPrize.givenAt?.address{
                        givenAt = "\(givenBOName) \(givenBOAddress)"
                    }
                    let givenBy = currentPrize.givenBy?.displayName ?? "NO ENCONTRADO"
                    
                    let winnerDTO = WinnerReportDTO(branchOfficeName: branchOfficeName, branchOfficeAddress: branchOfficeAddress, branchOfficeImage: branchOfficeImage, spanishDate: spanishDate, prizeName: prizeName, prizeImage: prizeImage, winnerName: winnerName, winnerId: winnerId, winnerEmail: winnerEmail, winnerPhone: winnerPhone, givenBy: givenBy, givenAt: givenAt)
                    winnerReportList.append(winnerDTO)
                }
            }
        }
        return winnerReportList
    }
    
    private func getSortedVisits() -> [Visit]{
        let visits = (getAppControl().currentUser?.visits.allObjects as! [Visit]).sorted { (visit1, visit2) -> Bool in
            let date1 = visit1.date as Date
            let date2 = visit2.date as Date
            return date1 < date2
        }
        return visits
    }
    
    
    func generateScheduleReportDTOList(countStock: Bool = false) -> [DataReportDTO]{
        var scheduleReportList = [DataReportDTO]()
        let visits = getSortedVisits()
        
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
            let dataReport = DataReportDTO(branchOfficeName: currentVisit.branchOffice.name, branchOfficeAddress: currentVisit.branchOffice.address, branchOfficeImage: currentVisit.branchOffice.image, spanishDate: spanishDate, prizeCounter: prizeCounter)
            
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
                counter = winnerReportList?.count ?? 0
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
                height = 300
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
                let currentDataReport = winnerReportList?[indexPath.row]
                let cell = (tableView.dequeueReusableCell(withIdentifier: "winnerReportCell", for: indexPath) as! WinnersReportTVC)
                cell.winnerReportDTO = currentDataReport
            }
        }
        
        return UITableViewCell()
    }
    
    
    
}
