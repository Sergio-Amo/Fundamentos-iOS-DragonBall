//
//  HeroesTableViewCell.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 1/10/23.
//

import UIKit

class HeroesTableViewCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = "HeroesTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    // MARK: - Configure
    func configure(with hero: Hero) {
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description
        avatarImageView.setImage(for: hero.photo)
    }
    func configure(with transformation: Transformation) {
        nameLabel.text = transformation.name
        descriptionLabel.text = transformation.description
        avatarImageView.setImage(for: transformation.photo)
    }
}
