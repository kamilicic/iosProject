//
//  ResearchNode.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 20.01.2024.
//

import SpriteKit

class ResearchNode: SKSpriteNode {
    var researchName: String
    var requiredResearch: String?
    var itemImageName: String?// Name of the required research
    var mainNode: SKShapeNode

    var itemImage: SKSpriteNode // Initialize to a default value

    var requiredItems: [ResearchRequirement]

    init(
        researchName: String,
        requiredResearch: String?,
        requiredItems: [ResearchRequirement],
        itemImageName: String
        
    ){
        self.researchName = researchName
        self.requiredResearch = requiredResearch
        self.requiredItems = requiredItems
        self.itemImage = SKSpriteNode()
        self.mainNode = SKShapeNode() // Initialize to a default value
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        self.isUserInteractionEnabled = false
        self.zPosition = 2
        
        
        

        // Create the main node with border, rounded corners, and fill color
        mainNode = SKShapeNode(
            rect: CGRect(
                x: -100, // half of the width
                y: -60,  // half of the height
                width: 200,
                height: 120
            ),
            cornerRadius: 10
        )
        mainNode.strokeColor = SKColor.black
        mainNode.zPosition = 3
        //mainNode.isUserInteractionEnabled = true
        mainNode.lineWidth = 2.0
        
        size = CGSize(width: mainNode.frame.width, height: mainNode.frame.height)
        
        self.addChild(mainNode)

        // Add text at the top of the node with the name of the research
        let nameLabel = SKLabelNode(text: researchName)
        nameLabel.fontSize = 14 // Adjust the font size as needed
        nameLabel.fontName = "Helvetica-Bold" // Set the font to bold
        nameLabel.position = CGPoint(x: 0, y: mainNode.frame.size.height / 2 - 20)
        nameLabel.zPosition = 3
        mainNode.addChild(nameLabel)

        
        // Add a grid of required items
        var yOffset: CGFloat = 20  // start slightly above the center
        for requirement in requiredItems {
            let imageLabel = SKSpriteNode(texture: requirement.itemTexture)
            let itemLabel = SKLabelNode(text: "\(requirement.itemName): \(requirement.quantity)")
            itemLabel.fontSize = 10 // Adjust the font size as needed
            itemLabel.fontName = "Helvetica-Bold" // Set the font to bold
            imageLabel.position = CGPoint(x: -32, y: yOffset + 5)
            if (requirement.itemName == "water bucket"){
                imageLabel.position = CGPoint(x: -50, y: yOffset + 5)
            }
            imageLabel.size = CGSize(width: 15, height: 15)
            itemLabel.position = CGPoint(x: 0, y: yOffset)
            yOffset -= 15
            mainNode.addChild(imageLabel)
            mainNode.addChild(itemLabel)
        }

        // Add an image of the researched item
        itemImage = SKSpriteNode(imageNamed: itemImageName)
        itemImage.position = CGPoint(x: 0, y: -30)  // adjust as needed
        itemImage.size = CGSize(width: 40, height: 40)
        mainNode.addChild(itemImage)
        
    }
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
        
        mainNode.touchesBegan(touches, with: event)
        
            print("touch")
            // Handle the tap on the researchNode
            if let touch = touches.first {
                let location = touch.location(in: self)
                if mainNode.contains(location) {
                    print("Tapped on research node: \(researchName)")
                    // You can perform additional actions as needed
                }
            }
        }
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAppearance() {
        // Check if the research node has been researched
        if ResearchManager.shared.researchedResearches.contains(where: { $0 === self }) {
            // If the research node is researched, apply a green tint
            setColor(color: .green, blendFactor: 0.7)
            self.isUserInteractionEnabled = true // Disable interaction for completed research
        } else {
            // If the research node is not researched
            if let requiredResearch = requiredResearch,
                !ResearchManager.shared.researchedResearches.contains(where: { $0.researchName == requiredResearch }) {
                // If the required research is not yet researched, gray out the research node
                setColor(color: .gray, blendFactor: 0.5)
                self.isUserInteractionEnabled = true // Disable interaction for incomplete research
            } else {
                // If the required research is researched or there is no required research, reset the appearance
                setColor(color: .clear, blendFactor: 0.0)
                self.isUserInteractionEnabled = false // Enable interaction for available research
            }
        }
    }
        
        private func setColor(color: UIColor, blendFactor: CGFloat) {
            let colorWithOpacity = color.withAlphaComponent(blendFactor)
            mainNode.fillColor = colorWithOpacity
        }
}






