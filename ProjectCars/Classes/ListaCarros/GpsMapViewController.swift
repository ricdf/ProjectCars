//
//  GpsMapViewController.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 16/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import MapKit

class GpsMapViewController: MapViewController, CLLocationManagerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locManager.delegate = self
        self.locManager.distanceFilter = 100.00
        self.locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        //comeca a monitorar o GPS
        self.locManager.startUpdatingLocation()
        
    }
    deinit {
        //é o destrutor, deslifa o monitoramento do GPS
        self.locManager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //ultima localizacao CLLocation
        let newLocation = locations[locations.count-1] as CLLocation
        let lat = newLocation.coordinate.latitude
        let lng = newLocation.coordinate.longitude
        print("didUpdateToLocation lat:\(lat), lng \(lng)")
        
        //coordenada (latitude/longitude)
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let location = MKCoordinateRegion(center: center, span: span)
        
        //centraliza o mapa nesta coordenada
        self.mapView.setRegion(location, animated: true)
        
        //atualiza o marcador para acompanhar o GPS
        self.pin.coordinate = center
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager.didFailWithError: \(error)")
    }
}
