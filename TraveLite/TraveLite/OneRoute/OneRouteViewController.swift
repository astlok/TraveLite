//
//  OneRouteViewController.swift
//  TraveLite
//
//  Created by Алексей Егоров on 11.12.2021.
//  
//

import UIKit

final class OneRouteViewController: UIViewController {
	private let output: OneRouteViewOutput
    
    var trek: Trek
    
    private let name: UILabel = UILabel()
    private let days: UILabel = UILabel()
    private let complexity: UILabel = UILabel()
    private let descr: UILabel = UILabel()
    
    private let downloadButton: UIButton = UIButton()

    init(output: OneRouteViewOutput, trek: Trek) {
        self.output = output
        self.trek = trek

        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name.font = UIFont(name: "Montserrat-Medium", size: 24)
        name.text = trek.name
        
        days.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        days.font = UIFont(name: "Montserrat-Regular", size: 14)
        days.text = "Время маршрута:  \(trek.days.days())"
        
        complexity.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        complexity.font = UIFont(name: "Montserrat-Regular", size: 14)
        complexity.text = "Сложность маршрута:  \(trek.days)"
        
        descr.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        descr.font = UIFont(name: "Montserrat-Medium", size: 14)
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
        
        let textURL = trekData?.dataToFile(fileName: "\(UUID().uuidString).kml")

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
        
        self.view.addSubview(name)
        self.view.addSubview(days)
        self.view.addSubview(descr)
        self.view.addSubview(complexity)
        self.view.addSubview(downloadButton)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 23).isActive = true
        name.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -23).isActive = true
        name.heightAnchor.constraint(equalToConstant: 64).isActive = true
        name.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        
        days.translatesAutoresizingMaskIntoConstraints = false
        days.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 23).isActive = true
        days.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -23).isActive = true
        days.heightAnchor.constraint(equalToConstant: 16).isActive = true
        days.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        
        complexity.translatesAutoresizingMaskIntoConstraints = false
        complexity.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 23).isActive = true
        complexity.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -23).isActive = true
        complexity.heightAnchor.constraint(equalToConstant: 16).isActive = true
        complexity.topAnchor.constraint(equalTo: days.bottomAnchor).isActive = true
        
        descr.translatesAutoresizingMaskIntoConstraints = false
        descr.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 23).isActive = true
        descr.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -23).isActive = true
        descr.topAnchor.constraint(equalTo: complexity.bottomAnchor, constant: 32).isActive = true
        
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 7/8).isActive = true
        downloadButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        downloadButton.topAnchor.constraint(equalTo: descr.bottomAnchor, constant: 32).isActive = true
        downloadButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/8).isActive = true
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
