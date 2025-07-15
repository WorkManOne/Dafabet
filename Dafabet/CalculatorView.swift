//
//  CalculatorView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var userService: UserService
    //@State var calculator: CalculatorModel = CalculatorModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            ScrollView {
                if userService.calculator.isCalculated {
                    VStack (alignment: .leading, spacing: 20) {
                        Text("Recommended Tension")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                        VStack (alignment: .leading) {
                            Text("Recommended Tension")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            Text("\(userService.calculator.recommendedTensionString) kg")
                                .font(.system(size: 30))
                                .foregroundStyle(.yellowMain)
                                .padding(.bottom, 2)
                            Text(userService.calculator.description)
                                .font(.system(size: 12))
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            LinearGradient(colors: [.redMain, .darkFrame], startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack (alignment: .leading, spacing: 15) {
                            Text("Benefits of This Tension")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.yellowMain)
                                Text(userService.calculator.playingStyle.benefit)
                                    .foregroundStyle(.white)
                            }
                            .font(.system(size: 14))
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.yellowMain)
                                Text(userService.calculator.playingConditions.benefit)
                                    .foregroundStyle(.white)
                            }
                            .font(.system(size: 14))
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.yellowMain)
                                Text(userService.calculator.skillLevel.benefit)
                                    .foregroundStyle(.white)
                            }
                            .font(.system(size: 14))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .darkFramed()
                        VStack (alignment: .leading) {
                            Text("Fine Tune Your Tension")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            HStack {
                                VStack {
                                    HoldableButton {
                                        userService.calculator.fineTuneBase -= 1
                                    } onHold: {
                                        userService.calculator.fineTuneBase -= 1
                                    } label: {
                                        Text("-")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.lightGray)
                                            .padding(20)
                                            .background(
                                                Circle()
                                                    .fill(.lightFrame)
                                            )
                                    }
                                    Text("Less Power More Control")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                Spacer()
                                VStack {
                                    Text(userService.calculator.fineTuneString)
                                        .font(.system(size: 20))
                                        .foregroundStyle(.black)
                                        .padding(20)
                                        .background(
                                            Circle()
                                                .fill(.yellowMain)
                                        )
                                    Text("g")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                Spacer()
                                VStack {
                                    HoldableButton {
                                        userService.calculator.fineTuneBase += 1
                                    } onHold: {
                                        userService.calculator.fineTuneBase += 1
                                    } label: {
                                        Text("+")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.lightGray)
                                            .padding(20)
                                            .background(
                                                Circle()
                                                    .fill(.lightFrame)
                                            )
                                    }
                                    Text("More Power Less Control")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .darkFramed()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 80)
                    .padding(.bottom, 200)
                    .transition(.asymmetric(insertion: .push(from: .top), removal: .push(from: .bottom)))
                } else {
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Your Player Profile")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                        VStack (alignment: .leading) {
                            Text("Skill Level")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            HStack {
                                Button {
                                    userService.calculator.skillLevel = .beginner
                                } label: {
                                    Text("Beginner")
                                        .font(.system(size: 14))
                                        .foregroundStyle(userService.calculator.skillLevel == .beginner ? .white : .lightGray)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(userService.calculator.skillLevel == .beginner ? .redMain : .lightFrame)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Button {
                                    userService.calculator.skillLevel = .intermediate
                                } label: {
                                    Text("Intermediate")
                                        .font(.system(size: 14))
                                        .foregroundStyle(userService.calculator.skillLevel == .intermediate ? .white : .lightGray)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(userService.calculator.skillLevel == .intermediate ? .redMain : .lightFrame)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Button {
                                    userService.calculator.skillLevel = .advanced
                                } label: {
                                    Text("Advanced")
                                        .font(.system(size: 14))
                                        .foregroundStyle(userService.calculator.skillLevel == .advanced ? .white : .lightGray)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(userService.calculator.skillLevel == .advanced ? .redMain : .lightFrame)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .darkFramed()
                        VStack (alignment: .leading) {
                            Text("Playing Style")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            HStack {
                                Button {
                                    userService.calculator.playingStyle = .powerPlayer
                                } label: {
                                    HStack {
                                        PlayingStyle.powerPlayer.image
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                        Text("Power Player")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(userService.calculator.playingStyle == .powerPlayer ? .white : .lightGray)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(userService.calculator.playingStyle == .powerPlayer ? .redMain : .lightFrame)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Button {
                                    userService.calculator.playingStyle = .controlPlayer
                                } label: {
                                    HStack {
                                        PlayingStyle.controlPlayer.image
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                        Text("Control Player")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(userService.calculator.playingStyle == .controlPlayer ? .white : .lightGray)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(userService.calculator.playingStyle == .controlPlayer ? .redMain : .lightFrame)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            HStack {
                                Button {
                                    userService.calculator.playingStyle = .allrounder
                                } label: {
                                    HStack {
                                        PlayingStyle.controlPlayer.image
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                        Text("All-Rounder")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(userService.calculator.playingStyle == .allrounder ? .white : .lightGray)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(userService.calculator.playingStyle == .allrounder ? .redMain : .lightFrame)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Button {
                                    userService.calculator.playingStyle = .finessePlayer
                                } label: {
                                    HStack {
                                        PlayingStyle.finessePlayer.image
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                        Text("Finesse Player")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(userService.calculator.playingStyle == .finessePlayer ? .white : .lightGray)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(userService.calculator.playingStyle == .finessePlayer ? .redMain : .lightFrame)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .darkFramed()
                        VStack (alignment: .leading) {
                            HStack {
                                Text("Bat Weight")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                Spacer()
                                Text("\(userService.calculator.batWeight)g")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.white)
                            }
                            CustomSlider(value: $userService.calculator.batWeight, range: 800...1500)
                            HStack {
                                Text("Light (800g)")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.lightGray)
                                Spacer()
                                Text("Heavy (1500g)")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.lightGray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .darkFramed()
                        VStack (alignment: .leading) {
                            Text("Typical Playing Conditions")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                            HStack {
                                Button {
                                    userService.calculator.playingConditions = .cold
                                } label: {
                                    VStack {
                                        PlayingConditions.cold.image
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                        Text("Cold")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(userService.calculator.playingConditions == .cold ? .white : .lightGray)
                                    .padding(.vertical, 15)
                                    .frame(maxWidth: .infinity)
                                    .background(userService.calculator.playingConditions == .cold ? .redMain : .lightFrame)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Button {
                                    userService.calculator.playingConditions = .moderate
                                } label: {
                                    VStack {
                                        PlayingConditions.moderate.image
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                        Text("Moderate")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(userService.calculator.playingConditions == .moderate ? .white : .lightGray)
                                    .padding(.vertical, 15)
                                    .frame(maxWidth: .infinity)
                                    .background(userService.calculator.playingConditions == .moderate ? .redMain : .lightFrame)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                Button {
                                    userService.calculator.playingConditions = .hot
                                } label: {
                                    VStack {
                                        PlayingConditions.hot.image
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                        Text("Hot")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundStyle(userService.calculator.playingConditions == .hot ? .white : .lightGray)
                                    .padding(.vertical, 15)
                                    .frame(maxWidth: .infinity)
                                    .background(userService.calculator.playingConditions == .hot ? .redMain : .lightFrame)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .darkFramed()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 80)
                    .padding(.bottom, 200)
                }
            }
            VStack {
                Spacer()
                Button {
                    withAnimation {
                        userService.calculator.fineTuneBase = 450
                        userService.calculator.isCalculated.toggle()
                    }
                } label: {
                    HStack {
                        Text(userService.calculator.isCalculated ? "Recalculate" : "Calculate")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.redMain)
                    )
                }
                .padding(.top)
                .padding(.bottom, 80)
                .darkFramed()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .customHeader(title: "String Tension Calculator")
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let nav = window.rootViewController?.children.first as? UINavigationController {
                nav.interactivePopGestureRecognizer?.isEnabled = true
                nav.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        .background(.backgroundMain)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    CalculatorView()
        .environmentObject(UserService())
}
