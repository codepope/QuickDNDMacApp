//
//  StatusController.swift
//  QuickDnDMac
//
//  Created by Dj Walker-Morgan on 20/05/2023.
//

import Foundation
import SwiftUI
import CocoaMQTT

class StatusController: ObservableObject {
  static let shared = StatusController()
  
  let mqttClient = CocoaMQTT(clientID: "dndbuttonswift-" + String(ProcessInfo().processIdentifier), host: "jonah.local", port: 1883)
//  @Published var statusitems=[String]()
  @Published var connected = false
  @Published var status = -1
  
  private init() {}
  
  func connect() {
              self.mqttClient.username = "dnd"
              self.mqttClient.password = "dnd"
              self.mqttClient.autoReconnect=true
              self.mqttClient.keepAlive = 60
              _ = self.mqttClient.connect()
              self.mqttClient.didConnectAck = { _, _ in
                  print("Connected")
                  self.connected=true
                  self.mqttClient.subscribe("dnd/0001/status")
                  self.mqttClient.didReceiveMessage = {
                      _, message, _ in
                      print(message.payload)
                      let newstatus=String(bytes:message.payload,encoding:.utf8)
                      switch (newstatus) {
                      case "off":
                          self.status = 0
                      case "clear":
                          self.status = 1
                      case "enter":
                          self.status = 2
                      case "dnd":
                          self.status = 3
                      default:
                          self.status = -1
                      }
                  }
                  self.mqttClient.didDisconnect = {
                      _, error in
                    self.connected=false
                  }
              }
          }
  
  
  func send(v:String) {
      if !connected {
          self.connect()
      }
      self.mqttClient.publish("dnd/0001/status", withString:v, qos: .qos1, retained: true)
  }
  
}
