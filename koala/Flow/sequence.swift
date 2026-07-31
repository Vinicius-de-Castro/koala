import SwiftUI
struct sequence: View {
    var routine: Routine

    var body: some View {
        let length = routine.length
        let textColor: Color = (routine.type == .kegel ? Color.kegelDark : Color.stretchDark)

        HStack {
            Image("\(routine.moveset[0].image)")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
            VStack(alignment: .leading, spacing: 10) {
                Text("\(routine.moveset[0].name)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(textColor)
                    .frame(maxWidth: 200, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Image(systemName: "clock")
                        .foregroundStyle(Color.secondary)
                        .font(.title2)
                    Text(String(Int(length/60)) + (Int(length/60) > 1 ? " minutos" : " minuto"))
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(textColor)
                        .frame(maxWidth: 200, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

#Preview {
    if let routine = Memory.routines["MORNING_STRETCH"] {
        sequence(routine: routine)
    }
}
