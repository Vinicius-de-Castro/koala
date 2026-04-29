//
//  LogicKegel.swift
//  koala
//
//  Created by User on 27/04/26.
//

import Foundation
//Enum sobre o estado do Timer
enum TimerState: String{
    case idle
    case running
    case paused
    
}

enum TimerMode: String{
    case work
    case pause
}


class Timer{
    //O status do Timer(trabalhando ou pausa)
    private var _mode: TimerMode = .work
    private var _state: TimerState = .idle
    
    //Variáveis de tempo de trabalho e pausa
    private var _durationWork: TimeInterval
    private var _durationPause: TimeInterval
    
    //Variáveis de
    private var _secondPassed: Int = 0
    private var _fractionPassed: Double = 0.0
    
    
    
    private var _dateStarted: Int = 0
    private var _secondsPassedBeforePause: Int = 0
    private var _timer: Timer? = nil
    
    //Inicializei as variaveis
    init(workinSeconds:TimeInterval, pauseinSeconds: TimeInterval){
        _durationWork = workinSeconds
        _durationPause = pauseinSeconds
        
    }
    
    
    //Computed Properties
    
    var secondsPassed: Int{
        return _secondPassed
    }
    var secondsLeft: Int{
        Int(_duration) - _secondPassed
    }
    var secondsLeftString: Int{
        
    }
    var fractionPassed: Double{
        return _fractionPassed
    }
    var fractionLeft: Double{
        1.0 - _fractionPassed
    }
    
    var state: TimerState{
        _state
    }
    var mode: TimerMode{
        _mode
    }
    
    private var _duration: TimeInterval{
        if _mode == .work{
            return _durationWork
        } else{
            return _durationPause
        }
    }
    
 

    
    
    /////////////////////////////
    func start(){
        _dateStarted = 0
        _fractionPassed = 0.0
        _secondPassed = 0
        _state = .running
    }
    func resume(){
        _dateStarted = Date.now
        _state = .running
        _createTimer()
    }
    func pause(){
        _state = .paused
        _secondsPassedBeforePause = 0
        _KillTimer()
    }
    
    func reset(){
        //?
    }
    
    //Logica:
    func skip(){
        if self._mode == .work{
            self._mode = .pause //Se eu estou trabalhando agora, a func vai fazer a pausa segiuinte
        } else{
            self._mode = .work//Se o meu modo atual é pausa, então a func skip vai fazer .work para trabalhar.
        }
    }
    
    private func _KillTimer(){
        _timer?.invalidate()
        _timer = nil
    }
    private func _createTimer(){
         _timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in self._onTick()
        }
    }
    private func _onTick(){
        //Calcular os segundos desde o começo
        //work-pause-work
        var secondsSinceStartDate = Date.now.timeIntervalSince(self._dateStarted)
        self._secondPassed = Int (secondsSinceStartDate) + self._secondsPassedBeforePause
        self._fractionPassed = TimeInterval  (self._secondPassed) / self._durationWork
        
        if self.secondsLeft == 0{
            self.skip( )
            self.reset( )
        }
        

    }
    
    
    private func _formatSeconds(_ seconds: Int) -> String{
        if (seconds <= 0) {
            return "00:00"
        }
        let hours: Int = seconds % 3600
        let minute: Int = (seconds % 3600) / 60
        let ss: Int = seconds % 60 //Segundos
        if hours > 0 {
            return String(format:"%02d:%02d:%02d", hours, minute, ss)
        }else{
            return String(format: "%02d:%02d", minute, ss)
        }
      }
    }
