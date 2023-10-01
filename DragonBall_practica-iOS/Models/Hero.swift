//
//  Hero.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 30/9/23.
//

import Foundation

struct Hero: Decodable, Equatable {
    let id: String,
        name: String,
        description: String,
        photo: URL,
        favorite: Bool
}
