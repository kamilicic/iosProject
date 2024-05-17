//
//  ResearchScene.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 20.01.2024.
//

import SpriteKit
import GameplayKit

class ResearchScene: SKScene{
    private var panGesture: UIPanGestureRecognizer!
    init(size: CGSize, previousScene: SKScene) {
        self.previousScene = previousScene
        super.init(size: size)
        self.isUserInteractionEnabled = true
    }
    
    deinit{
        
    }
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
            //super.init(coder: aDecoder)
    }
    
    var previousScene: SKScene?
    private var closeInvBtn: ButtonNode!
    
    func closeInventoryButtonAction(_ sender: JKButtonNode) {
        returnToPreviousScene()
    }
    
    func returnToPreviousScene() {
            guard let previousScene = GameScene.previousScene else {
                // Handle the case where the previous scene is not set
                return
            }
        for researchNode in children where researchNode is ResearchNode {
            researchNode.removeFromParent()
        }
        cropNode.removeFromParent()
        willMove(from: view!)

            let transition = SKTransition.fade(withDuration: 0.5)
        view?.presentScene(previousScene, transition: transition)
        }
    
    private var inventoryButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    private var craftingButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    private var researchButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    
    var researchManager: ResearchManager = ResearchManager.shared
    var researchContainer: SKNode!
    var scrollableCropNode: SKCropNode!
    let visibleAreaWidth: CGFloat = 500
    
    private var isPanGestureAdded = false
    let availableResearches = ResearchManager.shared.availableResearches
    
    let cropNode = SKCropNode()
    let maskNode = SKSpriteNode(color: .white, size: CGSize(width: 500, height: 500))
    let scrollableContainer = SKNode()
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        var row = 0
        var column = 0
        let itemsPerRow = 4
        let itemSpacing: CGFloat = 15
        
        if !isPanGestureAdded {
                panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                view.addGestureRecognizer(panGesture)
                isPanGestureAdded = true
            }
        
        let background = BackpackBackgroundNode(textureName: Assets.Textures.Background.researchBG)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        closeInvBtn = ButtonNode(normalTexture: Assets.Textures.Buttons.closeInvBtn, highlightedTexture: Assets.Textures.Buttons.closeInvBtn, bgName: "closeButton")
        closeInvBtn.position = CGPoint(x: size.width * 0.927, y: size.height * 0.9)
        closeInvBtn.zPosition = Layer.button
        closeInvBtn.size = CGSize(width: size.width*0.05, height: size.height*0.1)
        closeInvBtn.action = closeInventoryButtonAction
        addChild(closeInvBtn)
        
        
        
        
        
        //Navigation
        
        
                inventoryButton.position = CGPoint(x: size.width * 0.665, y: size.height * 0.847)
                inventoryButton.zPosition = Layer.button
                inventoryButton.fillColor = .clear
                inventoryButton.strokeColor = .clear
                addChild(inventoryButton)

                // Add Crafting Button
                craftingButton.position = CGPoint(x: size.width * 0.365, y: size.height * 0.847)
                craftingButton.zPosition = Layer.button
                craftingButton.fillColor = .clear
                craftingButton.strokeColor = .clear
                addChild(craftingButton)
        
        cropNode.maskNode = maskNode
        cropNode.addChild(scrollableContainer)
        for (index, researchNode) in availableResearches.enumerated() {
            
            researchNode.position = CGPoint(
                x: CGFloat(column) * itemSpacing*12 + size.width / 6,
                y: size.height - CGFloat(row * 7) * itemSpacing - 150)
            researchNode.setScale(0.7)
//            researchNode.isUserInteractionEnabled = true
            researchNode.updateAppearance()
            addChild(researchNode)
            
            column += 1
            if column >= itemsPerRow {
                // Move to the next row
                row += 1
                column = 0
            }
        }
        //addChild(cropNode)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        for node in touchedNodes {
                if let researchNode = node as? ResearchNode {
                    handleResearchNodeTap(researchNode)
                } else if node == inventoryButton {
                    inventoryButtonAction()
                } else if node == craftingButton {
                    craftingButtonAction()
                } else if node == researchButton {
                    researchButtonAction()
                }
            }
    }
    
    
    
    func handleResearchNodeTap(_ researchNode: ResearchNode) {
        print("Tapped on research node: \(researchNode.researchName)")
        print(researchNode.requiredResearch)
                if !ResearchManager.shared.researchedResearches.contains(researchNode) {
                    if checkRequiredItems(researchNode) {
                        // If required items are available, move to researched researches
                        ResearchManager.shared.moveResearchToResearched(researchNode: researchNode)
                        updateAllResearchNodesAppearance()
                        print("Research \(researchNode.researchName) completed!")
                    } else {
                        print("Cannot research \(researchNode.researchName) because required items are missing.")
                    }
                }else {
                    return
                }
    }
    
    func checkRequiredItems(_ researchNode: ResearchNode) -> Bool {
        for requiredItem in researchNode.requiredItems {
            let itemIndex = requiredItem.index
            let itemQuantity = requiredItem.quantity

            // Check if the required quantity of the item is available in the inventory
            if GameScene.storedItems[itemIndex] < itemQuantity {
                return false
            }
        }
        // All required items are available in the inventory
        // Remove the required items from the inventory
        for requiredItem in researchNode.requiredItems {
            let itemIndex = requiredItem.index
            let itemQuantity = requiredItem.quantity
            GameScene.storedItems[itemIndex] -= itemQuantity
        }
        return true
    }
    
    private func updateAllResearchNodesAppearance() {
        for case let researchNode as ResearchNode in children {
            researchNode.updateAppearance()
        }
    }
    
    func inventoryButtonAction() {
            //print("Inventory button touched success")
        for researchNode in children where researchNode is ResearchNode {
            researchNode.removeFromParent()
        }
        cropNode.removeFromParent()
        willMove(from: view!)
            let backpackScene = BackpackScene(size: self.size, previousScene: self)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(backpackScene, transition: transition)
            
        }

        func craftingButtonAction() {
            //print("crafting button touched success")
            for researchNode in children where researchNode is ResearchNode {
                researchNode.removeFromParent()
            }
            cropNode.removeFromParent()
            willMove(from: view!)
            let craftingScene = CraftingScene(size: self.size, previousScene: previousScene!)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(craftingScene, transition: transition)
            
        }

        func researchButtonAction() {
            //print("research button touched success")
            for researchNode in children where researchNode is ResearchNode {
                researchNode.removeFromParent()
            }
            cropNode.removeFromParent()
            willMove(from: view!)
            let researchScene = ResearchScene(size: self.size, previousScene: previousScene!)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(researchScene, transition: transition)
        }
//Handling  scrolling inside of inv + removing of scrooll mechanic after scene deletion
    override func update(_ currentTime: TimeInterval) {
            super.update(currentTime)

        // Adjust alpha based on the position relative to the visible area
            for researchNode in children where researchNode is ResearchNode {
                let relativeY = researchNode.position.y
                let distanceFromCenter = abs(relativeY - size.height / 2)

                let maxVisibleAreaHeight = visibleAreaWidth / 4
                let alpha: CGFloat
                
                if relativeY >= size.height - 120 {
                    // Top half: Do not fade at the top
                    alpha = 0
                }else{
                            // Bottom half: Fade as it moves away
                    alpha = 1.0
                        }
                

                // Set alpha based on the position relative to the visible area
                researchNode.alpha = max(0, min(1, alpha))
            }


        }
    

    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        recognizer.cancelsTouchesInView = false
        let translation = recognizer.translation(in: self.view)
            
            // Adjust the scrolling speed as needed
            for researchNode in children where researchNode is ResearchNode {
                researchNode.position.y -= translation.y
            }
        //scrollableContainer.position.y -= translation.y
            
            // Reset the translation to avoid cumulative effect
            recognizer.setTranslation(.zero, in: self.view)
    }
    
    private func removePanGesture() {
        if let view = self.view, let gestureRecognizer = panGesture {
            view.removeGestureRecognizer(gestureRecognizer)
        }
        isPanGestureAdded = false
    }
    
    override func willMove(from view: SKView) {
        super.willMove(from: view)
        removePanGesture()
    }
    
    
    
    
    
    

    
    
    
    
    
}
