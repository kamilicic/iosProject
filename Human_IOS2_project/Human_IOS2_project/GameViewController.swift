//
//  GameViewController.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 18.12.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    var skView: SKView{
        view as! SKView
    }
    override func loadView() {
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //skView.showsPhysics = true
        
        skView.presentScene(
            StartingScene(
                size: CGSize(width: 852, height: 393)))
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        //for tests
        /*
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.showsPhysics = true
                }
            }
        }
        */
    }
}
