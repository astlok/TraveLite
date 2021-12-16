//
//  OneRouteViewController.swift
//  TraveLite
//
//  Created by Алексей Егоров on 11.12.2021.
//  
//

import UIKit
import GoogleMapsUtils
import GoogleMaps

final class OneRouteViewController: UIViewController {
	private let output: OneRouteViewOutput
    
    var trek: Trek
    
    private let name: UILabel = UILabel()
    private let days: UILabel = UILabel()
    private let complexity: UILabel = UILabel()
    private let descr: UILabel = UILabel()
    
    private let downloadButton: UIButton = UIButton()
    private let fileName = "\(UUID().uuidString).kml"
    
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    private var mapView: GMSMapView = {
        GMSServices.provideAPIKey("AIzaSyBzsvS-pJLswlR4fKZPzQ_2vLIE_3YL5Uo")
        let map = GMSMapView()
        return map
    }()

    init(output: OneRouteViewOutput, trek: Trek) {
        self.output = output
        self.trek = trek

        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name.font = UIFont.systemFont(ofSize: 34)
        name.text = trek.name
        name.lineBreakMode = .byWordWrapping
        name.numberOfLines = 0
        
        days.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        days.font = UIFont.systemFont(ofSize: 23)
        days.text = "Время маршрута:  \(trek.days.days())"
        
        complexity.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        complexity.font = UIFont.systemFont(ofSize: 23)
        complexity.text = "Сложность маршрута:  \(trek.difficult)"
        
        descr.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        descr.font = UIFont.systemFont(ofSize: 20)
        descr.numberOfLines = 0
        descr.lineBreakMode = .byWordWrapping
        descr.text = trek.description
       
        downloadButton.setTitle("Скачать маршрут", for: .normal)
        downloadButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.8), for: .normal)
        downloadButton.backgroundColor = UIColor(red: 0.71, green: 0.72, blue: 0.63, alpha: 0.5)
        downloadButton.layer.cornerRadius = 10
        
        downloadButton.addTarget(self, action: #selector(tapDownloadButton), for: .touchUpInside)
    }
    
    @objc
    func tapDownloadButton() {
        let trekData = trek.file.data(using: .utf8)
        
        let textURL = trekData?.dataToFile(fileName: fileName)

        var filesToShare = [Any]()

        filesToShare.append(textURL)

        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(
            withLatitude: 60.89,
            longitude: 29.17,
            zoom: 5
        )
        
        mapView = GMSMapView(frame: self.view.bounds, camera: camera)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        setupScrollView()
        
        self.contentView.addSubview(name)
        self.contentView.addSubview(days)
        self.contentView.addSubview(descr)
        self.contentView.addSubview(complexity)
        self.contentView.addSubview(mapView)
        self.contentView.addSubview(downloadButton)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 23).isActive = true
        name.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -23).isActive = true
//        name.heightAnchor.constraint(equalToConstant: 64).isActive = true
        name.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        
        days.translatesAutoresizingMaskIntoConstraints = false
        days.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 23).isActive = true
        days.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -23).isActive = true
//        days.heightAnchor.constraint(equalToConstant: 36).isActive = true
        days.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        
        complexity.translatesAutoresizingMaskIntoConstraints = false
        complexity.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 23).isActive = true
        complexity.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -23).isActive = true
//        complexity.heightAnchor.constraint(equalToConstant: 16).isActive = true
        complexity.topAnchor.constraint(equalTo: days.bottomAnchor, constant: 10).isActive = true
        
        descr.translatesAutoresizingMaskIntoConstraints = false
        descr.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 23).isActive = true
        descr.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -23).isActive = true
        descr.topAnchor.constraint(equalTo: complexity.bottomAnchor, constant: 32).isActive = true
        
        mapView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 7/8).isActive = true
        mapView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: descr.bottomAnchor, constant: 32).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 7/8).isActive = true
        downloadButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        downloadButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 32).isActive = true
        downloadButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        downloadButton.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1/8).isActive = true
        
        let trekData = trek.file.data(using: .utf8)
        
        let textURL = trekData?.dataToFile(fileName: fileName)
        
        renderKml(with: textURL?.absoluteURL ?? URL.init(fileURLWithPath: ""))
	}
    
    func renderKml(with url: URL) {
        let kmlParser = GMUKMLParser(url: url)

        kmlParser.parse()

        let renderer = GMUGeometryRenderer(
            map: mapView,
            geometries: kmlParser.placemarks,
            styles: kmlParser.styles,
            styleMaps: kmlParser.styleMaps
        )

        renderer.render()
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

}



extension Int {
     func days() -> String {
         var dayString: String!
         if "1".contains("\(self % 10)") {dayString = "день"}
         if "234".contains("\(self % 10)")    {dayString = "дня" }
         if "567890".contains("\(self % 10)") {dayString = "дней"}
         if 11...14 ~= self % 100                   {dayString = "дней"}
    return "\(self) " + dayString
    }
}

extension OneRouteViewController: OneRouteViewInput {
}

extension Data {

    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {

        // Make a constant from the data
        let data = self

        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))

            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)

        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }

        // Returns nil if there was an error in the do-catch -block
        return nil

    }

}
