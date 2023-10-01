//
//  initialViewController.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 29/9/23.
//

import UIKit

class initialViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private let model = NetworkModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        model.login(
            user: userNameTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ) { [weak self] result in
            switch result {
            case .success(_):
                self?.model.getHeroes { result in
                    switch result {
                    case let .success(heroes):
                        DispatchQueue.main.async {
                            let tableViewController = CharacterListTableViewController(heroes: heroes)
                            self?.navigationController?.setViewControllers([tableViewController], animated: true)
                        }
                    case let .failure(error):
                        print("Error: \(error)")
                    }
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
