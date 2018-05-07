#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтоЭлектроннаяПодписьВМоделиСервиса = ЭлектроннаяПодписьВМоделиСервисаБРОВызовСервера.ЭтоЭлектроннаяПодписьВМоделиСервиса();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	КриптографияЭДКОКлиент.ОтобразитьПредставлениеСертификата(
		ЭтоЭлектроннаяПодписьВМоделиСервиса, 
		Элементы.Сертификат, 
		Объект.Сертификаты,
		ЭтотОбъект,
		"СертификатПредставление");
	
КонецПроцедуры
	
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СертификатНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения(
		"СертификатНачалоВыбораЗавершение", ЭтотОбъект, Новый Структура("Элемент", Элемент));

	КриптографияЭДКОКлиент.ВыбратьСертификат(
		Оповещение, ЭтоЭлектроннаяПодписьВМоделиСервиса, Объект.Сертификаты, "AddressBook",, Истина);
		
КонецПроцедуры

&НаКлиенте
Процедура СертификатНачалоВыбораЗавершение(Результат, ВходящийКонтекст) Экспорт
	
	Элемент = ВходящийКонтекст.Элемент;
	
	Если Результат.Выполнено Тогда
		
		Объект.Сертификаты.Очистить();
		Если ТипЗнч(Результат.ВыбранноеЗначение) = Тип("Структура") Тогда
			НовСтр = Объект.Сертификаты.Добавить();
			НовСтр.Сертификат = Результат.ВыбранноеЗначение.Отпечаток;
		Иначе
			Для Каждого Стр Из Результат.ВыбранноеЗначение Цикл
				НовСтр = Объект.Сертификаты.Добавить();
				НовСтр.Сертификат = Стр.Отпечаток;
			КонецЦикла;
		КонецЕсли;
		
		КриптографияЭДКОКлиент.ОтобразитьПредставлениеСертификата(
			ЭтоЭлектроннаяПодписьВМоделиСервиса, 
			Элемент, 
			Объект.Сертификаты,
			ЭтотОбъект,
			"СертификатПредставление");

		Модифицированность = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СертификатОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Объект.Сертификаты.Очистить();
	КриптографияЭДКОКлиент.ОтобразитьПредставлениеСертификата(
		ЭтоЭлектроннаяПодписьВМоделиСервиса, 
		Элемент, 
		Объект.Сертификаты,
		ЭтотОбъект,
		"СертификатПредставление");
		
	Модифицированность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура СертификатОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Сертификаты = Новый Массив;
	Для Каждого СтрокаТаблицы Из Объект.Сертификаты Цикл
		Сертификаты.Добавить(Новый Структура("Отпечаток, ЭтоЭлектроннаяПодписьВМоделиСервиса", 
			СтрокаТаблицы.Сертификат, ЭтоЭлектроннаяПодписьВМоделиСервиса));
	КонецЦикла;
	
	КриптографияЭДКОКлиент.ПоказатьСертификат(Сертификаты);
	
КонецПроцедуры

#КонецОбласти