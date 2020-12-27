//
//  main.swift
//  SwiftLesson4
//
//  Created by Ниязов Ринат Раимжанович on 12/27/20.
//

import Foundation

enum CarType: String {
    case passenger = "Легковой трнаспорт"
    case trunk = "Грузовой транспорт"
}
enum FuelType {
    case electro, petrol, diesel
}
enum WindowsState {
    case open, close
}
enum GeneralState {
    case enabled, disabled
}
class Car {
    let carType: CarType
    let yearProd: Int
    let brand: String
    let model: String
    var trunkVolume: Float
    var filledTrunkVolume: Float
    var isWindowsOpened: Bool
    var isEngineRunning: Bool
    var engineState: GeneralState {
        willSet {
            if newValue == .enabled {
                isEngineRunning = true
                print("\(carType.rawValue) - \(brand) \(model): двигатель будет запущен")
            } else {
                isEngineRunning = false
                print("\(carType.rawValue) - \(brand) \(model): двигатель будет отключен")
            }
        }
    }

    var windowsState: WindowsState {
        willSet {
            if newValue == .open {
                isWindowsOpened = true
                print("\(carType.rawValue) - \(brand) \(model): окна открылись!")
            } else {
                isWindowsOpened = false
                print("\(carType.rawValue) - \(brand) \(model): окна закрылись!")
            }
        }
    }

    var cargoLoading: Float {
        willSet {
            if newValue + filledTrunkVolume <= trunkVolume {
                filledTrunkVolume += newValue
                print("\(carType.rawValue) - \(brand) \(model): будет погружен новый груз объемом \(newValue)кг, после останется \(trunkVolume - filledTrunkVolume)кг ")
            } else {
                print("\(carType.rawValue) - \(brand) \(model): недостаточно места, осталось \(trunkVolume - filledTrunkVolume)кг ")
            }
        }
    }

    init(carType: CarType, yearProd: Int, brand: String, model: String, trunkVolume: Float) {
        self.carType = carType
        self.yearProd = yearProd
        self.brand = brand
        self.model = model
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = 0
        isWindowsOpened = false
        isEngineRunning = false
        cargoLoading = 0
        windowsState = .close
        engineState = .disabled
    }

    func openWindows() {
        if isWindowsOpened != true {
            self.windowsState = .open
        } else {
            print("\(carType.rawValue) - \(brand) \(model): окна уже открыты")
        }
    }

    func closeWindows() {
        if isWindowsOpened != false {
            self.windowsState = .close
        } else {
            print("\(carType.rawValue) - \(brand) \(model): окна уже закрыты")
        }
    }

    func enableEngine() {
        if isEngineRunning != true {
            self.engineState = .enabled
        } else {
            print("\(carType.rawValue) - \(brand) \(model): двигатель уже запущен")
        }
    }
    func disableEngine() {
        if isEngineRunning != false {
            self.engineState = .disabled
        } else {
            print("\(carType.rawValue) - \(brand) \(model): двигатель уже отключен")
        }
    }

    func trunkVolumeInfo() {}
}

class SportCar : Car {
    let turbocharging: Bool

    init(turbocharging: Bool, yearProd: Int, brand: String, model: String, trunkVolume: Float) {
        self.turbocharging = turbocharging
        
        super.init(carType: .passenger ,yearProd: yearProd, brand: brand, model: model, trunkVolume: trunkVolume)
    }
    
    func turbochargingOn() {
        if turbocharging == true {
            if engineState == .enabled {
                print("\(brand)-\(model): турбонаддув активирован")
            }
            else {
                print("\(brand)-\(model): двигатель выключен, не возможно включить турбонаддув")
            }
        } else {
            print("\(brand)-\(model): В автомобиле нет функции турбонаддува")
        }
    }

    override func trunkVolumeInfo() {
        print("Автомобиль \(brand)-\(model) загружен на \(filledTrunkVolume) кг")
    }
}

class TrunkCar : Car {
    let trailer : Bool
    var trailerConnection : GeneralState {
        willSet {
            if newValue == .enabled {
                print("\(carType.rawValue) - \(brand) \(model): прицеп будет присоединен")
            }
            else {
                print("\(carType.rawValue) - \(brand) \(model): прицеп будет отсоединен")
            }
        }
    }

    init(trailer: Bool, yearProd: Int, brand: String, model: String, trunkVolume: Float) {
        self.trailer = trailer
        self.trailerConnection = .disabled
        
        super.init(carType: .trunk, yearProd: yearProd, brand: brand, model: model, trunkVolume: trailer == true ? trunkVolume : 0.0)
    }
    
    func connectTrailer(trunkVolume: Float) {
        if trailer == true {
            if trailerConnection == .disabled {
                trailerConnection = .enabled
                self.trunkVolume = trunkVolume
            } else {
                print("\(carType.rawValue) - \(brand) \(model): прицеп уже подключен!")
            }
        } else {
            print("\(carType.rawValue) - \(brand) \(model) не предзназначем для присоединения прицепа!")
        }
    }
    
    func disconnectTrailer() {
        if trailer == true {
            if trailerConnection == .enabled {
                trailerConnection = .disabled
            } else {
                print("\(carType.rawValue) - \(brand) \(model): в данный момент прицеп отсутствует!")
            }
        } else {
            print("\(carType.rawValue) - \(brand) \(model) не предзназначем для присоединения прицепа!")
        }
    }
    
    override func trunkVolumeInfo() {
        print("Грузовой автомобиль \(brand)-\(model) загружен на \(filledTrunkVolume) кг")
    }
}




var porsche = SportCar(turbocharging: true, yearProd: 2019, brand: "Porsche", model: "911", trunkVolume: 120)
var astonMartin = SportCar(turbocharging: false,yearProd: 2012, brand: "Aston Martin", model: "DB9", trunkVolume: 145)

var volkswagen = TrunkCar(trailer: true, yearProd: 2010, brand: "Volkswagen", model: "Tractor Trunk", trunkVolume: 0)
var man = TrunkCar(trailer: false, yearProd: 2014, brand: "MAN", model: "Titan", trunkVolume: 4200)


porsche.openWindows()
porsche.cargoLoading = 119
porsche.cargoLoading = 3
porsche.trunkVolumeInfo()
porsche.turbochargingOn()

astonMartin.enableEngine()
astonMartin.cargoLoading = 150
astonMartin.turbochargingOn()

volkswagen.enableEngine()
volkswagen.cargoLoading = 3000
volkswagen.connectTrailer(trunkVolume: 3750)
volkswagen.cargoLoading = 3000

man.closeWindows()
man.cargoLoading = 400
man.cargoLoading = 800
man.cargoLoading = 2000
man.cargoLoading = 800
man.trunkVolumeInfo()


print(porsche.brand, porsche.carType.rawValue, porsche.model)
print(astonMartin.brand, astonMartin.engineState, astonMartin.turbocharging)
print(volkswagen.brand, volkswagen.carType.rawValue, volkswagen.trailer, volkswagen.trailerConnection)
print(man.trunkVolume, man.trailer, man.carType.rawValue, man.trunkVolume)

