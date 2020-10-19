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
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sun diffuse")
        sun.position = SCNVector3(0, 0, -1)
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        
        
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named:"Earth day")
        earth.geometry?.firstMaterial?.emission.contents = UIImage(named: "Earth clouds")
        earth.geometry?.firstMaterial?.specular.contents = UIImage(named:"Earth Specular Texture")
        earth.geometry?.firstMaterial?.normal.contents = UIImage(named:"Earth normal map")
        earth.position = SCNVector3(0, 0, -1)
        
        sun.addChildNode(earth)
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians) , z: 0, duration: 8)
        
        let forever = SCNAction.repeatForever(action)
        
        earth.runAction(forever)
    }


}

extension Int{
    var degreesToRadians: Double {return Double(self) * .pi/180}
}

