//
//  CraftingScene.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 20.01.2024.
//

import SpriteKit
import GameplayKit

class CraftingScene: SKScene{
    private var column: CGFloat = 0
    private var row: CGFloat = 0
    private var panGesture: UIPanGestureRecognizer!
    
    init(size: CGSize, previousScene: SKScene) {
        self.previousScene = previousScene
        super.init(size: size)
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
        for craftingNode in children where craftingNode is CraftableItemNode {
            craftingNode.removeFromParent()
        }
        cropNode.removeFromParent()
        willMove(from: view!)

            let transition = SKTransition.fade(withDuration: 0.5)
        view?.presentScene(previousScene, transition: transition)
        }
    
    private var inventoryButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    private var craftingButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    private var researchButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    private var isPanGestureAdded = false
    var scrollableCropNode: SKCropNode!
    let visibleAreaWidth: CGFloat = 1000
    let textures = [
        SKTexture(imageNamed: Assets.Textures.Materials.woodLog),
        SKTexture(imageNamed: Assets.Textures.Materials.stone),
        SKTexture(imageNamed: Assets.Textures.Materials.leaf),
        SKTexture(imageNamed: Assets.Textures.Materials.metal),
        SKTexture(imageNamed: Assets.Textures.Materials.coconut),
        SKTexture(imageNamed: Assets.Textures.Materials.woodPlank),
        SKTexture(imageNamed: Assets.Textures.Materials.sapling),
        SKTexture(imageNamed: Assets.Textures.ResACraft.bed),
        SKTexture(imageNamed: Assets.Textures.Materials.bucket),
        SKTexture(imageNamed: Assets.Textures.Materials.bucketWithWater),
    SKTexture(imageNamed: Assets.Textures.Tools.woodPickaxe),
    SKTexture(imageNamed: Assets.Textures.Tools.woodAxe),
    SKTexture(imageNamed: Assets.Textures.Tools.woodShovel),
    SKTexture(imageNamed: Assets.Textures.Tools.stonePickaxe),
    SKTexture(imageNamed: Assets.Textures.Tools.stoneAxe),
    SKTexture(imageNamed: Assets.Textures.Tools.stoneShovel),
    SKTexture(imageNamed: Assets.Textures.Tools.ironPickaxe),
    SKTexture(imageNamed: Assets.Textures.Tools.ironAxe),
    SKTexture(imageNamed: Assets.Textures.Tools.ironShovel),
        SKTexture(imageNamed: Assets.Textures.ResACraft.mineResearch),
        SKTexture(imageNamed: Assets.Textures.ResACraft.boatResearch),
        SKTexture(imageNamed: Assets.Textures.Materials.nail),
        SKTexture(imageNamed: Assets.Textures.ResACraft.mine),
    ]
    
    let names = ["wood","stone","leaf","metal","coconut","woodPlank","sapling","bed","bucket","water bucket", "woodPickaxe","woodAxe","woodShovel","stonePickaxe","stoneAxe","stoneShovel","ironPickaxe","ironAxe","ironShovel","betterMine", "boat", "nail", "mine"]
    
    let cropNode = SKCropNode()
    let maskNode = SKSpriteNode(color: .white, size: CGSize(width: 500, height: 500))
    
    
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        if !isPanGestureAdded {
                panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                view.addGestureRecognizer(panGesture)
                isPanGestureAdded = true
            }
        let craftingRecipes = CraftingManager.shared.availableCraftingRecipes
        let background = BackpackBackgroundNode(textureName: Assets.Textures.Background.craftingBG)
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
/*
                // Add Crafting Button
                craftingButton.position = CGPoint(x: size.width * 0.365, y: size.height * 0.847)
                craftingButton.zPosition = Layer.button
                craftingButton.fillColor = .clear
                craftingButton.strokeColor = .black
                addChild(craftingButton)
*/
                // Add Research Button
                researchButton.position = CGPoint(x: size.width * 0.08, y: size.height * 0.847)
                researchButton.zPosition = Layer.button
                researchButton.fillColor = .clear
                researchButton.strokeColor = .clear
                addChild(researchButton)

                // Highlight the currently displayed view (Inventory by default)
                //inventoryButton.isHighlighted = true
        
        for index in 0...(GameScene.storedItems.count - 1) {
            
            
            
            if(GameScene.storedItems[index] > 0){
                addItemToInventory(item: ItemNode(texture: textures[index], name: names[index], index: index), amount: GameScene.storedItems[index], index: index)
                column += 1
            }
        }
        cropNode.maskNode = maskNode
        let scrollableContainer = SKNode()
        cropNode.addChild(scrollableContainer)
        
        
        for (index, craftingNode) in craftingRecipes.enumerated() {
            craftingNode.position = CGPoint(x: size.width * 0.185, y: size.height / 1.36 - CGFloat(index) * 90) // Adjust the positioning based on your needs
            //craftingNode.updateAppearance()
            addChild(craftingNode)
        }
        //addChild(cropNode)
    }
    
    func craftItem(craftingNode: CraftableItemNode){
        if checkRequiredItems(craftingNode) {
                // Craft the item and update inventory
            addItemToInventory(
                itemQuantity: craftingNode.quantityToBeCrafted,
                itemIndex: craftingNode.index
            )
                updateInventory()
            }
    }
    
    func checkRequiredItems(_ craftingNode: CraftableItemNode) -> Bool {
        for requiredItem in craftingNode.requiredItems {
            let itemIndex = requiredItem.index
            let itemQuantity = requiredItem.quantity
            

            // Check if the required quantity of the item is available in the inventory
            if GameScene.storedItems[itemIndex] < itemQuantity {
                return false
            }
        }
        // All required items are available in the inventory
        // Remove the required items from the inventory
        for requiredItem in craftingNode.requiredItems {
            
            let itemIndex = requiredItem.index
            let itemQuantity = requiredItem.quantity
            GameScene.storedItems[itemIndex] -= itemQuantity
        }
        return true
    }
    
    func addItemToInventory(itemQuantity: Int ,itemIndex: Int) {
        GameScene.storedItems[itemIndex] += itemQuantity
    }

    func updateInventory() {
        // Call the method to update your inventory UI or perform any other necessary updates
        // ...
        row = 0
        column = 0
        for itemNode in children where itemNode is ItemNode {
            itemNode.removeFromParent()
        }
        for amountTextNode in children where amountTextNode is SKLabelNode {
                amountTextNode.removeFromParent()
            }
        for index in 0...(GameScene.storedItems.count - 1) {
            
            
            
            if(GameScene.storedItems[index] > 0){
                addItemToInventory(item: ItemNode(texture: textures[index], name: names[index], index: index), amount: GameScene.storedItems[index], index: index)
                column += 1
            }
        }
    }
    //Displaying Nodes
    func displayCraftingRecipes() {
            let craftingRecipes = CraftingManager.shared.availableCraftingRecipes

            for (index, craftingNode) in craftingRecipes.enumerated() {
                craftingNode.position = CGPoint(x: size.width * 0.2, y: size.height * 0.8 - CGFloat(index) * 150) // Adjust the positioning based on your needs
                addChild(craftingNode)
            }
        }
    
    func addItemToInventory(item: ItemNode, amount: Int, index: Int) {
        if(row != 6){
            if(column == 11){
            row += 1
            column = 0
            }
            let itemToInventory = item
            switch index{
            case 4:
                itemToInventory.type = "food"
            case 6, 7, 19, 20, 22:
                itemToInventory.type = "placable"
            case 9:
                itemToInventory.type = "water"
            case 8:
                itemToInventory.type = "bucket"
            case 10...18:
                itemToInventory.type = "tool"
            default:
                break
            }
            itemToInventory.position.x = size.width * 0.349 + (itemToInventory.size.width * 1.32 * CGFloat(column))
            itemToInventory.position.y = size.height * 0.755 - (itemToInventory.size.height * 1.85 * CGFloat(row))
            addChild(itemToInventory)
            
            let amountText = SKLabelNode(text: String(amount))
            amountText.position.x = size.width * 0.349 + (itemToInventory.size.width * 1.32 * CGFloat(column))
            amountText.position.y = size.height * 0.695 - (itemToInventory.size.height * 1.85 * CGFloat(row))
            amountText.fontSize = 12
            amountText.zPosition = itemToInventory.zPosition + 1
            amountText.fontName = "AvenirNext-Bold"
            addChild(amountText)
        }
    }
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        if let item = touchedNodes.first as? ItemNode {
            //useItem(item: item)
        }else if touchedNodes.contains(inventoryButton) {
            // Handle touches on inventoryButton
            inventoryButtonAction()
        } else if touchedNodes.contains(craftingButton) {
            // Handle touches on craftingButton
            craftingButtonAction()
        } else if touchedNodes.contains(researchButton) {
            // Handle touches on researchButton
            researchButtonAction()
        } else if ((touchedNodes.first as? CraftableItemNode) != nil){
            // Handle other touches or perform a default action if needed
        }else{
            
        }
        //change = true
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        for node in touchedNodes {
                if let craftingNode = node as? CraftableItemNode {
                    print("Touched crafting node")
                    craftItem(craftingNode: craftingNode)
                } else if node == inventoryButton {
                    inventoryButtonAction()
                } else if node == craftingButton {
                    craftingButtonAction()
                } else if node == researchButton {
                    researchButtonAction()
                }
            }
    }
    
    func inventoryButtonAction() {
            //print("Inventory button touched success")
        for craftingNode in children where craftingNode is CraftableItemNode {
            craftingNode.removeFromParent()
        }
        cropNode.removeFromParent()
        willMove(from: view!)
            let backpackScene = BackpackScene(size: self.size, previousScene: self)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(backpackScene, transition: transition)
            
        }

        func craftingButtonAction() {
            //print("crafting button touched success")
            for craftingNode in children where craftingNode is CraftableItemNode {
                craftingNode.removeFromParent()
            }
            cropNode.removeFromParent()
            willMove(from: view!)
            let craftingScene = CraftingScene(size: self.size, previousScene: previousScene!)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(craftingScene, transition: transition)
            
        }

        func researchButtonAction() {
            //print("research button touched success")
            for craftingNode in children where craftingNode is CraftableItemNode {
                craftingNode.removeFromParent()
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
                for craftableItemNode in children where craftableItemNode is CraftableItemNode {
                    let relativeY = craftableItemNode.position.y
                    let alpha: CGFloat
                    if relativeY >= size.height - 80 {
                                // Top half: Do not fade at the top
                                alpha = 0
                            } else {
                                // Bottom half: Fade as it moves away
                                alpha = 1.0
                            }

                    // Set alpha based on the position relative to the visible area
                    craftableItemNode.alpha = max(0, min(1, alpha))
                }


            }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        recognizer.cancelsTouchesInView = false
        let translation = recognizer.translation(in: self.view)
            
            // Adjust the scrolling speed as needed
            for researchNode in children where researchNode is CraftableItemNode {
                researchNode.position.y -= translation.y
            }
        //cropNode.position.y -= translation.y
            
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
