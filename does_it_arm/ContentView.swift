//
//  ContentView.swift
//  does_it_arm
//
//  Created by Michele Marcucci on 21/04/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
    let apps = getdir()
    @State private var selectedApp = ""
    
    var body: some View {
        VStack {
            Text(setTitle(arg: getresult(arg: self.selectedApp)[1]))
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .frame(width: 400, height: 80.0).animation(.linear)
            //Label("Your account", systemImage: "person.crop.circle")
            
            Picker("Select from these apps:", selection: $selectedApp) {
                ForEach(apps, id: \.self) {
                    Text($0)
                }
            }.frame(width: 350.0)
        }
        
        VStack(alignment: .leading){
            Text("Result for") + Text(" \(selectedApp)").bold() + Text(": \(getresult(arg: selectedApp)[0]) ")
        }.frame(height: 50.0).animation(.linear)
        
        VStack(alignment: .leading){
            Link(destination: URL(string: "https://www.github.com/mik3sw/doesitarm")!, label: {
                Text("Github")
                Image("Octocat")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
            .frame(height: 50.0)
        }.frame(alignment: .top)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(height: 100.0)
            .previewLayout(.sizeThatFits)
    }
}
