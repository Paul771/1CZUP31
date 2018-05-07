#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ПриЗаписи(Отказ)

	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтотОбъект.Значение = Ложь Тогда
		Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.РасчетЗарплатыДляНебольшихОрганизаций") Тогда
			МодульРасчетЗарплатыДляНебольшихОрганизаций = ОбщегоНазначения.ОбщийМодуль("РасчетЗарплатыДляНебольшихОрганизацийСобытия");
			МодульРасчетЗарплатыДляНебольшихОрганизаций.ПриОтключенииНачисленияЗарплаты();
		КонецЕсли;
	КонецЕсли; 
	
	УчетПособийСоциальногоСтрахования.ПриЗаписиКонстантыИспользоватьНачислениеЗарплаты(ЭтотОбъект);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыРасширеннаяПодсистемы.РасчетЗарплатыРасширенная") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("РасчетЗарплатыРасширенный");
		Модуль.УстановитьПараметрыНабораСвойствВидыДокументовВводДанныхДляРасчетаЗарплаты();
	КонецЕсли;
КонецПроцедуры

#КонецЕсли
