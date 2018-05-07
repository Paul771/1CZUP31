#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Процедура ПриЗаписи(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтотОбъект.Значение И Не ПолучитьФункциональнуюОпцию("ИспользоватьБизнесПроцессыИЗадачи") Тогда
		
		УстановитьПривилегированныйРежим(Истина);
		Константы.ИспользоватьБизнесПроцессыИЗадачи.Установить(Истина);
		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЕсли;
	
	АдаптацияУвольнение.УстановитьПараметрыНабораСвойствМероприятияАдаптацииУвольнения();
	АдаптацияУвольнение.УстановитьПараметрыНабораСвойствДокументовАдаптацииУвольнения();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
