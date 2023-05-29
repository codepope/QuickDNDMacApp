//
//  QuickDnDMacApp.swift
//  QuickDnDMacApp
//
//  Created by Dj Walker-Morgan on 02/05/2023.
//

import SwiftUI

@main
struct QuickDnDMacApp: App {
  
  @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
  
  var body: some Scene {
    WindowGroup {
      ContentView().frame(width: 300,height: 300)
    }
    
    MenuBarExtra(
      "App Menu Bar Extra", systemImage: "star",
      isInserted: $showMenuBarExtra)
      {
        AppMenu()
      }
  }
  
}


struct AppMenu: View {
    func action1() {}
    func action2() {}
    func action3() {}

    @State var status=0
  
  var body: some View {
    Button {
      //send(v:"off")
    } label: {
      if status==0 {
        Label("Off",systemImage:"power.circle.fill")
      } else {
        Label("Off",systemImage:"power.circle")
      }
    }.buttonStyle(StateButtonStyle())
    
    Button {
      //send(v:"clear")
    } label: {
      if status==1 {
        Label("Clear",systemImage:"clear.fill")
      } else {
        Label("Clear",systemImage:"clear")
        
      }
    }.buttonStyle(StateButtonStyle())
    
    Button {
      //send(v:"enter")
    } label: {
      if status==2 {
        Label("Enter",systemImage:"door.right.hand.open")
      } else {
        Label("Enter",systemImage:"door.right.hand.closed")
      }
    }.buttonStyle(StateButtonStyle())
    
    Button {
      //send(v:"dnd")
    } label: {
      if status==3 {
        Label("Do Not Disturb",systemImage:"triangle.inset.filled")
      } else {
        Label("Do Not Disturb",systemImage:"triangle.fill")
      }
    }.buttonStyle(StateButtonStyle())
  }
}


