//
//  ViewController.swift
//  SPHAssignment
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MobileDataUsageViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: MobileDataUsageViewModelInput!
    var activityIndicatorView: NVActivityIndicatorView?
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModelFactory.getViewModel(type: .modelDataUsage) as? MobileDataUsageViewModelInput
        setupUI()
        viewModel.doSomethingOnViewLoad()
    }
    
    // MARK: - Utility
    private func setupUI() {
        
        self.navigationItem.title = viewModel.getScreenTitle()
        viewModel.delegate = self
        let nibName = UINib(nibName: "MobileDataUsageHeaderView", bundle: nil)
        self.tableView.register(nibName, forHeaderFooterViewReuseIdentifier: "MobileDataUsageHeaderView")
    }
}

extension MobileDataUsageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfRow()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         var headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "MobileDataUsageHeaderView") as? MobileDataUsageHeaderView
         if headerView == nil{
             headerView = MobileDataUsageHeaderView(reuseIdentifier: "MobileDataUsageHeaderView")
        }
        headerView?.contentView.backgroundColor = .white
        return headerView ?? UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DataUsageTableViewCell") as? DataUsageTableViewCell ??
            DataUsageTableViewCell(style: .default, reuseIdentifier: "DataUsageTableViewCell")
        guard let record = viewModel.dataForRow(row: indexPath.row) else {
            return cell
        }
        //--- Configure the cell with data.
        cell.configureCell(record: record)
        cell.delegate = self
        return cell
    }
    
    //TO handle pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //
        //        if indexPath.row == (self.viewModel.getNumberOfRow()) - 1 {
        //            //--- Validate pagination.
        //            if self.viewModel.getNumberOfRow() <= self.viewModel.dataStoreData?.result.total ?? -1 {
        //                //--- Request 5 more records.
        //                fetchMobileDataUsageInfo(limit: ((self.viewModel.dataStoreData?.result.records.count ?? 0) + 5))
        //            }
        //        }
    }
}

extension MobileDataUsageViewController: MobileDataUsageViewModelDelegate {
    
    func showLoadingActivity() {
        if  activityIndicatorView == nil {
            activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.maxX/2-25, y: self.view.frame.maxY/2-25, width: 50, height: 50), type: NVActivityIndicatorView.DEFAULT_TYPE, color: UIColor.black, padding: 0)
        }
        self.view.addSubview(activityIndicatorView!)
        activityIndicatorView?.startAnimating()
    }
    func hideLoadingActivity() {
        self.activityIndicatorView?.stopAnimating()
        self.activityIndicatorView?.removeFromSuperview()
    }
    func showData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func showError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "SPH", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func reloadTableViewForIndexPath(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension MobileDataUsageViewController: DataUsageTableViewCellDelagate {
    func arrowImageClicked(cell: DataUsageTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel.changeImageStatus(indexPath: indexPath)
    }
}
