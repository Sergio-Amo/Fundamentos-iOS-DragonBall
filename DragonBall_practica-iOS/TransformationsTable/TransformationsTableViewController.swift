//
//  TransformationsTableViewController.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 1/10/23.
//

import UIKit

class TransformationsTableViewController: UITableViewController {
    
    var transformations: [Transformation]
    
    init(transformations: [Transformation]) {
        self.transformations = transformations
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transformaciones"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(
            UINib(nibName: "HeroesTableViewCell", bundle: nil),
            forCellReuseIdentifier: HeroesTableViewCell.identifier
        )
    }
}

// MARK: - Table view data source
extension TransformationsTableViewController {
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return transformations.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HeroesTableViewCell.identifier,
            for: indexPath
        ) as? HeroesTableViewCell else {
            return UITableViewCell()
        }
        //Set table height
        tableView.rowHeight = 128
        //Configure table contents
        let transformations = transformations[indexPath.row]
        cell.configure(with: transformations)
        // Accesory type
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
// MARK: - Delagate methods
extension TransformationsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TableSelect animation (instead of toggle)
        tableView.deselectRow(at: indexPath, animated: true)
        // Navigate to details
        let transformation = transformations[indexPath.row]
        let transformationDetailController = TransformationDetailViewController(transformation: transformation)
        navigationController?.show(transformationDetailController, sender: nil)
    }
}
