
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Параметры.ПредставлениеСписка) Тогда 
		Заголовок = Параметры.ПредставлениеСписка;
	КонецЕсли;
	 
	ВидСтроки = Параметры.ВидСтроки;
	ПредставлениеЗначения = Параметры.ПредставлениеЗначения;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ФормаВыбрать", "Видимость", ЗначениеЗаполнено(ВидСтроки));
	
	Если ЗначениеЗаполнено(ВидСтроки) Тогда 
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка( 
			Список, "ВидСтроки", ВидСтроки, ВидСравненияКомпоновкиДанных.Равно, , Истина);
	КонецЕсли;
	
	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если ЗначениеЗаполнено(ВидСтроки) Тогда
		СтандартнаяОбработка = Ложь;
		ВыбратьЗначение(Элемент.ТекущиеДанные.ЗначениеСтроки);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Не Копирование И ЗначениеЗаполнено(ВидСтроки) Тогда
		
		Отказ = Истина;
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ВидСтроки", ВидСтроки);
		ПараметрыФормы.Вставить("ПредставлениеЗначения", ПредставлениеЗначения);
		
		ОткрытьФорму("РегистрСведений.ЗначенияСтроковыхРеквизитов.ФормаЗаписи", ПараметрыФормы, ЭтотОбъект);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломИзменения(Элемент, Отказ)
	
	Если ЗначениеЗаполнено(ВидСтроки) Тогда
		
		Отказ = Истина;
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Ключ", Элемент.ТекущаяСтрока);
		ПараметрыФормы.Вставить("ВидСтроки", ВидСтроки);
		ПараметрыФормы.Вставить("ПредставлениеЗначения", ПредставлениеЗначения);
		
		ОткрытьФорму("РегистрСведений.ЗначенияСтроковыхРеквизитов.ФормаЗаписи", ПараметрыФормы, ЭтотОбъект);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, Настройки);
	
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, , СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ВыбратьЗначение(ТекущиеДанные.ЗначениеСтроки);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьЗначение(ЗначениеСтроки)
	
	ОповеститьОВыборе(ЗначениеСтроки);
	
КонецПроцедуры

#КонецОбласти
