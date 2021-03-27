uses ArduinoUno; //Подключаем модуль ArduinoUno
uses Crt;
begin

var Uno := new Arduino; //Создаем экземпляр класса Arduino. Производится последовательное соединение с платой.
Uno.Pin(11).SetMode(AnalogOutput);
var state: pinstate;
Uno.Pin(13).SetMode(DigitalOutput); //Устанавливаем режим 13 пина как цифровой выход

repeat

Uno.Pin(13).SetState(true); //Устанавливаем на 13 пин значение HIGH

state := Uno.Pin(13).GetState(); //Считываем состояние и значение пина 13 и записываем в переменную state
println(state); //Печатаем результат

delay(1000);

Uno.Pin(13).SetState(false); //Устанавливаем на 13 пин значение LOW

state := Uno.Pin(13).GetState();
println(state);

delay(1000);


Uno.Pin(11).SetState(360);
delay(500);
Uno.Pin(11).SetState(0);
delay(500);

until KeyPressed; 

end. 