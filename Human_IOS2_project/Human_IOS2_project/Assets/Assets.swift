//
//  Assets.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 18.12.2023.
//

import SpriteKit

enum Assets {}


// MARK: Textures
extension Assets {
    enum Textures {
        enum Background {
            static let sunnySummer = "sunny summer"
            static let rainySummer = "rainy summer"
            static let zatahleSummer = "zatahle summer"
            static let sunnyWinter = "sunny winter"
            static let snowyWinter = "snowy winter"
            static let zatahleWinter = "zatahle winter"
            static let backpackBackground = "backpack background"
            static let craftingBG = "CraftingBG"
            static let researchBG = "ResearchBG"
            static let backpackBG = "BackpackBG"
            static let border = "border"
            static let start = "start"
            static let gameOver = "gameOver"
            static let final = "final"
            static let startAnimation1 = "startAnimation1"
            static let startAnimation2 = "startAnimation2"
            static let startAnimation3 = "startAnimation3"
            static let finalAnimation1 = "finalAnimation1"
            static let finalAnimation2 = "finalAnimation2"
        }
        enum Base {
            static let dirtBase = "Tilemap base dirt"
            static let sandBase = "Tilemap base sand"
            static let waterBase = "tilemapWater"
        }
        
        enum Player{
            static let playerStand = "player stand"
            static let playerStandLeft = "playerStandLeft"
            static let playerStandRight = "playerStandRight"
            static let playerRunLeft = "playerRunLeft"
            static let playerRunRight = "playerRunRight"
            static let playerPunchLeft = "playerPunchLeft"
            static let playerPunchRight = "playerPunchRight"
        }
        
        enum Armory {
            static let sword = "sword"
            static let shield = "shield"
            static let shield2 = "shield 2"
            static let biggerSword = "bigger sword"
        }
        enum Materials {
            static let backpackItemEmpty = "backpackItemEmpty"
            
            static let backpack = "backpack"
            static let blueFish = "blue fish"
            static let bucketWithWater = "bucket with water"
            static let bucket = "bucket"
            static let coconut = "coconut"
            static let glass = "glass"
            static let leaf = "leaf"
            static let metal = "metal"
            static let nail = "nail"
            static let pinkFish = "pink fish"
            static let rope = "rope"
            static let sand = "sand"
            static let sapling = "sapling"
            static let stone = "stone"
            static let woodLog = "wood log"
            static let woodPlank = "wood plank"
            
        }
        enum GameObjects{
            static let tree = "tree"
            static let tree1 = "tree1"
            static let tree2 = "tree2"
            static let stone = "stone base stred"
        }
        
        enum ResACraft {
            static let mine = "mine"
            static let bed = "bed"
            static let bedResearch = "bedResearch"
            static let mineResearch = "mineResearch"
            static let boatResearch = "boatResearch"
        }
        enum Buttons {
            static let attackBtnNormal = "AttackBtnNormal"
            static let attackBtnActive = "AttackBtnActive"
            static let interactBtnNormal = "InteractBtnNormal"
            static let interactBtnActive = "InteractBtnActive"
            static let invBtnNormal = "InvBtnNormal"
            static let invBtnActive = "InvBtnActive"
            static let closeInvBtn = "CloseInvBtn"
            static let navInvS = "InventoryS"
            static let navInvNS = "InventoryNS"
            static let navResNS = "ResearchNS"
            static let navResS = "ResearchS"
            static let navCraftS = "CraftingS"
            static let navCraftNS = "CraftingNS"
        }
        enum Stats{
            static let playerHP = "playerHP"
            static let playerHunger = "playerHunger"
            static let playerThirst = "playerThirst"
            static let playerEnergy = "playerEnergy"
        }
        enum Tools{
            static let woodAxe = "wooden axe"
            static let woodPickaxe = "wooden pickaxe"
            static let woodShovel = "wooden shovel"
            static let stoneAxe = "stone axe"
            static let stonePickaxe = "stone pickaxe"
            static let stoneShovel = "stone shovel"
            static let ironAxe = "iron axe"
            static let ironPickaxe = "iron pickaxe"
            static let ironShovel = "iron shovel"
        }
    }
}

extension Assets {
    enum Sounds{
        static let treeHit = "treeHit.wav"
        static let treeDestroy = "treeDestroy.wav"
        static let death = "death.wav"
        static let hurray = "hurray.wav"
    }
}
