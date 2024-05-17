//
//  ResearchManager.swift
//  Human_IOS2_project
//
//  Created by Mário Zahorjan on 20.01.2024.
//

import Foundation
import SpriteKit

struct ResearchRequirement {
    var itemTexture: SKTexture
    var itemName: String
    var quantity: Int
    var index: Int
}

class ResearchManager {
    static let shared = ResearchManager() // Singleton instance

    var availableResearches: [ResearchNode]
    var researchedResearches: [ResearchNode]
    
    private init() {
        availableResearches = []
        researchedResearches = []

        // Define your initial researches
        let bedResearch = ResearchNode(
            researchName: "Bed",
            requiredResearch: nil,
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 4, index: 0),
                            ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.leaf), itemName: "leaf", quantity: 2, index: 2)],
            itemImageName: "bedResearch"
        )

        let betterShieldResearch = ResearchNode(
            researchName: "Shield",
            requiredResearch: "Iron Forging",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 10, index: 0), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 5, index: 3)],
            itemImageName: "shield 2"
        )

        let betterSwordResearch = ResearchNode(
            researchName: "Sword",
            requiredResearch: "Iron Forging",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 5, index: 0), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 10, index:3)],
            itemImageName: "bigger sword"
        )

        let betterToolsResearch = ResearchNode(
            researchName: "Better Tools",
            requiredResearch: "Iron Forging",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 4, index: 0), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.stone), itemName: "iron", quantity: 8, index: 3)],
            itemImageName: Assets.Textures.Tools.stonePickaxe
        )
        let evenBetterToolsResearch = ResearchNode(
            researchName: "Even Better Tools",
            requiredResearch: "Better Tools",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 8, index: 0), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 8, index: 3)],
            itemImageName: Assets.Textures.Tools.ironPickaxe
        )

        let mineResearch = ResearchNode(
            researchName: "Mine",
            requiredResearch: "Bed",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 15, index: 0), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodPlank), itemName: "plank", quantity: 15, index: 5)],
            itemImageName: Assets.Textures.ResACraft.mine
        )

        let betterMineResearch = ResearchNode(
            researchName: "Better Mine",
            requiredResearch: "Mine",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 20, index: 0), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.stone), itemName: "stone", quantity: 15, index: 1), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 10, index: 3)],
            itemImageName: Assets.Textures.ResACraft.mineResearch
        )

        let boatResearch = ResearchNode(
            researchName: "Boat",
            requiredResearch: "Even Better Tools",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodLog), itemName: "wood", quantity: 20, index: 0), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.bucketWithWater), itemName: "water bucket", quantity: 15, index: 9), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.metal), itemName: "iron", quantity: 10, index: 3)],
            itemImageName: "boatResearch"
        )

        let ironForgingResearch = ResearchNode(
            researchName: "Iron Forging",
            requiredResearch: "Mine",
            requiredItems: [ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.stone), itemName: "stone", quantity: 15, index: 1), ResearchRequirement(itemTexture: SKTexture(imageNamed: Assets.Textures.Materials.woodPlank), itemName: "plank", quantity: 10, index: 5)],
            itemImageName: "metal"
        )

        // Add the initial researches to the availableResearches list
        availableResearches.append(contentsOf: [
            
            bedResearch, 
            mineResearch,
            ironForgingResearch,
            betterMineResearch,
            //betterShieldResearch,
            //betterSwordResearch,
            betterToolsResearch,
            evenBetterToolsResearch,
            
            boatResearch,
            
        ])
    }
    
    func moveResearchToResearched(researchNode: ResearchNode) {
            // Check if the research node is in the available researches list
            guard let index = availableResearches.firstIndex(where: { $0 === researchNode }) else {
                return // The research node is not in the available researches list
            }

            // Remove the research node from the available researches list
            //availableResearches.remove(at: index)

            // Add the research node to the researched researches list
            researchedResearches.append(researchNode)
        CraftingManager.shared.unlockRecipes(forResearch: researchNode.researchName)
        }

    // Add methods to check if a research is available, unlock a research, etc.
}
