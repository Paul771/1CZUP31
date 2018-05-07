#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает структуру параметров для ограничения регистрации объекта при обмене
// Вызывается ПередЗаписью объекта.
//
// Возвращаемое значение:
//	ОграниченияРегистрации - Структура - Описание см. ОбменДаннымиЗарплатаКадры.ОграниченияРегистрации.
//
Функция ОграниченияРегистрации() Экспорт
	
	ИменаПолей = ОбменДаннымиЗарплатаКадры.ИменаПолейОграниченияРегистрацииРегистраСведений();
	ИменаПолей.Сотрудники = "Сотрудник";
	ИменаПолей.ДатыПолученияДанных = "Период";
	
	Возврат ОбменДаннымиЗарплатаКадры.ОграниченияРегистрацииРегистраСведений(ЭтотОбъект, ИменаПолей);
	
КонецФункции

#КонецОбласти 

#КонецЕсли