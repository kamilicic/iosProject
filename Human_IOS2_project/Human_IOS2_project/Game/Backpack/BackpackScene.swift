//
//  BackpackScene.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 19.12.2023.
//

import SpriteKit
import GameplayKit

class BackpackScene: SKScene{
    private var column: CGFloat = 0
    private var row: CGFloat = 0
    
    let rectStroke: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    var handItem: ItemNode? = nil
    
    public static var chosenItem: ItemNode?
    public static var chosenPositionX: CGFloat?
    public static var chosenPositionY: CGFloat?
    
    private var change = false
    
    var previousScene: SKScene?
    private var closeInvBtn: ButtonNode!
    
    init(size: CGSize, previousScene: SKScene) {
        self.previousScene = previousScene
        super.init(size: size)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
            //super.init(coder: aDecoder)
    }
    
    func closeInventoryButtonAction(_ sender: JKButtonNode) {
        returnToPreviousScene()
    }
    
    func returnToPreviousScene() {
            guard let previousScene = GameScene.previousScene else {
                // Handle the case where the previous scene is not set
                return
            }

            let transition = SKTransition.fade(withDuration: 0.5)
        view?.presentScene(previousScene, transition: transition)
        }
    
    private var inventoryButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    private var craftingButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    private var researchButton: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 180, height: 38))
    
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
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        let background = BackpackBackgroundNode(
            textureName: Assets.Textures.Background.backpackBG
        )
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        closeInvBtn = ButtonNode(normalTexture: Assets.Textures.Buttons.closeInvBtn, highlightedTexture: Assets.Textures.Buttons.closeInvBtn, bgName: "closeButton")
        closeInvBtn.position = CGPoint(x: size.width * 0.927, y: size.height * 0.9)
        closeInvBtn.zPosition = Layer.button
        closeInvBtn.size = CGSize(width: size.width*0.05, height: size.height*0.1)
        closeInvBtn.action = closeInventoryButtonAction
        closeInvBtn.accessibilityIdentifier = "closeButton"
        closeInvBtn.isAccessibilityElement = true
        
        
        addChild(closeInvBtn)
        //Navigation
        
        /*
                inventoryButton.position = CGPoint(x: size.width * 0.665, y: size.height * 0.847)
                inventoryButton.zPosition = Layer.button
                inventoryButton.fillColor = .clear
                inventoryButton.strokeColor = .black
                addChild(inventoryButton)
*/
                // Add Crafting Button
                craftingButton.position = CGPoint(x: size.width * 0.365, y: size.height * 0.847)
                craftingButton.zPosition = Layer.button
                craftingButton.fillColor = .clear
                craftingButton.strokeColor = .clear
                addChild(craftingButton)

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
        
        rectStroke.strokeColor = .black
        rectStroke.fillColor = .clear
        
        /* Ide to enom kdyz sa neprida zadny item pred ten vybrany
        if(BackpackScene.chosenItem != nil){
            rectStroke.position.x = BackpackScene.chosenPositionX!
            rectStroke.position.y = BackpackScene.chosenPositionY!
            addChild(rectStroke)
        }*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        if let item = touchedNodes.first as? ItemNode {
            useItem(item: item)
        }else if touchedNodes.contains(inventoryButton) {
            // Handle touches on inventoryButton
            inventoryButtonAction()
        } else if touchedNodes.contains(craftingButton) {
            // Handle touches on craftingButton
            craftingButtonAction()
        } else if touchedNodes.contains(researchButton) {
            // Handle touches on researchButton
            researchButtonAction()
        } else {
            // Handle other touches or perform a default action if needed
        }
        change = true
    }
    
    func useItem(item: ItemNode){ // klika sa enom na obrazek ne na cislo(text)
        if(GameScene.storedItems[item.index] > 0){
            if(item.type == "food" || item.type == "placable" || item.type == "water" || item.type == "bucket" || item.type == "tool"){
                rectStroke.position.x = item.position.x - 19.5
                rectStroke.position.y = item.position.y - 24
                if (rectStroke.parent != nil){
                    rectStroke.removeFromParent()
                }
                //displayItemInHand(item: item)
                BackpackScene.chosenItem = item
                BackpackScene.chosenPositionX = rectStroke.position.x
                BackpackScene.chosenPositionY = rectStroke.position.y
                addChild(rectStroke)
            }
        }
        
    }
    /*
    func displayItemInHand(item: ItemNode){
        if handItem == nil{
            handItem = item
            handItem?.position = CGPoint(x: size.width*0.2, y: size.height*0.4)
            addChild(handItem!)
        } else {
            handItem?.removeFromParent()
            handItem = item
            handItem?.position = CGPoint(x: size.width*0.2, y: size.height*0.4)
            addChild(handItem!)
        }
        
    }
    */
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
            if (index == 6){
                itemToInventory.accessibilityIdentifier = "placable"
                itemToInventory.isAccessibilityElement = true
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
    
    func inventoryButtonAction() {
            print("Inventory button touched success")
            let backpackScene = BackpackScene(size: self.size, previousScene: self)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(backpackScene, transition: transition)
        }

        func craftingButtonAction() {
            print("crafting button touched success")
            let craftingScene = CraftingScene(size: self.size, previousScene: previousScene!)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(craftingScene, transition: transition)
        }

        func researchButtonAction() {
            print("research button touched success")
            let researchScene = ResearchScene(size: self.size, previousScene: previousScene!)
            let transition = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(researchScene, transition: transition)
        }
}
