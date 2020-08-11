//
//  ViewController.swift
//  ARPlanets
//
//  Created by Thiago Martins on 10/08/20.
//  Copyright © 2020 ThiagoMartins. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    
    let configuration = ARWorldTrackingConfiguration()

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Earth day")
        earth.geometry?.firstMaterial?.specular.contents = UIImage(named:"Earth Specular Texture")
        earth.position = SCNVector3(0, 0, -1)
        
        self.sceneView.scene.rootNode.addChildNode(earth)
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians) , z: 0, duration: 8)
        
        let forever = SCNAction.repeatForever(action)
        
        earth.runAction(forever)
    }


}

extension Int{
    var degreesToRadians: Double {return Double(self) * .pi/180}
}

