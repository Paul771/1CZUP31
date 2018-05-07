&НаКлиенте
Перем КонтекстЭДОКлиент Экспорт;

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Параметры.РежимВыбора Тогда
		Элементы.СписокКнопкаВыбрать.Видимость = Истина;
		Элементы.СписокКнопкаВыбрать.КнопкаПоУмолчанию = Истина;
	Иначе
		Элементы.СписокКнопкаВыбрать.Видимость = Ложь;
	КонецЕсли;
	
	// инициализируем контекст формы - контейнера клиентских методов
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриОткрытииЗавершение", ЭтотОбъект);
	
	ДокументооборотСКОКлиент.ПолучитьКонтекстЭДО(ОписаниеОповещения);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Параметры.РежимВыбора Тогда
		СтандартнаяОбработка = Ложь;
		ОповеститьОВыборе(ВыбраннаяСтрока);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура СписокПриИзменении(Элемент)
	Оповестить("ИзменениеНастроекЭДООрганизации");
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьТакском(Команда)
	
	ОткрытьФорму(КонтекстЭДОКлиент.ПутьКОбъекту + ".Форма.РОКИМастерАвтонастройкиНовойУчетнойЗаписи");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаРучнаяНастройка(Команда)
	
	ОткрытьФорму("Справочник.УчетныеЗаписиДокументооборота.ФормаОбъекта");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтобразитьСписокЗаявлений(Команда)
	ОткрытьФорму("Документ.ЗаявлениеАбонентаСпецоператораСвязи.ФормаСписка");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЗаявление(Команда)
	
	ДополнительныеПараметры = ДокументооборотСКОКлиентСервер.ПараметрыОткрытияМастера();
	ДополнительныеПараметры.Вставить("РучнойВвод", Истина);
	КонтекстЭДОКлиент.ОткрытьФормуЗаявления(ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЗаявлениеМастер(Команда)
	
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиент.ОткрытьФормуМастераЗаявленияНаПодключение(, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ВосстановлениеУчетнойЗаписи(Команда)
	
	ОткрытьФорму(КонтекстЭДОКлиент.ПутьКОбъекту + ".Форма.ВосстановлениеУчетнойЗаписи");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСписокВыбрать(Команда)
	
	ОповеститьОВыборе(Элементы.Список.ТекущаяСтрока);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	КонтекстЭДОКлиент = Результат.КонтекстЭДО;
	
КонецПроцедуры

#КонецОбласти

