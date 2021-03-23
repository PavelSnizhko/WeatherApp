//
//  AlertWrapper.swift
//  WeatherApp
//
//  Created by Павел Снижко on 22.03.2021.
//

import SwiftUI

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  let alert: TextAlert
  let content: Content

  func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
    UIHostingController(rootView: content)
  }

  final class Coordinator {
    var alertController: UIAlertController?
    init(_ controller: UIAlertController? = nil) {
       self.alertController = controller
    }
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator()
  }

  func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
    uiViewController.rootView = content
    if isPresented && uiViewController.presentedViewController == nil {
      var alert = self.alert
      alert.action = {
        self.isPresented = false
        self.alert.action($0)
      }
      context.coordinator.alertController = UIAlertController(alert: alert)
      uiViewController.present(context.coordinator.alertController!, animated: true)
    }
    if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
      uiViewController.dismiss(animated: true)
    }
  }
}



//HOW to use

//@State private var showDialog = false
//
//var body: some View {
//  VStack {
//    Text("Some text")
//  }.alert(isPresented: $showDialog,
//            TextAlert(title: "Title",
//                          message: "Message",
//                          keyboardType: .numberPad) { result in
//              if let text = result) {
//                // Text was accepted
//              } else {
//                // The dialog was cancelled
//              }
//            })
//}
