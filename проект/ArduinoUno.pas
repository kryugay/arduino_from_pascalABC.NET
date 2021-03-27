{$reference 'Solid.Arduino.dll'}
unit ArduinoUno;

interface

///Последовательное соединение с Arduino
type ardSession = Solid.Arduino.ArduinoSession;
///Режим пина
type Pmode = Solid.Arduino.Firmata.PinMode;
///Состояние пина
type pinstate = Solid.Arduino.Firmata.PinState;

///Режимы пина
type mode = (DigitalOutput, DigitalInput, AnalogInput, AnalogOutput);
///Состояния пина
type state = (HIGH, LOW);

///Класс для работы с ArduinoUno
Arduino = class
  private
    ///Последовательное соединение с Arduino
    _conn : ardSession;
    ///Номер пина
    pinNumber : integer;
    ///Процедура для установки номера пина
    procedure PinNS(index : integer);
  
  public
    ///Конструктор класса Arduino для установки соединения
    constructor Create();
    ///Функция для установки номера пина
    function Pin(index : integer): Arduino;
    ///Процедура для установки режима пина
    procedure SetMode(_mode: mode);
    ///Процедура для установки цифрового состояния пина
    procedure SetState(_state: state);
    ///Процедура для установки цифрового состояния пина
    procedure SetState(_state: boolean);
    ///Процедура для установки аналогового состояния пина
    procedure SetState(_state: integer);
    ///Функция для считывания режима и состояния пина
    function GetState(): pinstate;

end;

implementation

procedure Arduino.PinNS(index : integer);
begin
  pinNumber := index;
end;

constructor Arduino.Create();
begin
  _conn := new ardSession(Solid.Arduino.EnhancedSerialConnection.Find());
end;

function Arduino.Pin(index : integer): Arduino;
begin
  self.PinNS(index);
  Result := self;
end;

procedure Arduino.SetMode(_mode: mode);
begin
  case _mode of
    mode.DigitalOutput : _conn.SetDigitalPinMode(pinNumber, Pmode.DigitalOutput);
    mode.DigitalInput : _conn.SetDigitalPinMode(pinNumber, Pmode.DigitalInput);
    mode.AnalogOutput : _conn.SetDigitalPinMode(pinNumber, Pmode.ServoControl);
    mode.AnalogInput : _conn.SetDigitalPinMode(pinNumber, Pmode.AnalogInput);
  end;
  
end;

procedure Arduino.SetState(_state: state);
begin
  case _state of
    state.HIGH : _conn.SetDigitalPin(pinNumber, true);
    state.LOW : _conn.SetDigitalPin(pinNumber, false);
  end;
end;

procedure Arduino.SetState(_state: boolean);
begin
  _conn.SetDigitalPin(pinNumber, _state);
end;

procedure Arduino.SetState(_state: integer);
begin
  _conn.SetDigitalPin(pinNumber, _state);
end;

function Arduino.GetState(): pinstate;
begin
  Result := _conn.GetPinState(pinNumber);
end;

end.