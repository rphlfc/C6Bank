//
//  MenuItem.swift
//  C6Bank
//
//  Created by Raphael Cerqueira on 05/01/21.
//

import Foundation

struct MenuItem: Identifiable, Equatable {
    let id = UUID().uuidString
    var image: String
    var title: String
}

let menuItems = [
    MenuItem(image: "list.bullet.rectangle", title: "Ver Extrato"),
    MenuItem(image: "creditcard", title: "Cartão"),
    MenuItem(image: "barcode", title: "Pagar"),
    MenuItem(image: "arrow.triangle.2.circlepath", title: "Recargas"),
    MenuItem(image: "arrow.left.arrow.right", title: "Transferir"),
    MenuItem(image: "calendar", title: "Trazer salário"),
    MenuItem(image: "dollarsign.circle", title: "Depositar"),
    MenuItem(image: "iphone.homebutton", title: "C6Kick"),
    MenuItem(image: "chart.bar.xaxis", title: "Investimentos"),
    MenuItem(image: "dollarsign.square", title: "Crédito"),
    MenuItem(image: "a.circle", title: "Átomos"),
    MenuItem(image: "bag", title: "C6 Store"),
    MenuItem(image: "calendar", title: "Débito Automático"),
    MenuItem(image: "headphones.circle", title: "Chat")
]
