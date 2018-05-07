#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ТолькоПроведенные") И Параметры.ТолькоПроведенные Тогда
		Параметры.Отбор.Вставить("Проведен", Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаДокумента.
//
Функция ОписаниеСоставаДокумента() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.ВедомостьНаВыплатуЗарплатыВКассу;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаДокументаПоМетаданнымФизическиеЛицаВТабличныхЧастях(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

Процедура ЗаполнитьПериодыВзаиморасчетовЗарплаты() Экспорт
	ВзаиморасчетыССотрудниками.ЗаполнитьПериодыВзаиморасчетовЗарплатыВедомости(Метаданные.Документы.ВедомостьНаВыплатуЗарплатыВКассу.ПолноеИмя());
КонецПроцедуры

Процедура ЗаполнитьФизическиеЛицаЗарплаты() Экспорт
	ВзаиморасчетыССотрудниками.ЗаполнитьФизическиеЛицаЗарплатыВедомости(Метаданные.Документы.ВедомостьНаВыплатуЗарплатыВКассу.ПолноеИмя());
КонецПроцедуры

Процедура ЗаполнитьСостав() Экспорт
	ВзаиморасчетыССотрудниками.ЗаполнитьСоставВедомости(Метаданные.Документы.ВедомостьНаВыплатуЗарплатыВКассу.ПолноеИмя(), "ФизическоеЛицо");
КонецПроцедуры	

#КонецОбласти

Функция РеквизитыОтветственныхЛиц() Экспорт
	
	РеквизитыОтветственныхЛиц = ВзаиморасчетыССотрудниками.ВедомостьРеквизитыОтветственныхЛиц();
	
	РеквизитыОтветственныхЛиц.Добавить("Кассир");
	РеквизитыОтветственныхЛиц.Добавить("ДолжностьКассира");
	
	Возврат РеквизитыОтветственныхЛиц
	
КонецФункции	

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	ВзаиморасчетыССотрудникамиВнутренний.ВедомостьВКассуДобавитьКомандыПечати(КомандыПечати)	
КонецПроцедуры

// Формирует печатные формы
//
// Параметры:
//  (входные)
//    МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//    ПараметрыПечати - Структура - дополнительные настройки печати;
//  (выходные)
//   КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы.
//   ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                             представление - имя области в которой был выведен объект;
//   ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	ВзаиморасчетыССотрудникамиВнутренний.ВедомостьВКассуПечать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода)
КонецПроцедуры

// Формирует запрос по документу.
//
// Параметры: 
//  Ведомости - массив ДокументСсылка.ВедомостьНаВыплатуЗарплатыВБанк.
//
// Возвращаемое значение:
//  Результат запроса
//
Функция ВыборкаДляПечатиШапки(Ведомости) Экспорт
	Возврат ВзаиморасчетыССотрудникамиВнутренний.ВедомостьВКассуВыборкаДляПечатиШапки(Метаданные.Документы.ВедомостьНаВыплатуЗарплатыВКассу.ПолноеИмя(), Ведомости)
КонецФункции

// Формирует запрос по табличной части документа.
//
// Параметры: 
//  Ведомости - массив ДокументСсылка.ВедомостьНаВыплатуЗарплатыВБанк.
//
// Возвращаемое значение:
//  Выборка из результата запроса.
//
Функция ВыборкаДляПечатиТаблицы(Ведомости) Экспорт
	Возврат ВзаиморасчетыССотрудникамиВнутренний.ВедомостьВКассуВыборкаДляПечатиТаблицы(Метаданные.Документы.ВедомостьНаВыплатуЗарплатыВКассу.ПолноеИмя(), Ведомости)
КонецФункции

Функция ДанныеВедомостиДляПечати(Ссылка) Экспорт
	Возврат ВзаиморасчетыССотрудниками.ВедомостьДанныеДляПечати(Ссылка)	
КонецФункции

#КонецОбласти

#Область ОграничениеДокумента

Функция ПредставлениеПометкиОграничения() Экспорт
	
	Возврат НСтр("ru = 'Передан для выплаты'");
	
КонецФункции

Функция ОперацияОграниченияДокумента() Экспорт
	
	Возврат ВзаиморасчетыССотрудникамиВнутренний.ВедомостьВКассуОперацияОграниченияДокумента();
	
КонецФункции

#КонецОбласти

Функция ТекстЗапросаДанныеДляОплаты(ИмяПараметраВедомости = "Ведомости", ИмяПараметраФизическиеЛица = "ФизическиеЛица") Экспорт
	Возврат 
		ВзаиморасчетыССотрудниками.ВедомостьТекстЗапросаДанныеДляОплаты(
			Метаданные.Документы.ВедомостьНаВыплатуЗарплатыВКассу.ПолноеИмя(), 
			ИмяПараметраВедомости, ИмяПараметраФизическиеЛица);
КонецФункции	

#КонецОбласти

#КонецЕсли