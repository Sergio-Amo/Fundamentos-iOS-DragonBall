//
//  HeroDetailViewController.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 1/10/23.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    var hero: Hero
    private var transformations: [Transformation] = []
    
    init(hero: Hero) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var transformationsButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    // MARK: - Configure
    func configure(with hero: Hero) {
        title = hero.name
        descriptionLabel.text = hero.description
        avatarImageView.setImage(for: hero.photo)
        
        let model = NetworkModel()
        model.getTransformations(for: hero) { result in
            switch result {
            case let .success(transformations):
                DispatchQueue.main.async {
                    self.transformations = transformations
                    if transformations.isEmpty {
                        self.transformationsButton.isHidden = true
                    }
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with:hero)
    }
    @IBAction func transformationsTapped(_ sender: Any) {
        DispatchQueue.main.async {
            let transformationsTableViewController = TransformationsTableViewController(transformations: self.transformations)
            self.navigationController?.show(transformationsTableViewController, sender: nil)
        }
    }
}
