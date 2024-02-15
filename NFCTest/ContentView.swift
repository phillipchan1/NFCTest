//
//  ContentView.swift
//  NFCTest
//
//  Created by Phillip Chan on 2/12/24.
//

import SwiftUI
import CoreNFC

let nfcReader = NFCReader()


struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var showLocation = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
        
            if showLocation {
                VStack {
                    Text("Current Location:")
                    if let location = locationManager.location {
                        Text("Latitude: \(location.coordinate.latitude)")
                        Text("Longitude: \(location.coordinate.longitude)")
                    } else {
                        Text("Location data not available.")
                    }
                }
                
                VStack {
                    Text("Flock Number:")
                }
            }
           
            Button("Scan NFC Tag") {
                nfcReader.beginScanning { payload in
                    showLocation = true
                }
                
            }
        }
        .padding()
        .onAppear {
            
            print("requesting location")
        }
    }
        
}

#Preview {
    ContentView()
}
