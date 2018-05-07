
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Запись.ВидСтроки) Тогда 
		Запись.ВидСтроки = Параметры.ВидСтроки;
	КонецЕсли;
	
	ПредставлениеЗначения = Параметры.ПредставлениеЗначения;
	
	УстановитьСвойстваЭлементовФормы();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьСвойстваЭлементовФормы()
	
	Если ЗначениеЗаполнено(ПредставлениеЗначения) Тогда
		Заголовок = ПредставлениеЗначения;
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ЗначениеСтроки", "Заголовок", ПредставлениеЗначения);
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ВидСтроки", "Видимость", Не ЗначениеЗаполнено(Запись.ВидСтроки));
	
КонецПроцедуры

#КонецОбласти
