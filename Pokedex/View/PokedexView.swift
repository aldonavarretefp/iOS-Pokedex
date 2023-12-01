//
//  PokedexView.swift
//  Pokedex
//
//  Created by Aldo Yael Navarrete Zamora on 01/12/23.
//

import SwiftUI

class PokedexViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var pokemons: [Pokemon] = []
    @Published var timerIsActive = true
    @Published var timeElapsed: Int = 0
    
    let fetchTimer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    let pokeAPI = PokeAPI()
    let timerClock = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func timeString(time: Int) -> String {
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func fetchPokemon() {
        pokeAPI.fetchPokemon { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    withAnimation {
                        self.pokemons.append(pokemon)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct PokedexView: View {
    private let gridColumnItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    @StateObject private var vm: PokedexViewModel = PokedexViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(vm.timeString(time: vm.timeElapsed))
                            .font(.largeTitle)
                            .bold()
                            .onReceive(vm.timerClock) { val in
                                if vm.timerIsActive {
                                    DispatchQueue.main.async {
                                        vm.timeElapsed += 1
                                    }
                                }
                            }
                            .onReceive(vm.fetchTimer) { _ in
                                DispatchQueue.main.async {
                                    vm.isLoading = true
                                    vm.fetchPokemon()
                                    vm.isLoading = false
                                    vm.timeElapsed = 0
                                }
                            }
                            .padding(.leading, 10)
                        Spacer()
                        ShowPokemonButton()
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.secondary.opacity(0.2))
                        
                    )
                    
                    LazyVGrid(columns: gridColumnItems, spacing: 10, content: {
                        ForEach(vm.pokemons.reversed()) { pokemon in
                            
                            PokemonCard(pokemon: pokemon)
                        }
                    })
                }
                .padding()
            }
            .navigationTitle("Pokedex")
        }
        
    }
    @ViewBuilder
    private func ShowPokemonButton() -> some View {
        Button(action: {
            DispatchQueue.main.async {
                vm.isLoading = true
                vm.fetchPokemon()
                vm.isLoading = false
            }
        }, label: {
            Group {
                if vm.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(.white)
                } else {
                    Text("Mostrar pokemon")
                }
            }
            .customButtonModifier(withColor: .blue)
        })
        .disabled(vm.isLoading)
    }
    
    /// This button toggles the state of the timer between active and inactive
    @ViewBuilder
    private func StopTimerButton() -> some View {
        Button(action: {
            // TODO: Stop the timer.
        }, label: {
            Text(vm.timerIsActive ? "Detener el temporizador" : "Resumir el temporizador")
        })
        .customButtonModifier(withColor: vm.timerIsActive ? .blue : .red)
    }
}


#Preview {
    PokedexView()
}
