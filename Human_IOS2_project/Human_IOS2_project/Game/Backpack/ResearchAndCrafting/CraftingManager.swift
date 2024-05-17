//
//  CraftingManager.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 26.01.2024.
//

import SwiftUI
import SpriteKit

struct CraftingRecipe {
    let nameOfItemToBeCrafted: String
    let requiredItems: [ResearchRequirement]
    let requiredResearch: String?
    let itemImageName: String
    let quantityOfCraftedItems: Int
    let  index: Int
}

class CraftingManager {
    static let shared = CraftingManager() // Singleton instance

    var availableCraftingRecipes: [CraftableItemNode]
    var all: [CraftableItemNode]
    

    private init() {
        all = []
        availableCraftingRecipes = []
        

        // Define your initial crafting recip
        let planks = CraftableItemNode(
            nameOfItemToBeCrafted: "Planks",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 1, index: 0)],
            requiredResearch: nil,
            itemImageName: Assets.Textures.Materials.woodPlank,
            quantityOfCraftedItems: 2,
            index: 5
        )
        let woodenPickaxeRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Wooden Pickaxe",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 5, index: 0)],
            requiredResearch: nil,
            itemImageName: Assets.Textures.Tools.woodPickaxe,
            quantityOfCraftedItems: 1,
            index: 10
        )
        
        let woodenAxeRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Wooden Axe",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 5, index: 0)],
            requiredResearch: nil,
            itemImageName: Assets.Textures.Tools.woodAxe,
            quantityOfCraftedItems: 1,
            index: 11
        )
        
        let woodenShovelRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Wooden Shovel",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 5, index: 0)],
            requiredResearch: nil,
            itemImageName: Assets.Textures.Tools.woodShovel,
            quantityOfCraftedItems: 1,
            index: 12
        )
        
        let stonePickaxeRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Stone Pickaxe",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.stone), itemName: "stone", quantity: 3, index: 1)],
            requiredResearch: "Better Tools",
            itemImageName: Assets.Textures.Tools.stonePickaxe,
            quantityOfCraftedItems: 1,
            index: 13
        )
        
        let stoneAxeRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Stone Axe",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.stone), itemName: "stone", quantity: 3, index: 1)],
            requiredResearch: "Better Tools",
            itemImageName: Assets.Textures.Tools.stoneAxe,
            quantityOfCraftedItems: 1,
            index: 14
        )
        
        let stoneShovelRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Stone Shovel",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.stone), itemName: "stone", quantity: 3, index: 1)],
            requiredResearch: "Better Tools",
            itemImageName: Assets.Textures.Tools.stoneShovel,
            quantityOfCraftedItems: 1,
            index: 15
        )
        
        let ironPickaxeRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Iron Pickaxe",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 3, index: 3)],
            requiredResearch: "Even Better Tools",
            itemImageName: Assets.Textures.Tools.ironPickaxe,
            quantityOfCraftedItems: 1,
            index: 16
        )
        
        let ironAxeRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Iron Axe",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 3, index: 3)],
            requiredResearch: "Even Better Tools",
            itemImageName: Assets.Textures.Tools.ironAxe,
            quantityOfCraftedItems: 1,
            index: 17
        )
        
        let ironShovelRecipe = CraftableItemNode(
            nameOfItemToBeCrafted: "Iron Shovel",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 2, index: 3)],
            requiredResearch: "Even Better Tools",
            itemImageName: Assets.Textures.Tools.ironShovel,
            quantityOfCraftedItems: 1,
            index: 18
        )
        
        let bucket = CraftableItemNode(
            nameOfItemToBeCrafted: "Bucket",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 5, index: 3)],
            requiredResearch: "Iron Forging",
            itemImageName: Assets.Textures.Materials.bucket,
            quantityOfCraftedItems: 1,
            index: 8
        )
        let bed = CraftableItemNode(
            nameOfItemToBeCrafted: "Bed",
            requiredItems: [
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodPlank), itemName: "planks", quantity: 4, index: 5),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "logs", quantity: 2, index: 0),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.leaf), itemName: "leaves", quantity: 4, index: 2)],
            requiredResearch: "Bed",
            itemImageName: Assets.Textures.ResACraft.bedResearch,
            quantityOfCraftedItems: 1,
            index: 7
        )
        let mine = CraftableItemNode(
            nameOfItemToBeCrafted: "Mine",
            requiredItems: [
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodPlank), itemName: "plank", quantity: 4, index: 5),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "logs", quantity: 2, index: 0)
                ],
            requiredResearch: "Mine",
            itemImageName: Assets.Textures.ResACraft.mine,
            quantityOfCraftedItems: 1,
            index: 22
        )
        let bettermine = CraftableItemNode(
            nameOfItemToBeCrafted: "Better Mine",
            requiredItems: [
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.stone), itemName: "stone", quantity: 8, index: 1),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "logs", quantity: 4, index: 0),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 4, index: 3)
                ],
            requiredResearch: "Better Mine",
            itemImageName: Assets.Textures.ResACraft.mineResearch,
            quantityOfCraftedItems: 1,
            index: 19
        )
        let boat = CraftableItemNode(
            nameOfItemToBeCrafted: "Boat",
            requiredItems: [
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.nail), itemName: "Nail", quantity: 10, index: 21),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "logs", quantity: 8, index: 0),                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodPlank), itemName: "planks", quantity: 10, index: 5),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 4, index: 3),
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.leaf), itemName: "leaf", quantity: 20, index: 2)
                ],
            requiredResearch: "Boat",
            itemImageName: Assets.Textures.ResACraft.boatResearch,
            quantityOfCraftedItems: 1,
            index: 20
        )
        let nail = CraftableItemNode(
            nameOfItemToBeCrafted: "Nail",
            requiredItems: [
                ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 1, index: 3)
                ],
            requiredResearch: "Iron Forging",
            itemImageName: Assets.Textures.Materials.nail,
            quantityOfCraftedItems: 2,
            index: 21
        )
        
        availableCraftingRecipes.append(contentsOf: [woodenAxeRecipe,woodenPickaxeRecipe, planks])
        // Add the initial crafting recipes to the availableCraftingRecipes list
        all.append(contentsOf: [ bed,bucket,bettermine,stoneAxeRecipe,stonePickaxeRecipe,woodenAxeRecipe,woodenPickaxeRecipe, ironAxeRecipe,planks,ironPickaxeRecipe,nail,boat,mine])
    }
    
    func resetRecepies(){
        availableCraftingRecipes = []
        var recipesToAdd: [CraftableItemNode] = []
        for recipe in all {
            // Check if the recipe has required research and matches the provided researchName
            if recipe.requiredResearch == nil{
                // Add the recipe to the temporary array
                recipesToAdd.append(recipe)
            }
        }
        availableCraftingRecipes.append(contentsOf: recipesToAdd)
    }
    
    func unlockRecipes(forResearch researchName: String) {
        // Create a temporary array to store recipes to be added
        var recipesToAdd: [CraftableItemNode] = []

        // Iterate through available crafting recipes
        for recipe in all {
            // Check if the recipe has required research and matches the provided researchName
            if let requiredResearch = recipe.requiredResearch, requiredResearch == researchName {
                // Add the recipe to the temporary array
                recipesToAdd.append(recipe)
            }
        }

        // Add the recipes from the temporary array to the available crafting recipes
        availableCraftingRecipes.append(contentsOf: recipesToAdd)
    }
    
    


    // Add methods to check if a crafting recipe is available, unlock a crafting recipe, etc.
}
