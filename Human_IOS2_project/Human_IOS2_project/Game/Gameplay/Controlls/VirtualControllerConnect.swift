//
//  VirtualControllerConnect.swift
//  Human_IOS2_project
//
//  Created by Kryštof Bůšek on 21.12.2023.
//

import GameController

func connectVirtualController() -> GCVirtualController { //Pripojeni controlleru
    let controllerConfig = GCVirtualController.Configuration()
    controllerConfig.elements = [GCInputLeftThumbstick]
    
    let controller = GCVirtualController(configuration: controllerConfig)
    controller.connect()
    return controller
    
}
