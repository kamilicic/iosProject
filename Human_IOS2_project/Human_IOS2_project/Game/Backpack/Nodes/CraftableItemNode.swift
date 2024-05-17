//
//  CraftableItemNode.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 26.01.2024.
//

import SwiftUI
import SpriteKit

// Inside CraftableItemNode.swift

class CraftableItemNode: SKSpriteNode {
    var headingLabel: String
    var requiredItems: [ResearchRequirement]
    var craftArrow: SKSpriteNode
    var itemImage: SKSpriteNode 
    var mainNode: SKShapeNode
    var quantityToBeCrafted: Int
    var requiredResearch: String?
    var index: Int

    init(
        nameOfItemToBeCrafted: String,
        requiredItems: [ResearchRequirement],
        requiredResearch: String?,
        itemImageName: String,
        quantityOfCraftedItems: Int,
        index: Int
        
    ){
        self.headingLabel = nameOfItemToBeCrafted
        self.requiredItems = requiredItems
        self.itemImage = SKSpriteNode()
        self.quantityToBeCrafted = quantityOfCraftedItems
        self.mainNode = SKShapeNode() // Initialize to a default value
        self.craftArrow = SKSpriteNode(imageNamed: "arrowImage")
        self.requiredResearch = requiredResearch
        self.index = index
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        self.isUserInteractionEnabled = false
        self.zPosition = 2
        
        
        
        var rect = CGRect(x: -100, y: -60, width: 200, height: 70)

        // Check the value of headingLabel and update the height accordingly
        if headingLabel == "Boat" {
            rect.size.height = 110
            rect.origin.y = -100
        }
        // Create the main node with border, rounded corners, and fill color
        mainNode = SKShapeNode(
            rect: rect,
            cornerRadius: 10
        )
        
        
        mainNode.strokeColor = SKColor.black
        mainNode.zPosition = 3
        //mainNode.isUserInteractionEnabled = false
        mainNode.lineWidth = 2.0
        
        size = CGSize(width: mainNode.frame.width, height: mainNode.frame.height)
        
        self.addChild(mainNode)

        // Add text at the top of the node with the name of the research
        let nameLabel = SKLabelNode(text: headingLabel)
        nameLabel.fontSize = 14 // Adjust the font size as needed
        nameLabel.fontName = "Helvetica-Bold" // Set the font to bold
        nameLabel.position = CGPoint(x: 0, y: -10)
        nameLabel.zPosition = 3
        //nameLabel.isUserInteractionEnabled = false
        mainNode.addChild(nameLabel)

        
        // Add a grid of required items
        var yOffset: CGFloat = -25  // start slightly above the center
        for requirement in requiredItems {
            let imageLabel = SKSpriteNode(texture: requirement.itemTexture)
            let itemLabel = SKLabelNode(text: "\(requirement.itemName): \(requirement.quantity)")
            itemLabel.fontSize = 10 // Adjust the font size as needed
            itemLabel.fontName = "Helvetica-Bold" // Set the font to bold
            imageLabel.position = CGPoint(x: -70, y: yOffset + 5)
            //itemLabel.isUserInteractionEnabled = false
            
            if (requirement.itemName == "water bucket"){
                imageLabel.position = CGPoint(x: -75, y: yOffset + 5)
            }
            imageLabel.size = CGSize(width: 15, height: 15)
            itemLabel.position = CGPoint(x: -30, y: yOffset)
            yOffset -= 15
            mainNode.addChild(imageLabel)
            mainNode.addChild(itemLabel)
        }

        // Add an image of the researched item
        itemImage = SKSpriteNode(imageNamed: itemImageName)
        itemImage.position = CGPoint(x: 60, y: -30)  // adjust as needed
        itemImage.size = CGSize(width: 30, height: 30)
        //itemImage.isUserInteractionEnabled = true
        mainNode.addChild(itemImage)
        
    }
    /*
    func updateAppearance() {
        // Check if the research node has been researched
        self.isUserInteractionEnabled = false
    }
    */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

