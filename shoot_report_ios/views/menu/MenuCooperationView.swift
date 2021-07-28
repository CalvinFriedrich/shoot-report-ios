import SwiftUI

struct MenuCooperationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("cooperation_section"))) {
                    HStack {
                        Spacer()
                        Link(destination: URL(string: "https://www.kksvillingen.de")!) {
                            Image("adVerein")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        Spacer()
                    }
                }
                
                Section(header: Text(LocalizedStringKey("cooperation_bePartner"))) {
                    HStack {
                        Spacer()
                        Button {
                            openURL(URL(string: "https://www.burkhardt-sport.solutions/kontakt")!)
                        } label: {
                            Text(LocalizedStringKey("partner_buttonContact"))
                                .bold()
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                    }
                    .listRowBackground(Color("accentColor"))
                }
            }
            .navigationBarTitle(LocalizedStringKey("partner_thanks"))
            .navigationBarItems(
                trailing:
                    Button(LocalizedStringKey("general_close"), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
            )
        }
    }
}

struct MenuCooperationView_Previews: PreviewProvider {
    static var previews: some View {
        MenuCooperationView()
    }
}
