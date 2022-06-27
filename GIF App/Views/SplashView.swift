//
//  SplashView.swift
//  GIF App
//
//  Created by Apar256 on 27/06/22.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        VStack {
            if self.isActive {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                Image("Ic_splash")
                    .resizable()
                    .frame(width:100, height: 100, alignment: .center)
                Text("GIF Assignment App")
                    .font(Font.largeTitle)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
            
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
