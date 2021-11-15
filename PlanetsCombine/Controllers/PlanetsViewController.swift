//
//  ViewController.swift
//  PlanetsCombine
//
//  Created by Nalinda Wickramarathna on 11/13/21.
//

import UIKit
import Combine

class PlanetsViewController: UIViewController {

    @IBOutlet weak var planetsTableView: UITableView!
    
    var planets = [Planet]()
    var selectedPlanet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPlanets()
        planetsTableView.tableFooterView = UIView()
    }

    var getPlanetsToken: AnyCancellable?
    func fetchPlanets() {
        getPlanetsToken = NetworkService.getPlanets()
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Publisher stopped observing")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
        } receiveValue: { [weak self] (planets) in
            self?.planets = planets
            self?.planetsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.planetDetailsSegue {
            if let destinationVC = segue.destination as? PlanetDetailsViewController {
                destinationVC.planet = self.selectedPlanet
            }
        }
    }

}

extension PlanetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let planetCell = tableView.dequeueReusableCell(withIdentifier: Constants.planetCell, for: indexPath) as! PlanetCell
        
        let planet = self.planets[indexPath.row]
        planetCell.lblPlanetName.text = planet.name
        planetCell.lblClimate.text = "\(UIConstants.climateIs) \(planet.climate)"
        planetCell.planetImage.imageFromURL(urlString: "\(NetworkService.imageURL)\(indexPath.row)/200/",
                                            PlaceHolderImage: UIImage(named: Constants.placeholder)!)
        
        return planetCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedPlanet = self.planets[indexPath.row]
        self.performSegue(withIdentifier: Constants.planetDetailsSegue, sender: nil)
    }
}
