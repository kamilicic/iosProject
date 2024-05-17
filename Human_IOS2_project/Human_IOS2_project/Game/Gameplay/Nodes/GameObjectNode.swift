//
//  GameObjectNode.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 21.12.2023.
//

import SpriteKit

final class GameObjectNode: SKSpriteNode {
    var resourceAmount = 3
    init(texture: SKTexture, name: String){
        super.init(texture: texture, color: .clear, size: texture.size())
        zPosition = Layer.gameObject

        let rectangle = SKSpriteNode()
        
        self.name = name
        if (name == "tree"){
            rectangle.size = CGSize(width: size.width * 0.4, height: size.height)
        } else/* if (name == "stone")*/{
            rectangle.size = CGSize(width: size.width, height: size.height)
        }
        
        physicsBody = SKPhysicsBody(rectangleOf: rectangle.size)
        
        physicsBody?.categoryBitMask = Physics.CategoryBitMask.gameObject
        physicsBody?.contactTestBitMask = Physics.ContactTestBitMask.gameObject
        
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func giveResource(name: String, randomizer: Int) -> Int {
        var whatResource: Int = 0
        switch name {
        case "tree":
            switch randomizer {
            case 5...7:
                whatResource = 2
            case 8...10:
                whatResource = 4
            default:
                whatResource = 0
            }
        case "stone":
            switch randomizer {
            case 7...9:
                whatResource = 3
            case 10:
                whatResource = 9 //je to sice blbost, ale dava to bucket with water
            default:
                whatResource = 1
            }
        case "bed":
            switch randomizer {
            case 5...10:
                whatResource = 5
            default:
                whatResource = 0
            }
        case "sapling":
            resourceAmount = 1
            whatResource = 6
        case "mine", "betterMine":
            switch randomizer {
            case 7...9:
                whatResource = 3
            default:
                whatResource = 1
            }
        case "waterPick":
            whatResource = 9
        default:
            break
        }
        resourceAmount -= 1
        return whatResource
    }
}
