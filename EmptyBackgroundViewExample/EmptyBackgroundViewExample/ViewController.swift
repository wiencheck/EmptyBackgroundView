//
//  ViewController.swift
//  EmptyBackgroundViewExample
//
//  Created by Adam Wienconek on 23/11/2022.
//

import UIKit
import EmptyBackgroundView

class ViewController: UITableViewController {
        
    var numberOfItems = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(systemName: "network")?
            .applyingSymbolConfiguration(.init(pointSize: 34))
        tableView.emptyViewConfiguration = .init(primaryText: "No data",
                                                 secondaryText: "Check your internet connection",
                                                 image: image)
    }

    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        if numberOfItems == 0 {
            numberOfItems = 20
        }
        else {
            numberOfItems = 0
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration: UIListContentConfiguration = .cell()
        configuration.text = "Row: \(indexPath.row)"
        
        cell.contentConfiguration = configuration
        
        return cell
    }
    
}
