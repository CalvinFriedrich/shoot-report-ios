import SwiftUI

struct ProcedureShot: View {
    
    @State var during: String = ""
    
    var rifle: Rifle
    
    var body: some View {
        Form {
            Section(header:
                        Text(LocalizedStringKey("procedure_during_section"))
                        .foregroundColor(Color("accentColor"))
                        .bold()
                        .textCase(nil)) {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("procedure_during_title"))
                    TextEditor(text: $during)
                        .onChange(of: during) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "procedure_during_\(rifle.order)")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                        .ignoresSafeArea(.keyboard)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            self.during = UserDefaults.standard.string(forKey: "procedure_during_\(rifle.order)") ?? ""
        })
    }
}

struct ProcedureShot_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureShot(rifle: Rifle())
    }
}
