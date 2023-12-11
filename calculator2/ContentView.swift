//
//  ContentView.swift
//  calculator2
//
//  Created by 福岡蔦子 on 2023/12/11.
//

import SwiftUI

struct ContentView: View {
    let layout = [["C", "+-", "%", "/"],
                  ["7", "8", "9", "*"],
                  ["4", "5", "6", "-"],
                  ["1", "2", "3", "+"],
                  ["0", ".", "="]]
    @State var display = Decimal(0)
    @State var leftOperand = Decimal(0)
    @State var lastOperator = "="
    @State var forceZero = false
    
    var body: some View {
        VStack(spacing: 20) {
            /*Text("\(leftOperand as NSDecimalNumber)").font(.system(size: 64)).frame(maxWidth: .infinity, alignment: .trailing)
             Text(lastOperator).font(.system(size: 64)).frame(maxWidth: .infinity, alignment: .trailing)
             Text("\(display as NSDecimalNumber)").font(.system(size: 64)).frame(maxWidth: .infinity, alignment: .trailing)*/
            Text("\(((display == 0 && !forceZero) ? leftOperand : display) as NSDecimalNumber)").font(.system(size: 64)).frame(maxWidth: .infinity, alignment: .trailing)
            ForEach(layout.indices, id: \.self) { i in
                HStack(spacing: 20) {
                    ForEach(layout[i].indices, id: \.self) { j in
                        let text = layout[i][j]
                        let color = if j == layout[i].count - 1 {
                            Color.orange
                        } else if i == 0 {
                            Color.black
                        } else {
                            Color.gray
                        }
                        let action = {
                            if ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(text) {
                                display = display * 10 + Decimal(Int(text)!)
                            }
                            if ["+", "-", "*", "/", "="].contains(text) {
                                if !(display == 0 && !forceZero && lastOperator == "=") {
                                    if lastOperator == "+" {
                                        leftOperand += display
                                    } else if lastOperator == "-" {
                                        leftOperand -= display
                                    } else if lastOperator == "*" {
                                        leftOperand *= display
                                    } else if lastOperator == "/" {
                                        leftOperand /= display
                                    } else if lastOperator == "=" {
                                        leftOperand = display
                                    }
                                }
                                display = 0
                                lastOperator = text
                            }
                            if text == "0" {
                                forceZero = true
                            } else {
                                forceZero = false
                            }
                        }
                        if text == "0" {
                            Button(action: action) {
                                Text(text).frame(width: 140, height: 60)
                                    .background(color)
                                    .clipShape(RoundedRectangle(cornerRadius: .infinity))
                            }
                        } else {
                            Button(action: action) {
                                Text(text).frame(width: 60, height: 60)
                                    .background(color)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    ContentView()
}
