//
//  ViewController.swift
//  19dz
//
//  Created by Пользователь on 3/27/20.
//  Copyright © 2020 Пользователь. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var currencyModel: CurrencyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.loadCurrency { result in
            switch result {
            case .success(let currencyModel):
                self.currencyModel = currencyModel
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currencyModel != nil {
            return 4
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        if let currencyModel = currencyModel {
            switch indexPath.row {
            case 1:
                cell!.textLabel?.text = "EUR -> USD \(currencyModel.rates.USD)"
            case 2:
                cell!.textLabel?.text = "EUR -> RUB \(currencyModel.rates.RUB)"
            case 3:
                cell!.textLabel?.text = "EUR -> BYN \(currencyModel.rates.BYN)"
            default:
                break
            }
        }
        return cell!
    }
    
    
}
