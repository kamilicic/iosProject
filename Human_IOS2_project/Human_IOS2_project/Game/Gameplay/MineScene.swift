//
//  MineScene.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 10.01.2024.
//

import SpriteKit
import GameplayKit
import GameController

class MineScene: SKScene {
    var base: BaseNode!
    var previousScene: SKScene?
    private var closeInvBtn: ButtonNode!
    
    init(size: CGSize, previousScene: SKScene) {
            self.previousScene = previousScene
            super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        base = BaseNode()
        
        //Pridani physicsBody pro TileMap
        for node in self.children {
            if (node.name == "TileMapNode") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    base.giveTileMapPhysicsBody(map: someTileMap)
                    
                    someTileMap.removeFromParent()
                }
                break
            }
        }
    }
}
