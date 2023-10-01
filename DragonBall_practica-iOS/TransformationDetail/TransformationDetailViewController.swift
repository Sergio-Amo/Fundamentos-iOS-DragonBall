//
//  TransformationDetailViewController.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 1/10/23.
//

import UIKit

class TransformationDetailViewController: UIViewController {
    
    var transformation: Transformation
    
    init(transformation: Transformation) {
        self.transformation = transformation
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    // MARK: - Configure
    func configure(with transformation: Transformation) {
        title = transformation.name
        descriptionLabel.text = transformation.description
        avatarImageView.setImage(for: transformation.photo)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with:transformation)
    }
}
