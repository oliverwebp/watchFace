//
//  ContentView.swift
//  watchfaceUn Watch App
//
//  Created by Oliver Nguyen on 4/27/23.
//

import SwiftUI
import Combine

class runtimeSesh {
    private var session: WKExtendedRuntimeSession?

    func start() {
        guard session?.state != .running else { return }

        // create or recreate session if needed
        if nil == session || session?.state == .invalid {
            session = WKExtendedRuntimeSession()
        }
        session?.start()
    }

    func invalidate() {
        session?.invalidate()
    }
}
class battery: ObservableObject {
    @Published var level = WKInterfaceDevice.current().batteryLevel
    private var cancellableSet: Set<AnyCancellable> = []


    
    init() {
        WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
        assignLevelPublisher()
        

    }
    private func assignLevelPublisher() {
        WKInterfaceDevice.current()
            .publisher(for: \.batteryLevel)
            .assign(to: \.level, on: self)
            .store(in: &self.cancellableSet)
    }
    
}

struct ContentView: View {
    let coordinator = runtimeSesh()
    @ObservedObject var batterylevel = battery()
    @State var dateTime = Date()
    @State var date = Date()
    
    var body: some View {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("\(timeString(date: dateTime))")
                        .font(.custom("Rubik-SemiBold", size: 20))
                        .multilineTextAlignment(.leading)
                        .onAppear( perform: {
                        let _ = self.updateTimer
                    })
                        .foregroundStyle(
                        LinearGradient(
                            colors: [Color(red: 212/255, green: 56/255, blue: 68/255),Color(red: 101/255, green: 65/255, blue: 71/255)],
                        startPoint: .leading,
                        endPoint: .trailing
                        ))
                        .frame(maxWidth: .infinity, alignment: .leading)
        
                    Spacer(minLength: 30)
                
                }
                HStack {
                    Spacer()
                    Text("\(timeStringDeux(date: date))").onAppear(perform: {
                        let _ = self.updateTimerDeux
                    })
                    .font(.custom("Rubik-Regular", size: 18))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(red: 253/255, green: 126/255, blue: 0),Color(red: 244.0/255, green: 0.0/255, blue: 110.0/255)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    Spacer()
                }
                Spacer(minLength: 80)
                Text("\(String(format: "\(Int(batterylevel.level * 100))", "%d"))%").frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    .foregroundStyle(
                    LinearGradient(
                        colors: [Color(red: 253/255, green: 126/255, blue: 0),Color(red: 244.0/255, green: 0.0/255, blue: 110.0/255)],
                    startPoint: .leading,
                    endPoint: .trailing
                )).padding([.trailing])
                
            }.onAppear(perform: {
                coordinator.start()
            })
    }
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm:ss"
        return formatter
    }
    func timeString(date: Date) -> String {
        let time = timeFormat.string(from: date)
        return time
    }

    var updateTimer: Timer {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                              block: {_ in
                                 self.dateTime = Date()
                               })
    }
    var timeFormatDeux: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }
    func timeStringDeux(date: Date) -> String {
        let time = timeFormatDeux.string(from: date)
        return time
    }
    var updateTimerDeux: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true,
                              block: {_ in
                                 self.date = Date()
                               })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


