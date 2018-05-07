#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипСведений <> Перечисления.ТипыСведенийСЗВ.КОРРЕКТИРУЮЩАЯ Тогда 
		ДосрочноеНазначениеПенсии.Очистить();
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ИмяФайлаДляПФР) Тогда
		ИмяФайлаДляПФР = Документы.ОписьОДВ_1.ИмяФайла(Организация, Дата);
	Иначе		
		УИДИзИмениФайла = Прав(ИмяФайлаДляПФР, 36);
		Если Не СтроковыеФункцииКлиентСервер.ЭтоУникальныйИдентификатор(УИДИзИмениФайла) Тогда
			УИДИзИмениФайла = Строка(Новый УникальныйИдентификатор);	
		КонецЕсли;	
		ИмяФайлаДляПФР = Документы.ОписьОДВ_1.ИмяФайла(Организация, Дата, УИДИзИмениФайла);
	КонецЕсли;
	
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
	Возврат ОбменДаннымиЗарплатаКадры.ОграниченияРегистрацииПоОрганизации(ЭтотОбъект, Организация);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Подсистема "Управление доступом".

// Процедура ЗаполнитьНаборыЗначенийДоступа по свойствам объекта заполняет наборы значений доступа
// в таблице с полями:
//    НомерНабора     - Число                                     (необязательно, если набор один),
//    ВидДоступа      - ПланВидовХарактеристикСсылка.ВидыДоступа, (обязательно),
//    ЗначениеДоступа - Неопределено, СправочникСсылка или др.    (обязательно),
//    Чтение          - Булево (необязательно, если набор для всех прав) устанавливается для одной строки набора,
//    Добавление      - Булево (необязательно, если набор для всех прав) устанавливается для одной строки набора,
//    Изменение       - Булево (необязательно, если набор для всех прав) устанавливается для одной строки набора,
//    Удаление        - Булево (необязательно, если набор для всех прав) устанавливается для одной строки набора.
//
//  Вызывается из процедуры УправлениеДоступомСлужебный.ЗаписатьНаборыЗначенийДоступа(),
// если объект зарегистрирован в "ПодпискаНаСобытие.ЗаписатьНаборыЗначенийДоступа" и
// из таких же процедур объектов, у которых наборы значений доступа зависят от наборов этого
// объекта (в этом случае объект зарегистрирован в "ПодпискаНаСобытие.ЗаписатьЗависимыеНаборыЗначенийДоступа").
//
// Параметры:
//  Таблица      - ТабличнаяЧасть,
//                 РегистрСведенийНаборЗаписей.НаборыЗначенийДоступа,
//                 ТаблицаЗначений, возвращаемая УправлениеДоступом.ТаблицаНаборыЗначенийДоступа().
//
Процедура ЗаполнитьНаборыЗначенийДоступа(Таблица) Экспорт
	
	ЗарплатаКадры.ЗаполнитьНаборыПоОрганизации(ЭтотОбъект, Таблица, "Организация");
	
КонецПроцедуры

// Подсистема "Управление доступом".

Процедура ПроверитьДанныеДокумента(Отказ = Ложь) Экспорт 
	
	Если Не ПроверитьЗаполнение() Тогда
		Отказ = Истина;
	КонецЕсли;	
	
	Ошибки = Новый Массив;
	
	Если Не ДополнительныеСвойства.Свойство("НеПроверятьДанныеОрганизации") Тогда
		ПерсонифицированныйУчет.ПроверитьДанныеОрганизации(ЭтотОбъект, Организация, Отказ);
	КонецЕсли;	

	ПроверитьДанныеШапкиДокумента(Ошибки, Отказ);
	
КонецПроцедуры

Процедура ПроверитьДанныеШапкиДокумента(Ошибки, Отказ = Ложь)
	
	Если Не ЗначениеЗаполнено(Руководитель) Тогда
		ТекстОшибки = НСтр("ru = 'Не указан руководитель.'");
		ПерсонифицированныйУчетКлиентСервер.ДобавитьОшибкуЗаполненияЭлементаДокумента(Ошибки, Ссылка, ТекстОшибки, , Отказ);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ДолжностьРуководителя) Тогда
		ТекстОшибки = НСтр("ru = 'Не указана должность руководителя.'");
		ПерсонифицированныйУчетКлиентСервер.ДобавитьОшибкуЗаполненияЭлементаДокумента(Ошибки, Ссылка, ТекстОшибки, , Отказ);
	КонецЕсли;
	
КонецПроцедуры	

#КонецОбласти

#КонецЕсли
