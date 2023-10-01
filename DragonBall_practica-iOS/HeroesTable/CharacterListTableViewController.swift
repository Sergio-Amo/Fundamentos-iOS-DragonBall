//
//  CharacterListTableViewController.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 29/9/23.
//

import UIKit

final class CharacterListTableViewController: UITableViewController {
        
    var heroes: [Hero]
    
    init(heroes: [Hero]) {
        self.heroes = heroes
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personajes"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(
            UINib(nibName: "HeroesTableViewCell", bundle: nil),
            forCellReuseIdentifier: HeroesTableViewCell.identifier
        )
    }
}

// MARK: - DataSource
extension CharacterListTableViewController {
        
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        heroes.count
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
        let hero = heroes[indexPath.row]
        cell.configure(with: hero)
        // Accesory type
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - Delagate methods
extension CharacterListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TableSelect animation (instead of toggle)
        tableView.deselectRow(at: indexPath, animated: true)
        // Navigate to details
        let hero = heroes[indexPath.row]
        let heroDetailController = HeroDetailViewController(hero: hero)
        navigationController?.show(heroDetailController, sender: nil)
    }
}
