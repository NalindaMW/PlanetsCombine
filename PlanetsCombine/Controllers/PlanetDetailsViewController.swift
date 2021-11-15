//
//  PlanetDetailsViewController.swift
//  PlanetsCombine
//
//  Created by Nalinda Wickramarathna on 11/13/21.
//

import UIKit

class PlanetDetailsViewController: UIViewController {

    var planet: Planet?
    
    @IBOutlet weak var lblPlanetName: UILabel!
    @IBOutlet weak var lblOrbitPeriod: UILabel!
    @IBOutlet weak var lblGravity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setPlanetDetails()
    }
    
    func setPlanetDetails() {
        self.lblPlanetName.text = self.planet?.name
        self.lblOrbitPeriod.text = "\(UIConstants.orbitPeriod) \(self.planet?.orbital_period ?? "N/A")"
        self.lblGravity.text = "\(UIConstants.gravity) \(self.planet?.gravity ?? "N/A")"
    }
}
