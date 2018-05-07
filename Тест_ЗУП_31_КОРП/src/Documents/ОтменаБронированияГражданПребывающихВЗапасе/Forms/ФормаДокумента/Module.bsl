
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Ключ.Пустая() Тогда
		
		// Создается новый документ.
		ЗначенияДляЗаполнения = Новый Структура("Организация, Ответственный", "Объект.Организация", "Объект.Ответственный");
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
		
		ПриПолученииДанныхНаСервере();
		
	КонецЕсли;
	
	// Обработчик подсистемы "ВерсионированиеОбъектов".
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужбаФормы");
		Модуль.УстановитьПараметрыВыбораСотрудников(ЭтаФорма, "СотрудникиСотрудник");
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	ПриПолученииДанныхНаСервере();
	
	ОбменДаннымиЗарплатаКадры.ПриЧтенииНаСервереДокумента(ЭтотОбъект, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_ОтменаБронированияГражданПребывающихВЗапасе", ПараметрыЗаписи, Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	ДатаПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыСотрудники

&НаКлиенте
Процедура СотрудникиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтруктураПоиска = Новый Структура("ФизическоеЛицо");
	МассивФизЛицКЗаполнению = Новый Массив;
	
	Для Каждого ФизическоеЛицо Из ВыбранноеЗначение Цикл
		СтруктураПоиска.ФизическоеЛицо = ФизическоеЛицо;
		Если Объект.Сотрудники.НайтиСтроки(СтруктураПоиска).Количество() = 0 Тогда 
			МассивФизЛицКЗаполнению.Добавить(ФизическоеЛицо);	
		КонецЕсли;
	КонецЦикла;	
	
	Для Каждого ФизическоеЛицо Из МассивФизЛицКЗаполнению Цикл 
		
		НоваяСтрока = Объект.Сотрудники.Добавить();
		НоваяСтрока.ФизическоеЛицо = ФизическоеЛицо;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура Подбор(Команда)
	
	Отбор = Новый Структура;
	Отбор.Вставить("ДатаПримененияОтбора", Объект.Дата);
	Отбор.Вставить("ВАрхиве", Ложь);
	Отбор.Вставить("Ссылка", МассивФизическихЛиц);
		
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Отбор", Отбор);
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("ГосударственнаяСлужбаКлиент");
		Модуль.УточнитьПараметрыОткрытияФормыВыбораСотрудников(ПараметрыОткрытия);
	КонецЕсли; 
	
	КадровыйУчетКлиент.ВыбратьФизическихЛицОрганизации(Элементы.Сотрудники, Объект.Организация, Истина, , АдресСпискаПодобранныхСотрудников(), ,ПараметрыОткрытия);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриПолученииДанныхНаСервере()
	
	ЗаполнитьМассивДоступныхФизическихЛиц();
	УстановитьПараметрыВыбораФизическихЛиц();
	
КонецПроцедуры

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	
	ЗаполнитьМассивДоступныхФизическихЛиц();
	УстановитьПараметрыВыбораФизическихЛиц();
	
КонецПроцедуры

&НаСервере
Процедура ДатаПриИзмененииНаСервере()
	
	ЗаполнитьМассивДоступныхФизическихЛиц();
	УстановитьПараметрыВыбораФизическихЛиц();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьМассивДоступныхФизическихЛиц()
	
	ФизическиеЛица = Новый Массив;
	
	Если ЗначениеЗаполнено(Объект.Организация) Тогда 
		
		МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		
		ИзмеренияДаты = Новый ТаблицаЗначений;
		ИзмеренияДаты.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
		
		НоваяСтрока = ИзмеренияДаты.Добавить();
		НоваяСтрока.Период = Объект.Дата;
		
		ПараметрыПостроения = ЗарплатаКадрыОбщиеНаборыДанных.ПараметрыПостроенияДляСоздатьВТИмяРегистраСрез();
		
		ЗарплатаКадрыОбщиеНаборыДанных.СоздатьВТИмяРегистраСрезПоследних(
			"БронированиеСотрудников",
			МенеджерВременныхТаблиц,
			Ложь,
			ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеФильтраДляСоздатьВТИмяРегистра(ИзмеренияДаты),
			ПараметрыПостроения);
		
		Запрос = Новый Запрос;
		
		Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
		
		Запрос.УстановитьПараметр("Организация", Объект.Организация);
		
		Запрос.Текст = "ВЫБРАТЬ
		               |	БронированиеСотрудников.ФизическоеЛицо
		               |ИЗ
		               |	ВТБронированиеСотрудниковСрезПоследних КАК БронированиеСотрудников
		               |ГДЕ
		               |	БронированиеСотрудников.Организация = &Организация";
					   
		Выборка = Запрос.Выполнить().Выбрать();
		Пока Выборка.Следующий() Цикл 
			ФизическиеЛица.Добавить(Выборка.ФизическоеЛицо);
		КонецЦикла;
		
	КонецЕсли;
	
	МассивФизическихЛиц = Новый ФиксированныйМассив(ФизическиеЛица);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыВыбораФизическихЛиц()
	
	ПараметрыДляВыбора = Новый Массив;
	ПараметрВыбора = Новый ПараметрВыбора("Отбор.Ссылка", МассивФизическихЛиц);
	ПараметрыДляВыбора.Добавить(ПараметрВыбора);
	
	Элементы.СотрудникиСотрудник.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыДляВыбора);
	
КонецПроцедуры

&НаСервере
Функция АдресСпискаПодобранныхСотрудников()
	
	Возврат ПоместитьВоВременноеХранилище(ОбщегоНазначения.ВыгрузитьКолонку(Объект.Сотрудники, "ФизическоеЛицо"), УникальныйИдентификатор);
	
КонецФункции

#КонецОбласти
