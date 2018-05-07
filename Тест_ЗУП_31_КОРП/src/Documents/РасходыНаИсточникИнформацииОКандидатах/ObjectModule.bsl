#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, Режим)
	
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	// регистр РасходыНаИсточникиИнформацииОКандидатах 
	Движения.РасходыНаИсточникиИнформацииОКандидатах.Записывать = Истина;
	Движение = Движения.РасходыНаИсточникиИнформацииОКандидатах.Добавить();
	Движение.Период = НачалоПериодаОказанияУслуги;
	Движение.Источник = Источник;
	Движение.Сумма = Сумма;
	Движение.Организация = Организация;

	// регистр ОплатаПубликацийВакансий
	Движения.ОплатаПубликацийВакансий.Записывать = Истина;
	Для Каждого ТекСтрокаВакансии Из Вакансии Цикл
		Движение = Движения.ОплатаПубликацийВакансий.Добавить();
		Движение.ДокументОснование = Ссылка;
		Движение.НачалоПериодаОказанияУслуги = НачалоПериодаОказанияУслуги;
		Движение.Источник = Источник;
		Движение.Вакансия = ТекСтрокаВакансии.Вакансия;
		Движение.Организация = Организация;
	КонецЦикла;

КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ТипОснования = ТипЗнч(ДанныеЗаполнения);
	
	Если ТипОснования = Тип("СправочникСсылка.ИсточникиИнформацииОКандидатах") Тогда
		
		Источник = ДанныеЗаполнения.Ссылка;
		
	ИначеЕсли ТипОснования = Тип("СправочникСсылка.Вакансии") Тогда
		
		Вакансии.Добавить().Вакансия = ДанныеЗаполнения;
		Организация = ДанныеЗаполнения.Позиция.Владелец;
		
	ИначеЕсли ТипОснования = Тип("Структура") И ДанныеЗаполнения.Свойство("МассивВакансий") Тогда 
		
		МассивВакансий = ДанныеЗаполнения.МассивВакансий;
		Если МассивВакансий.Количество() Тогда 
			Организация = МассивВакансий[0].Позиция.Владелец;
			Для Каждого ЭлементМассиваВакансий Из МассивВакансий Цикл 
				Если ТипЗнч(ЭлементМассиваВакансий) = Тип("СправочникСсылка.Вакансии")
					И ЭлементМассиваВакансий.Позиция.Владелец = Организация Тогда
					
					Вакансии.Добавить().Вакансия = ЭлементМассиваВакансий.Ссылка;
					
				КонецЕсли;	
			КонецЦикла;
		КонецЕсли;	
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если Вакансии.Количество() Тогда
		КраткийСоставДокумента = СтрСоединить(Вакансии.ВыгрузитьКолонку("Вакансия"), "; ");
	Иначе
		КраткийСоставДокумента = НСтр("ru = 'По всем вакансиям'");
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ПроверитьВакансииДругихОрганизаций(Отказ);
	ПроверитьДублиВакансий(Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает структуру параметров для ограничения регистрации объекта при обмене
// Вызывается ПередЗаписью объекта.
//
// Возвращаемое значение:
//	ОграниченияРегистрации - Структура - Описание см. ОбменДаннымиЗарплатаКадры.ОграниченияРегистрации.
//
Функция ОграниченияРегистрации() Экспорт
	
	Если ДополнительныеСвойства.Свойство("ОграниченияРегистрации") Тогда
		// Ограничения регистрации уже были получены
		Возврат ДополнительныеСвойства.ОграниченияРегистрации;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Вакансии", Вакансии.Выгрузить().ВыгрузитьКолонку("Вакансия"));
	
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Вакансии.Подразделение КАК Подразделение
	|ИЗ
	|	Справочник.Вакансии КАК Вакансии
	|ГДЕ
	|	Вакансии.Ссылка В(&Вакансии)";
	
	ОграниченияРегистрации = ОбменДаннымиЗарплатаКадры.ОграниченияРегистрации();
	ОграниченияРегистрации.ДатаПолученияДанных = Дата;
	ОграниченияРегистрации.Подразделения = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Подразделение");
	ОграниченияРегистрации.Организации = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Организация);
	
	Возврат ОграниченияРегистрации;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПроверитьВакансииДругихОрганизаций(Отказ)
	
	ВакансииДокумента = Вакансии.Выгрузить().ВыгрузитьКолонку("Вакансия");
	ВакансииОрганизации = Справочники.Вакансии.ВакансииОрганизации(Организация, ВакансииДокумента);
	ВакансииДругойОрганизации = ОбщегоНазначенияКлиентСервер.РазностьМассивов(ВакансииДокумента, ВакансииОрганизации);
	
	ОтборСтрок = Новый Структура("Вакансия");
	
	Для Каждого Вакансия Из ВакансииДругойОрганизации Цикл
		ОтборСтрок.Вакансия = Вакансия;
		НайденныеСтроки = ЭтотОбъект.Вакансии.НайтиСтроки(ОтборСтрок);
		Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Вакансия %1 относится к другой организации.'"), 
				Вакансия);
			ПутьКДанным = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти("Вакансии", НайденнаяСтрока.НомерСтроки, "Вакансия");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , , ПутьКДанным, Отказ);
		КонецЦикла;
	КонецЦикла;				
	
КонецПроцедуры

Процедура ПроверитьДублиВакансий(Отказ)
	
	НайденныеВакансии = Новый Соответствие;
	ДублиВакансий = Новый Соответствие;
	Для Каждого СтрокаТаблицы Из ЭтотОбъект.Вакансии Цикл
		Если НайденныеВакансии[СтрокаТаблицы.Вакансия] = Неопределено Тогда
			НайденныеВакансии.Вставить(СтрокаТаблицы.Вакансия, Истина);
			Продолжить;
		КонецЕсли;
		Если ДублиВакансий[СтрокаТаблицы.Вакансия] = Неопределено Тогда
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Вакансия %1 встречается в таблице более одного раза.'"), 
				СтрокаТаблицы.Вакансия);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , , "ЭтотОбъект.Вакансии", Отказ);
			ДублиВакансий.Вставить(СтрокаТаблицы.Вакансия, Истина);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли