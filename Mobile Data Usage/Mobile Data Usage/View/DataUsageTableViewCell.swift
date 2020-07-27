//
//  DataUsageTableViewCell.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import UIKit

protocol DataUsageTableViewCellDelagate: class {
    func arrowImageClicked(cell: DataUsageTableViewCell)
}

class DataUsageTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDataUsage: UILabel!
    
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var lblInfo: UILabel!
    
    @IBOutlet weak var btnImage: UIButton!
    
    weak var delegate: DataUsageTableViewCellDelagate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow()
    }

    func configureCell(record: YearlyDataUsage) {
        self.lblYear.text = record.name
        self.lblDataUsage.text = String(format: "%.2f", record.getValumeData())
        let decreaseInfo = record.decreaseVolumDataInfo()
        arrowImgView.isHidden =  decreaseInfo.0 == false
        btnImage.isHidden =  decreaseInfo.0 == false
        lblInfo.isHidden =  record.isInfoVisiable != true
        arrowImgView.isHighlighted = record.isInfoVisiable == true
        lblInfo.text = decreaseInfo.1
    }
    @IBAction func clickedOnImageView(_ sender: UIButton) {
        delegate?.arrowImageClicked(cell: self)
    }
}
