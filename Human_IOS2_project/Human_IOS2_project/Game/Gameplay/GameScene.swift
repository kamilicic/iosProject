//
//  GameScene.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 18.12.2023.
//

import SpriteKit
import SwiftUI
import GameplayKit
import GameController
import AVFoundation

class GameScene: SKScene {
    
    
    deinit {
        foodTimer?.invalidate()
        waterTimer?.invalidate()
        energyTimer?.invalidate()
    }

    private var destroySound: SKAction!
    private var hitSound: SKAction!
    private var deathSound: SKAction!
    private var hurray: SKAction!
    
    
    private var foodDecreaseInterval: TimeInterval = 120.0
    private var waterDecreaseInterval: TimeInterval = 80.0
    //private var energyIncreaseInterval: TimeInterval = 5
    private var foodTimer: Timer?
    private var waterTimer: Timer?
    private var energyTimer: Timer?
    static var previousScene: GameScene?
    private var player: PlayerNode!
    
    private var gameObject: GameObjectNode? = nil
    
    public static var storedItems: [Int] = []
    
    private var playerHP: CGFloat = 150
    private var playerHPPosition: CGFloat = 100
    private var playerHunger: CGFloat = 150
    private var playerHungerPosition: CGFloat = 100
    private var playerThirst: CGFloat = 150
    private var playerThirstPosition: CGFloat = 100
    private var playerEnergy: CGFloat = 150
    private var playerEnergyPosition: CGFloat = 100
    
    private var healthStat: StatsNode!
    private var hungerStat: StatsNode!
    private var thirstStat: StatsNode!
    private var energyStat: StatsNode!
    private var rectangleStat: SKSpriteNode!
    
    var placeBoat = false
    var whereToPlace: String!
    var boatPlaced = false
    var finish = false
    
    private var cam: SKCameraNode!
    private var base: BaseNode!
    
    var virtualController: GCVirtualController?
    
    private var contact: SKPhysicsContact?
    
    private var playerPosx : CGFloat = 0.0
    
    private var playerPosxHelp: CGFloat!
    private var lookingRight: Bool = true
    
    private var attackBtn: ButtonNode!
    private var interactBtn: ButtonNode!
    private var openInvBtn: ButtonNode!
    
    var itemCountLabel: SKLabelNode!
    var selectedItemSprite: SKSpriteNode!
    
    
    

    // Inside your GameScene's didMove(to view:) method or equivalent
    func createItemCountLabel() {
        itemCountLabel = SKLabelNode(fontNamed: "Chalkduster")
        itemCountLabel.fontSize = 20
        itemCountLabel.fontColor = SKColor.white
        itemCountLabel.position = CGPoint(x: interactBtn.position.x - 30, y: interactBtn.position.y - 60)
        addChild(itemCountLabel)
    }
    
    func attackButtonAction(_ sender: JKButtonNode){
            if (lookingRight) {
                let textureAtlasRightPunch = SKTextureAtlas(named: Assets.Textures.Player.playerPunchRight)
                let texturesRightPunch = textureAtlasRightPunch.textureNames.sorted().map{
                    textureAtlasRightPunch.textureNamed($0)
                }
                player.texture = texturesRightPunch.first
                player.run(
                    .animate(with: texturesRightPunch, timePerFrame: 0.1, resize: false, restore: true)
                )
            } else {
                let textureAtlasLeftPunch = SKTextureAtlas(named: Assets.Textures.Player.playerPunchLeft)
                let texturesLeftPunch = textureAtlasLeftPunch.textureNames.sorted().map{
                    textureAtlasLeftPunch.textureNamed($0)
                }
                player.texture = texturesLeftPunch.first
                player.run(
                    .animate(with: texturesLeftPunch, timePerFrame: 0.1, resize: false, restore: true)
                )
            }
            
            
            
        updateObject()
        if (gameObject != nil){
            run(hitSound)
            if (gameObject?.name != "waterPickLeft" && gameObject?.name != "waterPickRight"){
                let storingItem = gameObject?.giveResource(name: gameObject?.name ?? "tree", randomizer: Int.random(in: 1...10))
                let itemNames = ["wood","stone","leaf","metal","coconut","wood plank","sapling", "bed", "mine", "water bucket"]
                var numberOfItemsAdded: Int = 1
                
                
                let storingItemLabel = SKLabelNode(text:("+" + String(numberOfItemsAdded) + " " + itemNames[storingItem ?? 0]))
                storingItemLabel.position.x = gameObject?.position.x ?? 150
                storingItemLabel.position.y = (gameObject?.position.y ?? 150) + 120 - (CGFloat(gameObject?.resourceAmount ?? 0) * 20)
                if(gameObject?.name == "mine" || gameObject?.name == "betterMine"){
                    storingItemLabel.position.y = (gameObject?.position.y ?? 150) + 250 - (CGFloat(gameObject?.resourceAmount ?? 0) * 20)
                }
                
                storingItemLabel.fontSize = 20
                storingItemLabel.fontColor = .black
                storingItemLabel.zPosition = Layer.score
                storingItemLabel.fontName = "AvenirNext-Bold"
                
                let animateLabel = SKAction.sequence([SKAction.fadeIn(withDuration: 0.5), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()])
                
                
                
                
                if BackpackScene.chosenItem?.type == "tool"{

                    switch BackpackScene.chosenItem?.name{
                        
                    case "woodAxe":
                        if gameObject?.name == "tree"{
                            numberOfItemsAdded = 2
                            
                            player.storeItem(item: storingItem ?? 0)
                        }
                    case "woodPickaxe":
                        if gameObject?.name == "mine" || gameObject?.name == "betterMine"{
                            numberOfItemsAdded = 2
                            
                            player.storeItem(item: storingItem ?? 0)
                        }
                    case "stoneAxe":
                        if gameObject?.name == "tree"{
                            numberOfItemsAdded = 3
                            
                            player.storeItem(item: storingItem ?? 0)
                            player.storeItem(item: storingItem ?? 0)
                        }
                    case "stonePickaxe":
                        if gameObject?.name == "mine" || gameObject?.name == "betterMine"{
                            numberOfItemsAdded = 3
                            
                            player.storeItem(item: storingItem ?? 0)
                            player.storeItem(item: storingItem ?? 0)
                        }
                    case "ironAxe":
                        if gameObject?.name == "tree"{
                            numberOfItemsAdded = 4
                            
                            player.storeItem(item: storingItem ?? 0)
                            player.storeItem(item: storingItem ?? 0)
                            player.storeItem(item: storingItem ?? 0)
                        }
                    case "ironPickaxe":
                        if gameObject?.name == "mine" || gameObject?.name == "betterMine"{
                            numberOfItemsAdded = 4
                            
                            player.storeItem(item: storingItem ?? 0)
                            player.storeItem(item: storingItem ?? 0)
                            player.storeItem(item: storingItem ?? 0)
                        }
                        
                    default:
                        break
                    }
                }
                if gameObject?.name == "betterMine"{
                    numberOfItemsAdded += 1
                    player.storeItem(item: storingItem ?? 0)
                }
                storingItemLabel.text = ("+" + String(numberOfItemsAdded) + " " + itemNames[storingItem ?? 0])
                storingItemLabel.run(animateLabel)
                addChild(storingItemLabel)
                
                player.storeItem(item: storingItem ?? 0)
                
                if (gameObject?.resourceAmount == 0){
                    if (gameObject?.name == "tree") {
                        run(destroySound)
                        
                        //pridat sapling, ale randomizovat, aby to dalo nekdy vic
                        player.storedItems[6] += Int.random(in: 1...2)
                        
                        
                        let storingItemLabelSapling = SKLabelNode(text:("+1 " + itemNames[6]))
                        storingItemLabelSapling.position.x = gameObject?.position.x ?? 150
                        storingItemLabelSapling.position.y = (gameObject?.position.y ?? 150) + 140
                        storingItemLabelSapling.fontSize = 20
                        storingItemLabelSapling.fontColor = .black
                        storingItemLabelSapling.zPosition = Layer.score
                        storingItemLabelSapling.fontName = "AvenirNext-Bold"
                        
                        let animateLabelSapling = SKAction.sequence([SKAction.fadeIn(withDuration: 0.5), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()])
                        
                        storingItemLabelSapling.run(animateLabelSapling)
                        addChild(storingItemLabelSapling)
                        
                    }
                gameObject?.removeFromParent()
                gameObject = nil
                }
                
                //Vymyslet jak se budou staty ubirat
                energyStat.statMinus(howMuch: 1)
                var randomer = Int.random(in: 0...10)
                if (energyStat.rectangle.size.width == 0){
                    randomer = 7
                }
                
                if (randomer == 7){
                    hungerStat.statMinus(howMuch: 1)
                }
                
                if (randomer == 6 || randomer == 7){
                    thirstStat.statMinus(howMuch: 1)
                }
                
                if ((thirstStat.rectangle.size.width == 0 && energyStat.rectangle.size.width == 0) || (hungerStat.rectangle.size.width == 0 && energyStat.rectangle.size.width == 0)){
                    healthStat.statMinus(howMuch: 1)
                    if (healthStat.rectangle.size.width == 0){
                        run(deathSound)
                        BackpackScene.chosenItem = nil
                        self.removeAllChildren()
                        virtualController?.disconnect()
                        GameScene.storedItems = []
                        ResearchManager.shared.researchedResearches = []
                        CraftingManager.shared.resetRecepies()
                        
                        let gameOverScene = GameOverScene(size: self.size)
                        let transition = SKTransition.fade(withDuration: 0.5)
                        self.view?.presentScene(gameOverScene, transition: transition)
                    }
                }
            }
        }
    }
    
    func openInventoryButtonAction(_ sender: JKButtonNode) {
        attackBtn.removeFromParent()
        openInvBtn.removeFromParent()
        interactBtn.removeFromParent()
        
        playerHP = healthStat.rectangle.size.width
        playerHPPosition = healthStat.rectangle.position.x
        playerHunger = hungerStat.rectangle.size.width
        playerHungerPosition = hungerStat.rectangle.position.x
        playerThirst = thirstStat.rectangle.size.width
        playerThirstPosition = thirstStat.rectangle.position.x
        playerEnergy = energyStat.rectangle.size.width
        playerEnergyPosition = energyStat.rectangle.position.x
        
        healthStat.removeFromParent()
        hungerStat.removeFromParent()
        thirstStat.removeFromParent()
        energyStat.removeFromParent()
        rectangleStat.removeFromParent()
        if(itemCountLabel != nil){
            itemCountLabel.removeFromParent()
            selectedItemSprite.removeFromParent()
        }

        
        GameScene.storedItems = player.storedItems
        
        player.removeFromParent()
        GameScene.previousScene = self
        virtualController?.disconnect()
        let backpackScene = BackpackScene(size: self.size, previousScene: self)
        let transition = SKTransition.fade(withDuration: 0.5)
        self.view?.presentScene(backpackScene, transition: transition)
    }
    
    //Item to polozi uplne v pohode, ale aby mezi tym itemem a playerem byl kontakt, I KDYZ MI TO PISE, ZE TAM KONTAKT JE, musi se rozbit gameObjekt(strom) a pak tepvr placenout, pak to funguje, jak ma.
    //NECHAPEM!!!
    func interactButtonAction(_ sender: JKButtonNode){
        if (lookingRight) {
            let textureAtlasRightPunch = SKTextureAtlas(named: Assets.Textures.Player.playerPunchRight)
            let texturesRightPunch = textureAtlasRightPunch.textureNames.sorted().map{
                textureAtlasRightPunch.textureNamed($0)
            }
            player.texture = texturesRightPunch.first
            player.run(
                .animate(with: texturesRightPunch, timePerFrame: 0.1, resize: false, restore: true)
            )
        } else {
            let textureAtlasLeftPunch = SKTextureAtlas(named: Assets.Textures.Player.playerPunchLeft)
            let texturesLeftPunch = textureAtlasLeftPunch.textureNames.sorted().map{
                textureAtlasLeftPunch.textureNamed($0)
            }
            player.texture = texturesLeftPunch.first
            player.run(
                .animate(with: texturesLeftPunch, timePerFrame: 0.1, resize: false, restore: true)
            )
        }
        
        updateObject()
        
        let animateLabel = SKAction.sequence([SKAction.fadeIn(withDuration: 0.5), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()])
        
        
        if (gameObject == nil) {
            if (BackpackScene.chosenItem != nil){
                let usingItemLabel = SKLabelNode()
                
                usingItemLabel.position.x = player.position.x
                usingItemLabel.position.y = player.position.y + 45
                
                usingItemLabel.fontSize = 20
                usingItemLabel.fontColor = .black
                usingItemLabel.zPosition = Layer.score
                usingItemLabel.fontName = "AvenirNext-Bold"
                
                usingItemLabel.text = ("-1 " + (BackpackScene.chosenItem?.name ?? "wood"))
                
                switch BackpackScene.chosenItem!.type{
                case "placable":
                    let item = GameObjectNode(texture: (BackpackScene.chosenItem!.texture)!, name: BackpackScene.chosenItem!.name!)
                        item.position.x = player.position.x
                        item.position.y = -size.height * 0.32
                    if(item.name == "mine"){
                        item.resourceAmount = 10
                        placingItemLabelShoving(usingItemLabel: usingItemLabel, animateLabel: animateLabel, item: item)
                        addChild(item)
                    }
                    else if (item.name == "boat"){
                        print("cannot be placed here")
                    }
                    else if (item.name == "betterMine"){
                        item.resourceAmount = 10
                        item.position.y = -size.height * 0.2
                        placingItemLabelShoving(usingItemLabel: usingItemLabel, animateLabel: animateLabel, item: item)
                        addChild(item)
                    }
                    else if item.name == "sapling" {
                        // Handle sapling item
                        item.position.x = player.position.x
                        item.position.y = -size.height * 0.37
                        addChild(item)
                            
                        item.anchorPoint = CGPoint(x: 0.5, y: 0.0)
                        // Animation logic for sapling growth
                        let growAnimation = SKAction.sequence([
                            SKAction.scaleY(to: 5, duration: 10.0),
                            SKAction.run { [weak self] in
                                // Remove sapling and spawn a fully grown tree
                                item.removeFromParent()
                                let fullyGrownTree = GameObjectNode(texture: SKTexture(imageNamed: Assets.Textures.GameObjects.tree2), name: "tree")
                                fullyGrownTree.position = CGPoint(x: item.position.x, y: item.position.y / 2.3)
                                fullyGrownTree.resourceAmount = 3
                                            self?.addChild(fullyGrownTree)
                            }
                        ])
                        item.run(growAnimation)
                        placingItemLabelShoving(usingItemLabel: usingItemLabel, animateLabel: animateLabel, item: item)
                    } else {
                        addChild(item)
                        placingItemLabelShoving(usingItemLabel: usingItemLabel, animateLabel: animateLabel, item: item)
                    }
                case "food":
                    //ty staty to nekdy, kdyz je to skoro plne, nedoplnuje, ale nekdy jo, takze nevim, co s tym je
                    if(hungerStat.rectangle.size.width != 150) {
                        usingItemLabel.run(animateLabel)
                        addChild(usingItemLabel)
                        thirstStat.statPlus(howMuch: 1)
                        hungerStat.statPlus(howMuch: 2)
                        if (healthStat.rectangle.size.width != 150){
                            healthStat.statPlus(howMuch: 2)
                            
                        }
                        
                        player.storedItems[BackpackScene.chosenItem!.index] -= 1
                        itemCountLabel.text = String( player.storedItems[BackpackScene.chosenItem!.index])
                        if(player.storedItems[BackpackScene.chosenItem!.index] == 0){
                            BackpackScene.chosenItem = nil
                            itemCountLabel.removeFromParent()
                            selectedItemSprite.removeFromParent()
                        }
                    }
                case "water":
                    //ty staty to nekdy, kdyz je to skoro plne, nedoplnuje, ale nekdy jo, takze nevim, co s tym je
                    if(thirstStat.rectangle.size.width != 150) {
                        usingItemLabel.run(animateLabel)
                        addChild(usingItemLabel)
                        
                        thirstStat.statPlus(howMuch: 3)
                        if (healthStat.rectangle.size.width != 150){
                            healthStat.statPlus(howMuch: 1)
                        }
                        player.storedItems[BackpackScene.chosenItem!.index] -= 1
                        itemCountLabel.text = String( player.storedItems[BackpackScene.chosenItem!.index])
                        if(player.storedItems[BackpackScene.chosenItem!.index] == 0){
                            BackpackScene.chosenItem = nil
                            itemCountLabel.removeFromParent()
                            selectedItemSprite.removeFromParent()
                        }
                    }
                default:
                    break
                }
            }
        } else {
            let usingItemLabel = SKLabelNode()
            
            usingItemLabel.position.x = player.position.x
            usingItemLabel.position.y = player.position.y + 45
            
            usingItemLabel.fontSize = 20
            usingItemLabel.fontColor = .black
            usingItemLabel.zPosition = Layer.score
            usingItemLabel.fontName = "AvenirNext-Bold"
            
            usingItemLabel.text = ("-1 " + (BackpackScene.chosenItem?.name ?? "wood"))
            if (gameObject?.name == "bed"){
                energyStat.restoreStat()
            }else
            if (gameObject?.name == "waterPickLeft" || gameObject?.name == "waterPickRight"){
                
                if BackpackScene.chosenItem?.name == "boat"{
                    let boat = GameObjectNode(texture: SKTexture(imageNamed: Assets.Textures.ResACraft.boatResearch), name: "Boat")
                    boat.position.y = -size.height * 0.275
                    let placement = gameObject?.name
                    if (placement == "waterPickLeft"){
                        boat.position.x = -size.width * 0.15
                    } else if (placement == "waterPickRight"){
                        boat.position.x = size.width * 2.25
                    }
                    addChild(boat)
                    finish = true
                }else if BackpackScene.chosenItem?.name == "bucket"{
                    player.storeItem(item: gameObject?.giveResource(name: "waterPick", randomizer: 0) ?? 9)
                    player.storedItems[BackpackScene.chosenItem!.index] -= 1
                    itemCountLabel.text = String( player.storedItems[BackpackScene.chosenItem!.index])
                    if(player.storedItems[BackpackScene.chosenItem!.index] == 0){
                        BackpackScene.chosenItem = nil
                        itemCountLabel.removeFromParent()
                        selectedItemSprite.removeFromParent()
                    }
                    
                    usingItemLabel.run(animateLabel)
                    addChild(usingItemLabel)
                    
                    let storingItemLabel = SKLabelNode(text:("+1 water bucket"))
                    storingItemLabel.position.x = usingItemLabel.position.x
                    storingItemLabel.position.y = usingItemLabel.position.y + 20
                    
                    storingItemLabel.fontSize = 20
                    storingItemLabel.fontColor = .black
                    storingItemLabel.zPosition = Layer.score
                    storingItemLabel.fontName = "AvenirNext-Bold"
                    
                    let animateLabel = SKAction.sequence([SKAction.fadeIn(withDuration: 0.5), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()])
                    
                    storingItemLabel.run(animateLabel)
                    
                    addChild(storingItemLabel)
                }
            }
            if (finish){
                BackpackScene.chosenItem = nil
                virtualController?.disconnect()
                GameScene.storedItems = []
                ResearchManager.shared.researchedResearches = []
                CraftingManager.shared.resetRecepies()
                
                let animationTexture = SKTexture(imageNamed: Assets.Textures.Background.finalAnimation1)
                let animatedBg = SKSpriteNode(texture: animationTexture, size: size)
                
                animatedBg.zPosition = 10000
                animatedBg.position.x = player.position.x
                animatedBg.position.y = 0
                
                self.removeAllChildren()
                let animatedBgAnimations =
                SKAction.sequence(
                    [SKAction.fadeIn(withDuration: 0.2),
                     SKAction.wait(forDuration: 3),
                     SKAction.fadeOut(withDuration: 0.2),
                     SKAction.customAction(withDuration: 0.3, actionBlock: {_,_ in
                            animatedBg.texture = SKTexture(imageNamed: Assets.Textures.Background.finalAnimation2)
                            }),
                     SKAction.fadeIn(withDuration: 0.2),
                     SKAction.wait(forDuration: 3),
                     SKAction.customAction(withDuration: 0.02, actionBlock: { [self]_,_ in
                         run(hurray)
                     }),
                     SKAction.customAction(withDuration: 1, actionBlock: {_,_ in
                         let finalScene = FinalScene(size: self.size)
                         let transition = SKTransition.fade(withDuration: 0.5)
                         self.view?.presentScene(finalScene, transition: transition)})])
                    
                    animatedBg.run(animatedBgAnimations)
                    addChild(animatedBg)
            }
            self.contact = nil
        }
    }
    
    func placingItemLabelShoving(usingItemLabel: SKLabelNode, animateLabel: SKAction, item: GameObjectNode){
        usingItemLabel.text = ("-1 " + (item.name ?? "wood"))
        
        usingItemLabel.run(animateLabel)
        addChild(usingItemLabel)
        player.storedItems[BackpackScene.chosenItem!.index] -= 1
        itemCountLabel.text = String(player.storedItems[BackpackScene.chosenItem!.index])
        if(player.storedItems[BackpackScene.chosenItem!.index] == 0){
            BackpackScene.chosenItem = nil
            itemCountLabel.removeFromParent()
            selectedItemSprite.removeFromParent()
        }
    }
    
    
    func updateObject(){
        gameObject = contact?.bodyA.node as? GameObjectNode
        if gameObject == nil{
            gameObject = contact?.bodyB.node as? GameObjectNode
        }
    }
    
    
    override func didMove(to view: SKView) {
        if let chosenItem = BackpackScene.chosenItem {
            // Call handleSelectedItemChange to initialize the display
            let itemCountIndex = chosenItem.index
            let chosenItemCount = player.storedItems[itemCountIndex]
            updateSelectedItemDisplay(itemImage: chosenItem.texture, itemCount: chosenItemCount)
        }
        startFoodTimer()
        startWaterTimer()
        super.didMove(to: view)
        physicsWorld.contactDelegate = self
        
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
        
        //Sound setup
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSession setup error \(error)")
        }
        hitSound = SKAction.playSoundFileNamed(
            Assets.Sounds.treeHit,
            waitForCompletion: true
        )
        destroySound = SKAction.playSoundFileNamed(
            Assets.Sounds.treeDestroy,
            waitForCompletion: true
        )
        deathSound = SKAction.playSoundFileNamed(
            Assets.Sounds.death,
            waitForCompletion: true
        )
        hurray = SKAction.playSoundFileNamed(
            Assets.Sounds.hurray,
            waitForCompletion: true
        )
        
        //Controls
        attackBtn = ButtonNode(normalTexture: Assets.Textures.Buttons.attackBtnNormal, highlightedTexture: Assets.Textures.Buttons.attackBtnActive, bgName: "attackButton")
        attackBtn.position = CGPoint(x: 0, y: -110)
        attackBtn.accessibilityIdentifier = "attackButton"
        attackBtn.isAccessibilityElement = true
        //attackBtn.normalSound = Assets.Sounds.treeHit
        //attackBtn.canPlaySounds = true
        
        interactBtn = ButtonNode(normalTexture: Assets.Textures.Buttons.interactBtnNormal, highlightedTexture: Assets.Textures.Buttons.interactBtnActive, bgName: "interactButton")
        interactBtn.position = CGPoint(x: 0, y: -125)
        interactBtn.accessibilityIdentifier = "interactButton"
        interactBtn.isAccessibilityElement = true
        
        openInvBtn = ButtonNode(normalTexture: Assets.Textures.Buttons.invBtnNormal, highlightedTexture: Assets.Textures.Buttons.invBtnActive, bgName: "openInventoryButton")
        openInvBtn.position = CGPoint(x: 0, y: -70)
        openInvBtn.accessibilityIdentifier = "openInventoryButton"
        openInvBtn.isAccessibilityElement = true
        
        //connect actions
        attackBtn.action = attackButtonAction
        openInvBtn.action = openInventoryButtonAction
        interactBtn.action = interactButtonAction
        
        //Add nodes to scene
        addChild(attackBtn)
        addChild(openInvBtn)
        addChild(interactBtn)
        
        if (playerPosxHelp != nil) {
            player.position.x = playerPosxHelp
            player = PlayerNode(xpos: playerPosxHelp, lRight: lookingRight)
        } else {
            player = PlayerNode(xpos: playerPosx, lRight: lookingRight)
        }
        if(GameScene.storedItems != []){
            player.uploadStore(store: GameScene.storedItems)
        }
        
        spawnGameObjects(texture: SKTexture(imageNamed: Assets.Textures.GameObjects.tree2), name: "tree")
        
        //Stats
        setStats()
        
        //Camera node init
        cam = SKCameraNode()
        cam.zPosition = 10
        
        cam.position = CGPoint(x: player.position.x, y: player.position.y + player.size.height * 1.3)
        
        addChild(base)
        addChild(player)
        addChild(cam)
        
        //Pripojeni Camera node na cameru, kterou pouziva primo ve hre  , takze tedka se pohybuje postava i s kamerou
        camera = cam
        
        //Priopojeni controlleru na ovladani postavicky
        virtualController = connectVirtualController()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Check for controller input
        if let leftThumbstick = virtualController?.controller?.extendedGamepad?.leftThumbstick {
            playerPosx = CGFloat(leftThumbstick.xAxis.value)

            if playerPosx >= 0.2 {
                //Zmena textury postavicky
                let textureAtlasRight = SKTextureAtlas(named: Assets.Textures.Player.playerRunRight)
                let textures = textureAtlasRight.textureNames.sorted().map{
                    textureAtlasRight.textureNamed($0)
                }
                player.texture = textures.first
                player.run(
                    .animate(with: textures, timePerFrame: 0.6, resize: false, restore: true)
                )
            }
            
            else if playerPosx <= -0.2 {
               //Zmena textury postavicky - NEVIM JAK TADY UDELAT ANIMACI/JAK MENIT ANIMACI TEJ POSTAVICKY
                let textureAtlasLeft = SKTextureAtlas(named: Assets.Textures.Player.playerRunLeft)
                let textures = textureAtlasLeft.textureNames.sorted().map{
                    textureAtlasLeft.textureNamed($0)
                }
                player.texture = textures.first
                player.run(
                    .animate(with: textures, timePerFrame: 0.6, resize: false, restore: true)
                )
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let leftThumbstick = virtualController?.controller?.extendedGamepad?.leftThumbstick {
            playerPosx = CGFloat(leftThumbstick.xAxis.value)
            var walkSpeed = 1.7
            var animationSpeed = 0.3
            if (energyStat.rectangle.size.width == 0){
                walkSpeed = 1
                animationSpeed = 0.4
            } else{
                walkSpeed = 1.7
                animationSpeed = 0.3
            }
            
            if playerPosx >= 0.2 {
                lookingRight = true
                //Zmena textury postavicky
                if player.action(forKey: "runAnimationLeft") != nil{
                    player.removeAction(forKey: "runAnimationLeft")
                }
                if player.action(forKey: "runAnimationRight") == nil {
                        // Zmena textury postavicky
                        let textureAtlasRight = SKTextureAtlas(named: Assets.Textures.Player.playerRunRight)
                        let textures = textureAtlasRight.textureNames.sorted().map {
                            textureAtlasRight.textureNamed($0)
                        }
                    player.texture = textures.first
                        player.run(
                            .animate(with: textures, timePerFrame: animationSpeed, resize: false, restore: true),
                            withKey: "runAnimationRight"
                        )
                    }
                // Pohyb postavicky
                player.position.x += walkSpeed
                energyTimer?.invalidate()
                energyTimer = nil
                
                // Zmena hitboxu postavicky, aby mohla interagovat s vecma na, ktere se diva
                
            }
            
            else if playerPosx <= -0.2 {
                lookingRight = false
                if player.action(forKey: "runAnimationRight") != nil{
                    player.removeAction(forKey: "runAnimationRight")
                }
                if player.action(forKey: "runAnimationLeft") == nil {
                    //Zmena textury postavicky - NEVIM JAK TADY UDELAT ANIMACI/JAK MENIT ANIMACI TEJ POSTAVICKY
                    let textureAtlasLeft = SKTextureAtlas(named: Assets.Textures.Player.playerRunLeft)
                    let textures = textureAtlasLeft.textureNames.sorted().map{
                        textureAtlasLeft.textureNamed($0)
                    }
                    player.texture = textures.first
                    player.run(
                        .animate(with: textures, timePerFrame: animationSpeed, resize: false, restore: true), withKey: "runAnimationLeft"
                    )
                    
                }
               
                //Pamatovani otoceni/pohledu postavicky
                
                //Pohyb postavicky
                player.position.x -= walkSpeed
                energyTimer?.invalidate()
                energyTimer = nil
                
                //Zmena hitboxu postavicky, aby mohla interagovat s vecma na, ktere se diva
                
                
            } else {
                if energyTimer == nil {
                        // Start a timer to increase energy every 5 seconds
                            energyTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self,selector: #selector(increaseEnergy), userInfo: nil, repeats: true)
                        }
                if player.action(forKey: "runAnimationRight") != nil{
                    player.removeAction(forKey: "runAnimationRight")
                }
                if player.action(forKey: "runAnimationLeft") != nil{
                    player.removeAction(forKey: "runAnimationLeft")
                }
                if (lookingRight){
                    let textureAtlasRight = SKTextureAtlas(named: Assets.Textures.Player.playerStandRight)
                    let textures = textureAtlasRight.textureNames.sorted().map{
                        textureAtlasRight.textureNamed($0)
                    }
                    player.texture = textures.first
                    player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.rectangle.size.width, height: player.rectangle.size.height), center: CGPoint(x: player.size.width * 0.15, y: 0))
                    
                } else {
                    let textureAtlasLeft = SKTextureAtlas(named: Assets.Textures.Player.playerStandLeft)
                    let textures = textureAtlasLeft.textureNames.sorted().map{
                        textureAtlasLeft.textureNamed($0)
                    }
                    player.texture = textures.first
                    player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.rectangle.size.width, height: player.rectangle.size.height), center: CGPoint(x: -player.size.width * 0.15, y: 0))
                }
            }
            //Propojeni postavicky s kamerou a buttony, aby se vsechno hybalo zaroven (a stejnym smerem/stejne)
            cam.position.x = player.position.x
            
            attackBtn.position.x = player.position.x + (size.width*0.4)
            interactBtn.position.x = player.position.x + (size.width*0.29)
            openInvBtn.position.x = player.position.x + (size.width*0.3)
            if(itemCountLabel != nil){
                itemCountLabel.position.x = player.position.x + (size.width*0.25)
                selectedItemSprite.position.x = player.position.x + (size.width*0.269)
                
            }
            healthStat.position.x = player.position.x - (size.width*0.4)
            hungerStat.position.x = player.position.x - (size.width*0.4)
            thirstStat.position.x = player.position.x - (size.width*0.4)
            energyStat.position.x = player.position.x - (size.width*0.4)
            rectangleStat.position.x = player.position.x - (size.width*0.305)
        }
        //Pamatovani x pozice postavicky
        playerPosxHelp = player.position.x
        
    }
    
    func spawnGameObjects(texture: SKTexture, name: String){
        var x = 0
        let xIntervalValue = Int.random(in: 8...20)
        
        while x < xIntervalValue {
            let gameObject = GameObjectNode(texture: texture, name: name)
            if (gameObject.name == "tree"){
                gameObject.position.y = -size.height * 0.16
            } else if (gameObject.name == "stone") {
                gameObject.position.y = -size.height * 0.31
            }
            gameObject.position.x = base.tileMapWidth / CGFloat(xIntervalValue) * CGFloat(CGFloat(x) - 0.5) + CGFloat.random(in: (gameObject.texture?.size().width)! * 2.5...(gameObject.texture?.size().width)! * 5)
                
            addChild(gameObject)
            if (gameObject.position.x > base.tileMapWidth){
                x = xIntervalValue
                gameObject.removeFromParent()
            }
            x += 1
        }
        
        let waterObjectLeft = GameObjectNode(texture: SKTexture(imageNamed: Assets.Textures.Background.border), name: "waterPickLeft")
        waterObjectLeft.position.y = -size.height * 0.3
        waterObjectLeft.position.x = -size.width * 0.05
        
        let waterObjectRight = GameObjectNode(texture: SKTexture(imageNamed: Assets.Textures.Background.border), name: "waterPickRight")
        waterObjectRight.position.y = -size.height * 0.3
        waterObjectRight.position.x = size.width * 2.13
        
        
        addChild(waterObjectRight)
        addChild(waterObjectLeft)
    }
    
    private func decreaseStat(for type: String) {
        // Implement the logic to decrease the specified stat (food or water)
        // For example, you can decrease the stat values and update the UI
        if type == "food" {
            hungerStat.statMinus(howMuch: 1)
        } else if type == "water" {
            thirstStat.statMinus(howMuch: 1)
        }
        
        // Add additional logic as needed
    }
    
    private func startFoodTimer() {
        foodTimer = Timer.scheduledTimer(timeInterval: foodDecreaseInterval, target: self, selector: #selector(decreaseFoodStat), userInfo: nil, repeats: true)
    }

    private func startWaterTimer() {
        waterTimer = Timer.scheduledTimer(timeInterval: waterDecreaseInterval, target: self, selector: #selector(decreaseWaterStat), userInfo: nil, repeats: true)
    }
    
    @objc private func decreaseFoodStat() {
        // Implement logic to decrease food stat here
        hungerStat.statMinus(howMuch: 1)
    }

    @objc private func decreaseWaterStat() {
        // Implement logic to decrease water stat here
        thirstStat.statMinus(howMuch: 1)
    }
    
    @objc func increaseEnergy() {
        energyStat.statPlus(howMuch: 1)
        }
    
    
    func setStats() {
        let statYSpace = 30
        var statYPosition = 160
        //HP
        healthStat = StatsNode(texture: SKTexture(imageNamed: Assets.Textures.Stats.playerHP), color: .systemRed)
        healthStat.position.y = CGFloat(statYPosition)
        healthStat.rectangle.size.width = playerHP
        healthStat.rectangle.position.x = playerHPPosition
        addChild(healthStat)
        statYPosition -= statYSpace
        //Hunger
        hungerStat = StatsNode(texture: SKTexture(imageNamed: Assets.Textures.Stats.playerHunger), color: .brown)
        hungerStat.position.y = CGFloat(statYPosition)
        hungerStat.rectangle.size.width = playerHunger
        hungerStat.rectangle.position.x = playerHungerPosition
        addChild(hungerStat)
        statYPosition -= statYSpace
        //Thirst
        thirstStat = StatsNode(texture: SKTexture(imageNamed: Assets.Textures.Stats.playerThirst), color: .systemBlue)
        thirstStat.position.y = CGFloat(statYPosition)
        thirstStat.rectangle.size.width = playerThirst
        thirstStat.rectangle.position.x = playerThirstPosition
        addChild(thirstStat)
        statYPosition -= statYSpace
        //Energy
        energyStat = StatsNode(texture: SKTexture(imageNamed: Assets.Textures.Stats.playerEnergy), color: .yellow)
        energyStat.position.y = CGFloat(statYPosition)
        energyStat.rectangle.size.width = playerEnergy
        energyStat.rectangle.position.x = playerEnergyPosition
        addChild(energyStat)
        
        
        let rectWidth = healthStat.size.width + healthStat.rectangleBg.size.width + 20
        let rectHeight = healthStat.size.height * 4 + CGFloat(statYSpace) + 20
        rectangleStat = SKSpriteNode(color: .systemGray, size: CGSize(width: rectWidth, height: rectHeight))
        rectangleStat.position.y = hungerStat.position.y - 15
        rectangleStat.zPosition = Layer.score - 1
        addChild(rectangleStat)
    }
    
    func updateSelectedItemDisplay(itemImage: SKTexture?, itemCount: Int) {
        // Update the interact button's position based on your layout
        itemCountLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        itemCountLabel.fontSize = 10
        itemCountLabel.fontColor = SKColor.black
        itemCountLabel.text = "\(itemCount)"
        itemCountLabel.position = CGPoint(x: player.position.x + (size.width*0.28), y: player.position.y - 10)
        itemCountLabel.zPosition = 12
        // Display the selected item image
        if let itemImage = itemImage {
            selectedItemSprite = SKSpriteNode(texture: itemImage)
            selectedItemSprite.position = CGPoint(x: player.position.x - 3, y: player.position.y + 5)
            selectedItemSprite.size = CGSize(width: 20, height: 20)
            selectedItemSprite.zPosition = 11
            addChild(selectedItemSprite)
            addChild(itemCountLabel)
            //addChild(selectedItemShape)
        }
    }
    
    

}

//kontaktu
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
    
        //print("Colision begin")
        self.contact = contact
        let otherBody: SKPhysicsBody = (contact.bodyA.node is GameObjectNode) ? contact.bodyB : contact.bodyA
        if self.contact!.bodyA.node!.name == "waterPickLeft"{
            print("place left")
            whereToPlace = "waterPickLeft"
        } else if self.contact!.bodyA.node!.name == "waterPickRight"{
            print("place right")
            whereToPlace = "waterPickRight"
        }
        
    }
 
    func didEnd(_ contact: SKPhysicsContact) {
        
        self.contact = nil
        whereToPlace = nil
    }
    
    
}
