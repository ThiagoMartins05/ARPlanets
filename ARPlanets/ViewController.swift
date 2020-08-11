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
        // Do any additional setup after loading the view.
    }


}

