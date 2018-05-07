&НаКлиенте
Перем КонтекстЭДОКлиент;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	АдресФайла = Параметры.АдресФайла;
	Если Не ЗначениеЗаполнено(АдресФайла) Тогда
		Возврат;
	КонецЕсли;
	
	КонтекстЭДОСервер = ДокументооборотСКОВызовСервера.ПолучитьОбработкуЭДО();
	ДанныеСверки      = КонтекстЭДОСервер.РазборАктаСверкиВФорматеXML(АдресФайла);
	АдресДанныхСверки = ПоместитьВоВременноеХранилище(ДанныеСверки, УникальныйИдентификатор);
	Если ДанныеСверки.Количество() > 0 Тогда
		
		ПерваяИтерация = Истина;
		Для Каждого СтрокаСверки Из ДанныеСверки Цикл
			
			ИндексСверки = ДанныеСверки.Индекс(СтрокаСверки);
			Если Не ПерваяИтерация Тогда
				АктСверки.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;
			ПерваяИтерация = Ложь;
			АктСверки.Вывести(
				КонтекстЭДОСервер.ПолучитьТабличноеПредставление(СтрокаСверки, ИндексСверки));
		
		КонецЦикла;
		
	Иначе
		
		МакетСверки = КонтекстЭДОСервер.ПолучитьМакет("АктСверкиСФНС");
		ОбластьНетДанных = МакетСверки.ПолучитьОбласть("ДанныеОтсутствуют");
		АктСверки.Вывести(ОбластьНетДанных);
		
	КонецЕсли;
	АктСверки.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Инициализируем контекст формы - контейнера клиентских методов
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриОткрытииЗавершение", ЭтотОбъект);
	ДокументооборотСКОКлиент.ПолучитьКонтекстЭДО(ОписаниеОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура АктСверкиТаблицаОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму(КонтекстЭДОКлиент.ПутьКОбъекту + ".Форма.ФормаРасшифровкиАктаСверкиСФНС",
		Новый Структура("АдресДанныхСверки, НомерСтрокиСверки", АдресДанныхСверки, Расшифровка),
		ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	КонтекстЭДОКлиент = Результат.КонтекстЭДО;
	Если КонтекстЭДОКлиент = Неопределено Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
