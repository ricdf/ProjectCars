//
//  MapViewController.swift
//  ProjectCars
//
//  Created by Ricardo Cavalcante on 16/06/19.
//  Copyright © 2019 Ricardo Cavalcante. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let locManager = CLLocationManager()
    var carro : Carro?
    @IBOutlet var mapView : MKMapView!
    var pin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask for Authorisation from the User.
        self.locManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locManager.requestWhenInUseAuthorization()
        
        //Delegate
        self.mapView.delegate = self
        
        if let c = carro{
            
            //Latitude e Longitude
            let lat = (c.latitude as NSString).doubleValue
            let lng = (c.longitude as NSString).doubleValue
            //Coordenada (Latitude e Longitude)
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let location = MKCoordinateRegion(center: center, span: span)
            //centralizar o mapa nesta coordenada
            self.mapView.setRegion(location, animated: true)
            
            //asdicionaro marcador no mapa
            pin.coordinate = location.center
            pin.title = "Fábrica \(c.nome)"
            self.mapView.addAnnotation(pin)
            
            
            //mudar o mapa para o modo satelite
            self.mapView.mapType = MKMapType.satellite
            
        }
        
    }


    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinView")
        pinView.pinTintColor = UIColor.green
        pinView.canShowCallout = true
        let btPin = UIButton(type: .detailDisclosure) as UIView
        pinView.rightCalloutAccessoryView = btPin
        
        return pinView //view que sera exibida ao usuario
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        
        //clicou no botao da view
        Alerta.alerta("OI!", viewController: self)
    }

}
