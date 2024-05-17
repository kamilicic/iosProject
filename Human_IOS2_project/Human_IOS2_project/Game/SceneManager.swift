//
//  SceneManager.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 20.12.2023.
//

import Foundation
import SpriteKit

class SceneManager {
    static var shared = SceneManager()

    private init() {}

    var currentScene: SKScene?

    func presentScene(_ scene: SKScene, in view: SKView) {
        currentScene = scene
        let transition = SKTransition.fade(withDuration: 0.5)
        view.presentScene(scene, transition: transition)
    }
}
