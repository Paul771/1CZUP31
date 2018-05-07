
#Область СлужебныйПрограммныйИнтерфейс

// Обработчик формирования строки наименования позиции штатного расписания.
//
Процедура ПриЗаполненииНаименованияПозицииШтатногоРасписания(Форма, СтандартнаяОбработка) Экспорт
	
	Если Форма.Элементы.Найти("МестоВСтруктуреПредприятия") = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Форма.МестоВСтруктуреПредприятия.Подразделение) Тогда
		// Если управленческое подразделение не заполнено, сохраняем прежний порядок именования позиции.
		Возврат;
	КонецЕсли;
	
	Если Не Форма.ПолучитьФункциональнуюОпциюФормы("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") Тогда 
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	Объект = Форма.Объект; 
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Организация", Объект.Владелец);
	ДополнительныеПараметры.Вставить("МестоВСтруктуреПредприятия", Форма.МестоВСтруктуреПредприятия.Подразделение);
	
	Объект.Наименование = УправлениеШтатнымРасписаниемКлиентСервер.НаименованиеПозицииШтатногоРасписания(
		Объект.Подразделение, 
		Объект.Должность, 
		ДополнительныеПараметры)
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВыбратьУправленческуюПозициюИзСписка(Форма, АдресСпискаПодобранных) Экспорт 
	
	УправленческаяОрганизация = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.Организации.УправленческаяОрганизация");

	
	СтруктураОтбор = Новый Структура;
	СтруктураОтбор.Вставить("Владелец", УправленческаяОрганизация);
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Отбор", СтруктураОтбор);
	ПараметрыОткрытия.Вставить("РежимВыбора", Истина);
	ПараметрыОткрытия.Вставить("МножественныйВыбор", Истина);
	ПараметрыОткрытия.Вставить("СкрытьПанельВводаДокументов", Истина);
	ПараметрыОткрытия.Вставить("АдресСпискаПодобранных", АдресСпискаПодобранных);
	
	ОткрытьФорму("Справочник.ШтатноеРасписание.ФормаВыбора", ПараметрыОткрытия, Форма.Элементы.Позиции);
	
КонецПроцедуры

Процедура СписокСотрудниковПоОрганизационнойСтруктуре(Форма) Экспорт
	
	ЭлементыФормаПоОрганизационнойСтруктуре = Форма.Элементы.Найти("ФормаПоОрганизационнойСтруктуре");
	Если ЭлементыФормаПоОрганизационнойСтруктуре <> Неопределено
		И Не ЭлементыФормаПоОрганизационнойСтруктуре.Пометка Тогда
		
		ЭлементыФормаПоОрганизационнойСтруктуре.Пометка = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура НастроитьСписокОрганизационнойСтруктуры(Форма) Экспорт
	
	ЭлементыФормаПоОрганизационнойСтруктуре = Форма.Элементы.Найти("ФормаПоОрганизационнойСтруктуре");
	Если ЭлементыФормаПоОрганизационнойСтруктуре <> Неопределено Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ОрганизационнаяСтруктураТаблицаКонтекстноеМенюРежимПросмотра",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ОрганизационнаяСтруктураТаблицаКонтекстноеМенюРежимПросмотра",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ОрганизационнаяСтруктураТаблицаКонтекстноеМенюДерево",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ОрганизационнаяСтруктураТаблицаКонтекстноеМенюИерархическийСписок",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ОрганизационнаяСтруктураТаблицаКонтекстноеМенюСписок",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ОрганизационнаяСтруктураТаблицаКоманднаяПанель",
			"Видимость",
			Ложь);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура СписокСотрудниковОрганизационнаяСтруктураПриАктивизацииСтроки(Форма) Экспорт
	
	ЭлементыФормаПоОрганизационнойСтруктуре = Форма.Элементы.Найти("ФормаПоОрганизационнойСтруктуре");
	Если ЭлементыФормаПоОрганизационнойСтруктуре <> Неопределено Тогда
		
		Если  ЭлементыФормаПоОрганизационнойСтруктуре.Пометка
			И Форма.Элементы.ОрганизационнаяСтруктураТаблица.ВыделенныеСтроки.Количество() > 0 Тогда
			
			ОтборПоОрганизационнойСтруктуре = Неопределено;
			ОтборыПоОрганизационнойСтруктуре = ОбщегоНазначенияКлиентСервер.НайтиЭлементыИГруппыОтбора(
				Форма.Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор,
				,
				"ОтборПоОрганизационнойСтруктуре");
			
			Если ОтборыПоОрганизационнойСтруктуре.Количество() > 0 Тогда
				
				ОтборПоОрганизационнойСтруктуре = ОтборыПоОрганизационнойСтруктуре[0];
				ОтборыПоОрганизационнойСтруктуре.Элементы.Очистить();
				
			Иначе
				
				ОтборПоОрганизационнойСтруктуре = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(
					Форма.Список.КомпоновщикНастроек.ФиксированныеНастройки.Отбор.Элементы, "ОтборПоПодразделениям", ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
				
			КонецЕсли;
			
			ВыделенныеОрганизационныеСтруктуры = Новый Массив;
			Для каждого ВыделеннаяСтрока Из Форма.Элементы.ОрганизационнаяСтруктураТаблица.ВыделенныеСтроки Цикл
				ВыделенныеОрганизационныеСтруктуры.Добавить(ВыделеннаяСтрока);
			КонецЦикла;
			
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(
				ОтборПоОрганизационнойСтруктуре, "МестоВСтруктуреПредприятия", ВыделенныеОрганизационныеСтруктуры, ВидСравненияКомпоновкиДанных.ВСписке);
			
		Иначе
			
			ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(
				Форма.Список, , "ОтборПоОрганизационнойСтруктуре");
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
