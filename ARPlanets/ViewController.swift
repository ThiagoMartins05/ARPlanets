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
        
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        earthParent.addChildNode(moonParent)
        
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        moonParent.position = SCNVector3(1.2, 0, 0)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named:"Earth day")!, specular: UIImage(named:"Earth Specular Texture")!, emission: UIImage(named: "Earth clouds")!, normal: UIImage(named:"Earth normal map")!, position: SCNVector3(1.2, 0, 0))
        
        earthParent.addChildNode(earth)
        
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "Venus surface")!, specular: nil, emission: UIImage(named: "Venus atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        
        venusParent.addChildNode(venus)
        
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "Moon diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        moonParent.addChildNode(moon)
        
        let sunAction = Rotation(time: 8)
        sun.runAction(sunAction)
        
        let earthParentAction = Rotation(time: 14)
        earthParent.runAction(earthParentAction)
        
        let earthAction = Rotation(time: 8)
        earth.runAction(earthAction)
        
        let moonAction = Rotation(time: 5)
        moonParent.runAction(moonAction)
        
        let venusParentAction = Rotation(time: 10)
        venusParent.runAction(venusParentAction)
        
        let venusAction = Rotation(time: 9)
        venus.runAction(venusAction)
        
    }
    
    func Rotation(time: TimeInterval) -> SCNAction{
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians) , z: 0, duration: time)
        
        let foreverRotation = SCNAction.repeatForever(Rotation)
        
        return foreverRotation
    }
    
    func planet(geometry:SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode{
       
        let planet = SCNNode()
        planet.geometry = geometry
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position

        
        return planet
    }


}

extension Int{
    var degreesToRadians: Double {return Double(self) * .pi/180}
}

