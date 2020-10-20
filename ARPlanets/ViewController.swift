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
        
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named:"Earth day")!, specular: UIImage(named:"Earth Specular Texture")!, emission: UIImage(named: "Earth clouds")!, normal: UIImage(named:"Earth normal map")!, position: SCNVector3(1.2, 0, 0))
        
        earthParent.addChildNode(earth)
        
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "Venus surface")!, specular: nil, emission: UIImage(named: "Venus atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        
        venusParent.addChildNode(venus)
        
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "Moon diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        earth.addChildNode(moon)
        
        let venusMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "Moon diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        venus.addChildNode(venusMoon)
        
        
        let sunAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians) , z: 0, duration: 8)
        
        let forever = SCNAction.repeatForever(sunAction)
        
        sun.runAction(forever)
        
        
        let earthParentRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians) , z: 0, duration: 14)
        
        let foreverEarth = SCNAction.repeatForever(earthParentRotation)
        
        earthParent.runAction(foreverEarth)
        
        
        let venusParentRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians) , z: 0, duration: 10)
        
        let foreverVenus = SCNAction.repeatForever(venusParentRotation)
        
        venusParent.runAction(foreverVenus)
        
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

