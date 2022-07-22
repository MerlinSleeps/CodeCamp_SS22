//
//  ModelData.swift
//  CofeeShop
//
//  Created by Yiyu Shi on 13.06.22.
//

import Foundation

var items1: [Item] = []
var histories: [History] = []
var boughtItems: [Item] = []
var currentUserId: String = ""
var itemPurchaseCount: [String:Int] = [:]
var itemPurchaseSumme: [String:Double] = [:]
var amountInTime: [String:Int] = [:]
var summeInTime: [String:Double] = [:]

//1d = 86400, 1week = 604800
var myTimeInterval: Int = 86400
