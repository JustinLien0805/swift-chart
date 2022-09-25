//
//  ContentView.swift
//  swift-chart
//
//  Created by 練家辰 on 2022/9/25.
//

import SwiftUI
import Charts

struct Item:Identifiable{
    var id = UUID()
    let type: String
    let value: Double
}

struct WeatherData: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double

    init(year: Int, month: Int, day: Int, temperature: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.temperature = temperature
    }
}

let londonWeatherData: [WeatherData] = [
                          WeatherData(year: 2021, month: 7, day: 1, temperature: 19.0),
                          WeatherData(year: 2021, month: 8, day: 1, temperature: 17.0),
                          WeatherData(year: 2021, month: 9, day: 1, temperature: 17.0),
                          WeatherData(year: 2021, month: 10, day: 1, temperature: 13.0),
                          WeatherData(year: 2021, month: 11, day: 1, temperature: 8.0),
                          WeatherData(year: 2021, month: 12, day: 1, temperature: 8.0),
                          WeatherData(year: 2022, month: 1, day: 1, temperature: 5.0),
                          WeatherData(year: 2022, month: 2, day: 1, temperature: 8.0),
                          WeatherData(year: 2022, month: 3, day: 1, temperature: 9.0),
                          WeatherData(year: 2022, month: 4, day: 1, temperature: 11.0),
                          WeatherData(year: 2022, month: 5, day: 1, temperature: 15.0),
                          WeatherData(year: 2022, month: 6, day: 1, temperature: 18.0)
]
let taipeiWeatherData: [WeatherData] = [
                          WeatherData(year: 2021, month: 7, day: 1, temperature: 32.0),
                          WeatherData(year: 2021, month: 8, day: 1, temperature: 33.0),
                          WeatherData(year: 2021, month: 9, day: 1, temperature: 27.0),
                          WeatherData(year: 2021, month: 10, day: 1, temperature: 23.0),
                          WeatherData(year: 2021, month: 11, day: 1, temperature: 18.0),
                          WeatherData(year: 2021, month: 12, day: 1, temperature: 13.0),
                          WeatherData(year: 2022, month: 1, day: 1, temperature: 16.0),
                          WeatherData(year: 2022, month: 2, day: 1, temperature: 15.0),
                          WeatherData(year: 2022, month: 3, day: 1, temperature: 21.0),
                          WeatherData(year: 2022, month: 4, day: 1, temperature: 28.0),
                          WeatherData(year: 2022, month: 5, day: 1, temperature: 29.0),
                          WeatherData(year: 2022, month: 6, day: 1, temperature: 33.0)
]
let NYWeatherData: [WeatherData] = [
                           WeatherData(year: 2021, month: 7, day: 1, temperature: 21),
                           WeatherData(year: 2021, month: 8, day: 1, temperature: 15.0),
                           WeatherData(year: 2021, month: 9, day: 1, temperature: 13.0),
                           WeatherData(year: 2021, month: 10, day: 1, temperature: 16.0),
                           WeatherData(year: 2021, month: 11, day: 1, temperature: 8.0),
                           WeatherData(year: 2021, month: 12, day: 1, temperature: 10.0),
                           WeatherData(year: 2022, month: 1, day: 1, temperature: 7.0),
                           WeatherData(year: 2022, month: 2, day: 1, temperature: 11.0),
                           WeatherData(year: 2022, month: 3, day: 1, temperature: 13.0),
                           WeatherData(year: 2022, month: 4, day: 1, temperature: 7.0),
                           WeatherData(year: 2022, month: 5, day: 1, temperature: 12.0),
                           WeatherData(year: 2022, month: 6, day: 1, temperature: 20.0)
 ]

struct ContentView: View {
    let fruit: [Item] = [
        Item(type: "apple", value: 43),
        Item(type: "banana", value: 23),
        Item(type: "orange", value: 20),
        Item(type: "watermelon", value: 50),
        Item(type: "kiwi", value: 34)
    ]
    
    let chartData = [ (city: "Hong Kong", data: NYWeatherData),
                      (city: "London", data: londonWeatherData),
                      (city: "Taipei", data: taipeiWeatherData) ]
    
    
    init() {
            
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Chart(fruit){ item in
                        BarMark(x: .value("fruit", item.type),
                                y: .value("quantity", item.value)
                        )
                        .foregroundStyle(Color.red.gradient)
                    }
                    .frame(height: 200)
                    .padding()
                    
                    Chart {
                        ForEach(chartData, id: \.city) { series in
                            ForEach(series.data) { item in
                                LineMark(
                                    x: .value("Month", item.date),
                                    y: .value("Temp", item.temperature)
                                )
                            }
                            .foregroundStyle(by: .value("City", series.city))
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .month)) { value in
                            AxisGridLine()
                            AxisValueLabel(format: .dateTime.month(.defaultDigits))
                        }
                    }
                    .frame(height: 200)
                    .padding()
                    
                    Chart(fruit){ item in
                        AreaMark(x: .value("fruit", item.type),
                                y: .value("quantity", item.value)
                        )
                        .foregroundStyle(Color.purple.gradient)
                    }
                    .frame(height: 200)
                    .padding()
                    
                    Chart {
                        ForEach(chartData, id: \.city) { series in
                            ForEach(series.data) { item in
                                PointMark(
                                    x: .value("Month", item.date),
                                    y: .value("Temp", item.temperature)
                                )
                            }
                            .foregroundStyle(by: .value("City", series.city))
                        }
                    }
                    .chartXAxis { // customize chartAxis
                        AxisMarks(values: .stride(by: .month)) { value in
                            AxisGridLine()
                            AxisValueLabel(format: .dateTime.month(.defaultDigits))
                        }
                    }
                    .frame(height: 200)
                    .padding()
                }
                .navigationTitle("Charts")
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
