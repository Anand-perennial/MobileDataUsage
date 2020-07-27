//
//  ViewController.swift
//  Mobile Data Usage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import UIKit

class MobileDataUsageViewController: UIViewController {

    // MARK: - Outlets

    // MARK: - Properties
    var viewModel: MobileDataUsageViewModelInput!

    // MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModelFactory.getViewModel(type: .modelDataUsage) as? MobileDataUsageViewModelInput
        viewModel.doSomethingOnViewLoad()
    }


}

