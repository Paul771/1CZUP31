
#Область СлужебныеПроцедурыИФункции

Процедура ДополнитьТаблицуФизическиеЛицаПоВедомостям(ФизическиеЛица, ВедомостиДокумента) Экспорт
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьВзаиморасчетыПоПрочимДоходам") Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВедомостьФизическиеЛица.ФизическоеЛицо КАК ФизическоеЛицо
	|ИЗ
	|	Документ.ВедомостьПрочихДоходовВБанк.ФизическиеЛица КАК ВедомостьФизическиеЛица
	|ГДЕ
	|	ВедомостьФизическиеЛица.Ссылка В(&Ведомости)";
	Запрос.УстановитьПараметр("Ведомости", ВедомостиДокумента);
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		ОбщегоНазначенияКлиентСервер.ДополнитьТаблицуИзМассива(ФизическиеЛица, Результат.Выгрузить().ВыгрузитьКолонку("ФизическоеЛицо"), "ФизическоеЛицо");
	КонецЕсли;
	
КонецПроцедуры

// Добавляет в список Обработчики процедуры-обработчики обновления,
// необходимые данной подсистеме.
//
// Параметры:
//   Обработчики - ТаблицаЗначений - см. описание функции НоваяТаблицаОбработчиковОбновления
//                                   общего модуля ОбновлениеИнформационнойБазы.
// 
Процедура ЗарегистрироватьОбработчикиОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "3.0.24.75";
	Обработчик.Процедура = "Документы.ВозвратСотрудникомЗадолженности.ЗаполнитьПериодыВзаиморасчетовЗадолженностей";
		
КонецПроцедуры	

// Определяет объекты, в которых есть процедура ДобавитьКомандыПечати().
// Подробнее см. УправлениеПечатьюПереопределяемый.
//
// Параметры:
//  СписокОбъектов - Массив - список менеджеров объектов.
//
Процедура ПриОпределенииОбъектовСКомандамиПечати(СписокОбъектов) Экспорт
	
	СписокОбъектов.Добавить(Документы.ВозвратСотрудникомЗадолженности);
	СписокОбъектов.Добавить(Документы.СведенияОНезачисленнойЗарплате);

	
КонецПроцедуры

#КонецОбласти