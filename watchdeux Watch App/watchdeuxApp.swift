//
//  watchdeuxApp.swift
//  watchdeux Watch App
//
//  Created by Oliver Nguyen on 4/27/23.
//

import SwiftUI
import Foundation
import ClockKit


@main
struct watchdeux_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Image("megumin")
                    .resizable()
                    .ignoresSafeArea()
                ContentView()
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Weather().padding([.bottom, .trailing]).frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing).ignoresSafeArea()
                        Spacer()
                    }
                }
            }
        }
    }
}

