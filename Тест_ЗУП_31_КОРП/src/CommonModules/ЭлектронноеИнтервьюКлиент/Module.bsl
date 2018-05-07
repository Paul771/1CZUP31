
#Область ПрограммныйИнтерфейс

// Обработчик подключаемой команды. Открывает общую форму Мотиваторы.
//
// Параметры 
//	МассивОбъектов - Массив - массив объектов, для которых выполняется данная команда. 
//	ДополнительныеПараметры - Структура - структура параметров команды.
//
Процедура ЗаполнитьМотивацию(МассивОбъектов, ДополнительныеПараметры) Экспорт
	
	Объект = ДополнительныеПараметры.Источник;
	Форма = ДополнительныеПараметры.Форма;
	ЗаметкиПоМотивации = Новый Массив;
	ПолучитьЗаметкиПоМотивации(Форма, ЗаметкиПоМотивации);
	ДополнительныеПараметры.Вставить("ЗаметкиПоМотивации", ЗаметкиПоМотивации);
	Если Объект.Ссылка.Пустая() Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьМотивациюЗапись", ЭлектронноеИнтервьюКлиент, ДополнительныеПараметры);
		ТекстВопроса = НСтр("ru = 'Для работы с мотиваторами необходимо записать анкету. Продолжить?'");
		Кнопки = Новый СписокЗначений;
		Кнопки.Добавить("Продолжить", НСтр("ru = 'Продолжить'"));
		Кнопки.Добавить(КодВозвратаДиалога.Отмена);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, Кнопки);
		Возврат;
	КонецЕсли;
	ОткрытьФормуМотивации(ДополнительныеПараметры);
	
КонецПроцедуры

// Открывает анкету для интервью.
//
// Параметры 
//	Кандидат - СправочникСсылка.Кандидаты - кандидат, для которого создается анкета.
//	Респондент - СправочникСсылка.ФизическиеЛица - физлицо, для которого создается анкета.
//	ЭтапРаботы - СправочникСсылка.ЭтапыРаботыСКандидатами - этап работы, для которого создается анкета.
//	ШаблонАнкеты - СправочникСсылка.ШаблоныАнкет - шаблон создаваемой анкеты.
//
Процедура НачатьИнтервью(Кандидат, Респондент, ЭтапРаботы, ШаблонАнкеты) Экспорт
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("Респондент", Респондент);
	ЗначенияЗаполнения.Вставить("ШаблонАнкеты", ШаблонАнкеты);
	ЗначенияЗаполнения.Вставить("РежимАнкетирования", ПредопределенноеЗначение("Перечисление.РежимыАнкетирования.Интервью"));
	ЗначенияЗаполнения.Вставить("Интервьюер", ПользователиКлиентСервер.ТекущийПользователь());
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ПараметрыФормы.Вставить("ТолькоФормаЗаполнения", Истина);
	ОтвеченныеВопросы = ЭлектронноеИнтервьюВызовСервера.ОтвеченныеВопросы(Респондент, ШаблонАнкеты);
	Если ОтвеченныеВопросы.Количество() > 0 Тогда
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("ПараметрыФормы", ПараметрыФормы);
		ДополнительныеПараметры.Вставить("ОтвеченныеВопросы", ОтвеченныеВопросы);
		ДополнительныеПараметры.Вставить("Кандидат", Кандидат);
		ДополнительныеПараметры.Вставить("ЭтапРаботы", ЭтапРаботы);
		ОписаниеОповещения = Новый ОписаниеОповещения("НачатьИнтервьюЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ТекстВопроса = НСтр("ru = 'Респондент уже ранее отвечал на некоторые вопросы анкеты.
		|Заполнить ответы по этим вопросам из ранее полученных ответов?'");
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Возврат;
	КонецЕсли;
	ОткрытьАнкету(ПараметрыФормы, Кандидат, ЭтапРаботы);
	
КонецПроцедуры

// Обрабатывает изменение характеристики персонала в требованиях на форме
//
// Параметры 
//	Форма - Форма - форма, в которой была изменена характеристика.
//	ТекущиеДанные - ДанныеФормыЭлементКоллекции - данные текущей строки, в которой была изменена характеристика.
//
Процедура ОбработатьИзменениеХарактеристики(Форма, ТекущиеДанные) Экспорт
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Характеристика", ТекущиеДанные.Характеристика);
	СтрокиХарактеристики = Форма.Характеристики.НайтиСтроки(СтруктураПоиска);
	Если СтрокиХарактеристики.Количество() > 1 Тогда
		ТекущиеДанные.Характеристика = Форма.ХарактеристикаРедактируемойСтроки;
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = НСтр("ru = 'Выбранная характеристика уже присутствует в списке'");
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	Форма.ХарактеристикаРедактируемойСтроки = ТекущиеДанные.Характеристика;
	
	СтруктураВида = ХарактеристикиПерсоналаВызовСервера.ВидХарактеристики(ТекущиеДанные.Характеристика);
	ТекущиеДанные.ВидХарактеристики = СтруктураВида.ВидХарактеристики;
	ТекущиеДанные.КартинкаВида = СтруктураВида.Картинка;
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Характеристика", ТекущиеДанные.Характеристика);
	СтрокиЗначений = Форма.ЗначенияХарактеристики.НайтиСтроки(СтруктураПоиска);
	ЗначенияСтрокой = "";
	Для Каждого ТекущаяСтрока Из СтрокиЗначений Цикл
		ЗначенияСтрокой = СокрЛП(ЗначенияСтрокой) + ?(ЗначенияСтрокой = "", "", ", ") + СокрЛП(Строка(ТекущаяСтрока.Значение));
	КонецЦикла;
	ТекущиеДанные.ЗначенияСтрокой = ЗначенияСтрокой;
	
	УдаляемыеСтроки = Новый Массив;
	Для Каждого ТекущаяСтрока Из Форма.ЗначенияХарактеристики Цикл
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("Характеристика", ТекущаяСтрока.Характеристика);
		СтрокиХарактеристики = Форма.Характеристики.НайтиСтроки(СтруктураПоиска);
		Если СтрокиХарактеристики.Количество() = 0 Тогда
			УдаляемыеСтроки.Добавить(ТекущаяСтрока);
		КонецЕсли;
	КонецЦикла;
	Для Каждого ТекущаяСтрока Из УдаляемыеСтроки Цикл
		Форма.ЗначенияХарактеристики.Удалить(ТекущаяСтрока);
	КонецЦикла;
	
	Форма.Модифицированность = Истина;
	
КонецПроцедуры

// Добавляет характеристику персонала в требования на форме
//
// Параметры 
//	Форма - Форма - форма, в которой была добавлена характеристика.
//	Характеристика - ПланВидовХарактеристикСсылка.ХарактеристикиПерсонала - ссылка на характеристику персонала, которая добавляется на форму.
//
Процедура ДобавитьХарактеристикуПерсонала(Форма, Характеристика) Экспорт
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Характеристика", Характеристика);
	Если Форма.Характеристики.НайтиСтроки(СтруктураПоиска).Количество() = 0 Тогда
		НовСтрока = Форма.Характеристики.Добавить();
		НовСтрока.Характеристика = Характеристика;
		НовСтрока.Вес = 1;
		СтруктураВида = ХарактеристикиПерсоналаВызовСервера.ВидХарактеристики(Характеристика);
		НовСтрока.ВидХарактеристики = СтруктураВида.ВидХарактеристики;
		НовСтрока.КартинкаВида = СтруктураВида.Картинка;
		Форма.Модифицированность = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Выполняет печать анкеты
//
// Параметры 
//	ШаблонАнкеты - СправочникСсылка.ШаблоныАнкет - ссылка на шаблон печатаемой анкеты.
//
Процедура ПечатьАнкеты(ШаблонАнкеты) Экспорт
	
	ТабличныйДокумент = ЭлектронноеИнтервьюВызовСервера.ПечатьАнкетыНаСервере(ШаблонАнкеты);
	
	КоллекцияПечатныхФорм = УправлениеПечатьюКлиент.НоваяКоллекцияПечатныхФорм("БланкАнкетыЭлектронногоИнтервью");
	ПечатнаяФорма = УправлениеПечатьюКлиент.ОписаниеПечатнойФормы(КоллекцияПечатныхФорм, "БланкАнкетыЭлектронногоИнтервью");
	ПечатнаяФорма.СинонимМакета = НСтр("ru = 'Анкета'");
	ПечатнаяФорма.ТабличныйДокумент = ТабличныйДокумент;
	ПечатнаяФорма.ИмяФайлаПечатнойФормы = "БланкАнкетыЭлектронногоИнтервью";
	
	ОбластиОбъектов = Новый СписокЗначений;
	УправлениеПечатьюКлиент.ПечатьДокументов(КоллекцияПечатныхФорм, ОбластиОбъектов);
	
КонецПроцедуры

// Удаляет действия сотрудника из требований на форме
//
// Параметры 
//	Форма - Форма - форма, в которой была добавлена характеристика.
//	ДействияСотрудника - Массив - массив удаляемых действий
//	ПрочиеДействия - Массив - массив других действий сотрудников в требованиях
//	Характеристики - Массив - массив характеристик персонала в требованиях
//	ЗначенияХарактеристик - Массив - массив значений характеристик персонала в требованиях.
//
Процедура УдалитьДействияСотрудника(Форма, ДействияСотрудника, ПрочиеДействия, Характеристики, ЗначенияХарактеристик) Экспорт
	
	УдаляемыеСтроки = ЭлектронноеИнтервьюВызовСервера.СписокУдаляемыхСтрок(ДействияСотрудника, ПрочиеДействия, Характеристики, ЗначенияХарактеристик);
	Если УдаляемыеСтроки.Характеристики.Количество() = 0 И УдаляемыеСтроки.ЗначенияХарактеристик.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОповещения = Новый Структура;
	ПараметрыОповещения.Вставить("УдаляемыеСтроки", УдаляемыеСтроки);
	ПараметрыОповещения.Вставить("Форма", Форма);
	Оповещение = Новый ОписаниеОповещения("УдалитьДействияСотрудникаЗавершение", ЭтотОбъект, ПараметрыОповещения);
	ТекстВопроса = НСтр("ru = 'Удалить характеристики, связанные
	|с текущим действием?'");
	ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

// Заполняет требования к характеристикам на основании действий сотрудников
//
// Параметры 
//	Объект - ДанныеФормыСтруктура - заполняемый объект
//	Характеристики - ДанныеФормыКоллекция - таблица характеристик персонала.
//	ЗначенияХарактеристики - ДанныеФормыКоллекция - таблица значений характеристик персонала.
//
Процедура ЗаполнитьПоФункциям(Объект, Характеристики, ЗначенияХарактеристики) Экспорт
	
	СписокДействий = Новый СписокЗначений;
	Для Каждого ТекущаяСтрока Из Объект.ДействияСотрудников Цикл
		СписокДействий.Добавить(ТекущаяСтрока.ДействиеСотрудника);
	КонецЦикла;
	СписокХарактеристик = Новый СписокЗначений;
	Для Каждого ТекущаяСтрока Из Характеристики Цикл
		СписокХарактеристик.Добавить(ТекущаяСтрока.Характеристика);
	КонецЦикла;
	ИзменяемыеХарактеристики = ЭлектронноеИнтервьюВызовСервера.ИзменяемыеХарактеристики(СписокДействий, СписокХарактеристик);
	ИзменитьСоставХарактеристик(Объект, Характеристики, ЗначенияХарактеристики, ИзменяемыеХарактеристики);
	
КонецПроцедуры

// Изменяет состав требований к характеристикам
//
// Параметры 
//	Объект - ДанныеФормыСтруктура - заполняемый объект.
//	Характеристики - ДанныеФормыКоллекция - таблица характеристик персонала.
//	ЗначенияХарактеристики - ДанныеФормыКоллекция - таблица значений характеристик персонала.
//	ИзменяемыеХарактеристики - Структура - структура массивов добавляемых и удаляемых характеристик персонала.
//
Процедура ИзменитьСоставХарактеристик(Объект, Характеристики, ЗначенияХарактеристики, ИзменяемыеХарактеристики) Экспорт
	
	ДобавляемыеХарактеристики = ИзменяемыеХарактеристики.ДобавляемыеХарактеристики;
	УдаляемыеХарактеристики = ИзменяемыеХарактеристики.УдаляемыеХарактеристики;
	
	ШаблоныАнкет = Новый СписокЗначений;
	Если ТипЗнч(Объект.Ссылка) = Тип("СправочникСсылка.ПрофилиДолжностей") Или ТипЗнч(Объект.Ссылка) = Тип("СправочникСсылка.Вакансии") Тогда
		Для Каждого ТекущаяСтрока Из Объект.ЭтапыРаботыСКандидатами Цикл
			Если ЗначениеЗаполнено(ТекущаяСтрока.ШаблонАнкеты) Тогда
				ШаблоныАнкет.Добавить(ТекущаяСтрока.ШаблонАнкеты);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	УдаляемыеВопросыШаблона = ЭлектронноеИнтервьюВызовСервера.УдаляемыеВопросыШаблона(УдаляемыеХарактеристики, Объект.Ссылка, ШаблоныАнкет);
	
	Если УдаляемыеВопросыШаблона.Количество() > 0 Тогда
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Ссылка", Объект.Ссылка);
		ДополнительныеПараметры.Вставить("Характеристики", Характеристики);
		ДополнительныеПараметры.Вставить("ЗначенияХарактеристики", ЗначенияХарактеристики);
		ДополнительныеПараметры.Вставить("ДобавляемыеХарактеристики", ДобавляемыеХарактеристики);
		ДополнительныеПараметры.Вставить("УдаляемыеХарактеристики", УдаляемыеХарактеристики);
		ДополнительныеПараметры.Вставить("УдаляемыеВопросыШаблона", УдаляемыеВопросыШаблона);
		ОписаниеОповещения = Новый ОписаниеОповещения("УдалитьХарактеристикиЗавершение", ЭтотОбъект, ДополнительныеПараметры); 
		ТекстВопроса = НСтр("ru = 'В настройках вопросов для собеседования есть вопросы для оценки удаляемых характеристик. Удалить эти вопросы?'");
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена);
		Возврат;
	КонецЕсли;
	
	Если ИзменяемыеХарактеристики.ДобавляемыеХарактеристики.Количество() > 0 Тогда
		ХарактеристикиПерсоналаКлиент.ДобавитьХарактеристикиВТаблицу(Характеристики, ЗначенияХарактеристики, ДобавляемыеХарактеристики);
	КонецЕсли;
	Если ИзменяемыеХарактеристики.УдаляемыеХарактеристики.Количество() > 0 Тогда
		ХарактеристикиПерсоналаКлиент.УдалитьХарактеристикиИзТаблицы(Характеристики, ЗначенияХарактеристики, УдаляемыеХарактеристики, Объект.Ссылка);
	КонецЕсли;	
	
КонецПроцедуры

#Область УстаревшиеПроцедурыИФункции

// Устарела. Следует использовать ХарактеристикиПерсоналаКлиент.ОткрытьНастройкуЗначенийХарактеристик.
// 
// Открывает настройку весов значений характеристик
//
// Параметры 
//	Форма - Форма - форма, из которой открывается настройка весов значений характеристики.
//	Характеристика - ПланВидовХарактеристикСсылка.ХарактеристикиПерсонала - ссылка на характеристику персонала, для которой настраиваются веса значений.
//
Процедура ОткрытьНастройкуВесовЗначенийХарактеристик(Форма, Характеристика) Экспорт
	ХарактеристикиПерсоналаКлиент.ОткрытьНастройкуЗначенийХарактеристик(Форма, Характеристика);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Открытие общей формы Мотиваторы
//
Процедура ОткрытьФормуМотивации(ДополнительныеПараметры)
	
	Форма = ДополнительныеПараметры.Форма;
	Объект = ДополнительныеПараметры.Источник;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Анкета", Объект.Ссылка);
	ПараметрыФормы.Вставить("ЗаметкиПоМотивации", ДополнительныеПараметры.ЗаметкиПоМотивации);
	
	ОткрытьФорму("ОбщаяФорма.Мотиваторы", ПараметрыФормы, Форма, Форма.УникальныйИдентификатор);	
	
КонецПроцедуры

Процедура ОткрытьАнкету(ПараметрыФормы, Кандидат, ЭтапРаботы, ОтвеченныеВопросы = Неопределено)
	
	Анкета = ЭлектронноеИнтервьюВызовСервера.АнкетаКандидата(ПараметрыФормы, Кандидат, ЭтапРаботы, ОтвеченныеВопросы);
	ПараметрыФормы.Вставить("Ключ", Анкета);
	ПараметрыФормы.Вставить("ВозможностьПредварительногоСохранения", Истина);
	ФормаАнкеты = ОткрытьФорму("Документ.Анкета.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

// Обработчик оповещения о закрытии вопроса о необходимости записать анкету перед открытием общей формы Мотиваторы.
// При согласии пользователя записывает анкету из дополнительных параметров и открывает общую форму Мотиваторы.
//
// Параметры 
//	Результат - Строка, КодВозвратаДиалога - ответ на вопрос о записи анкеты. 
//	ДополнительныеПараметры - Структура - структура дополнительных параметров.
//
Процедура ЗаполнитьМотивациюЗапись(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> "Продолжить" Тогда
		Возврат;
	КонецЕсли;
	
	Объект = ДополнительныеПараметры.Источник;
	Форма = ДополнительныеПараметры.Форма;
	Если Не Форма.Записать() Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФормуМотивации(ДополнительныеПараметры);
	
КонецПроцедуры

// Обработчик оповещения о закрытии вопроса о заполнении ранее полученных ответов.
// При согласии пользователя заполняет ранее полученные ответы из дополнительных параметров. Открывает анкету для интервью.
//
// Параметры 
//	Результат - КодВозвратаДиалога - ответ на вопрос о заполнении ранее полученных ответов. 
//	ДополнительныеПараметры - Структура - структура дополнительных параметров.
//
Процедура НачатьИнтервьюЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ОткрытьАнкету(ДополнительныеПараметры.ПараметрыФормы, ДополнительныеПараметры.Кандидат, ДополнительныеПараметры.ЭтапРаботы, ДополнительныеПараметры.ОтвеченныеВопросы);
	Иначе
		ОткрытьАнкету(ДополнительныеПараметры.ПараметрыФормы, ДополнительныеПараметры.Кандидат, ДополнительныеПараметры.ЭтапРаботы);
	КонецЕсли;	
	
КонецПроцедуры

Процедура ХарактеристикиЗначениеОкончаниеВыбора(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяХарактеристика = Результат.Характеристика;
	Форма = ДополнительныеПараметры.Форма;
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Характеристика", ТекущаяХарактеристика);
	СтрокиХарактеристики = Форма.Характеристики.НайтиСтроки(СтруктураПоиска);
	Если СтрокиХарактеристики.Количество() > 0 Тогда
		СтрокаХарактеристики = СтрокиХарактеристики[0];
	Иначе
		СтрокаХарактеристики = Форма.Характеристики.Добавить();
		СтрокаХарактеристики.Характеристика = ТекущаяХарактеристика;
		СтрокаХарактеристики.Вес = 1;
	КонецЕсли;
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Характеристика", ТекущаяХарактеристика);
	СтрокиЗначений = Форма.ЗначенияХарактеристики.НайтиСтроки(СтруктураПоиска);
	Для Каждого ТекущаяСтрока Из СтрокиЗначений Цикл
		Форма.ЗначенияХарактеристики.Удалить(ТекущаяСтрока);
	КонецЦикла;
	ЗначенияСтрокой = "";
	Для Каждого ТекущаяСтрока Из Результат.МассивЗначений Цикл
		НоваяСтрока = Форма.ЗначенияХарактеристики.Добавить();
		НоваяСтрока.Характеристика = ТекущаяХарактеристика;
		НоваяСтрока.Значение = ТекущаяСтрока.Значение;
		НоваяСтрока.ВесЗначения = ТекущаяСтрока.ВесЗначения;
		ЗначенияСтрокой = СокрЛП(ЗначенияСтрокой) + ?(ЗначенияСтрокой = "", "", ", ") + СокрЛП(Строка(ТекущаяСтрока.Значение));
	КонецЦикла;
	СтрокаХарактеристики.ЗначенияСтрокой = ЗначенияСтрокой;
	
	Форма.Модифицированность = Истина;
	
КонецПроцедуры

Процедура УдалитьДействияСотрудникаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Форма = ДополнительныеПараметры.Форма;
	
	ИзменяемыеХарактеристики = Новый Структура;
	ИзменяемыеХарактеристики.Вставить("УдаляемыеХарактеристики", ДополнительныеПараметры.УдаляемыеСтроки.Характеристики);
	ИзменяемыеХарактеристики.Вставить("ДобавляемыеХарактеристики", Новый Массив);
	
	ИзменитьСоставХарактеристик(Форма.Объект, Форма.Характеристики, Форма.ЗначенияХарактеристики, ИзменяемыеХарактеристики);
	
	УдаляемыеЗначения = Новый Массив;
	ИзмененныеХарактеристики = Новый Массив;
	Для Каждого УдаляемоеЗначение Из ДополнительныеПараметры.УдаляемыеСтроки.ЗначенияХарактеристик Цикл
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("Значение", УдаляемоеЗначение);
		СтрокиТаблицы = Форма.ЗначенияХарактеристики.НайтиСтроки(СтруктураПоиска);
		Если СтрокиТаблицы.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		СтрокаТаблицы = СтрокиТаблицы[0];
		УдаляемыеЗначения.Добавить(СтрокаТаблицы);
		Если ИзмененныеХарактеристики.Найти(СтрокаТаблицы.Характеристика) = Неопределено Тогда
			ИзмененныеХарактеристики.Добавить(СтрокаТаблицы.Характеристика);
		КонецЕсли;
	КонецЦикла;
	Для каждого УдаляемаяСтрока Из УдаляемыеЗначения Цикл
		Форма.ЗначенияХарактеристики.Удалить(УдаляемаяСтрока);
	КонецЦикла;
	Для Каждого ИзменяемаяХарактеристика Из ИзмененныеХарактеристики Цикл
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("Характеристика", ИзменяемаяХарактеристика);
		СтрокиХарактеристики = Форма.Характеристики.НайтиСтроки(СтруктураПоиска);
		Если СтрокиХарактеристики.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		ТекущаяСтрока = СтрокиХарактеристики[0];
		ЗначенияСтрокой = "";
		СтрокиЗначений = Форма.ЗначенияХарактеристики.НайтиСтроки(СтруктураПоиска);
		Для Каждого СтрокаЗначения Из СтрокиЗначений Цикл
			ЗначенияСтрокой = СокрЛП(ЗначенияСтрокой) + ?(ЗначенияСтрокой = "", "", ", ") + СокрЛП(Строка(СтрокаЗначения.Значение));
		КонецЦикла;
		ТекущаяСтрока.ЗначенияСтрокой = ЗначенияСтрокой;
	КонецЦикла;
	
КонецПроцедуры

Процедура УдалитьХарактеристикиЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Или Результат = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ЭлектронноеИнтервьюВызовСервера.УдалитьВопросыШаблона(ДополнительныеПараметры.УдаляемыеВопросыШаблона, ДополнительныеПараметры.Ссылка);
		Оповестить("СохранениеНастроекВопросовДляСобеседования", ДополнительныеПараметры.Ссылка);
	КонецЕсли;
	
	Если ДополнительныеПараметры.ДобавляемыеХарактеристики.Количество() > 0 Тогда
		ХарактеристикиПерсоналаКлиент.ДобавитьХарактеристикиВТаблицу(ДополнительныеПараметры.Характеристики, ДополнительныеПараметры.ЗначенияХарактеристики, ДополнительныеПараметры.ДобавляемыеХарактеристики);
	КонецЕсли;
	Если ДополнительныеПараметры.УдаляемыеХарактеристики.Количество() > 0 Тогда
		ХарактеристикиПерсоналаКлиент.УдалитьХарактеристикиИзТаблицы(ДополнительныеПараметры.Характеристики, ДополнительныеПараметры.ЗначенияХарактеристики, ДополнительныеПараметры.УдаляемыеХарактеристики, ДополнительныеПараметры.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПолучитьЗаметкиПоМотивации(Форма, ЗаметкиПоМотивации)
	
	Объект = Форма.Объект;
	ТекущийРаздел = Форма.ДеревоРазделов.НайтиПоИдентификатору(Форма.Элементы.ДеревоРазделов.ТекущаяСтрока);
	ПредыдущийРазделБезВопросов = (Форма.ТаблицаВопросовРаздела.Количество() = 0);
	СтрокиТекущегоРаздела = Новый Массив;
	ВопросПоЗаметкам = ЭлектронноеИнтервьюВызовСервера.ВопросПоЗаметкам();
	
	Для каждого СтрокаТаблицы Из Форма.ТаблицаВопросовРаздела Цикл
		НайденныеСтроки = Объект.Состав.НайтиСтроки(Новый Структура("Вопрос",СтрокаТаблицы.ВопросШаблона));
		Для каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			СтрокиТекущегоРаздела.Добавить(НайденнаяСтрока);
		КонецЦикла;
		
		Если ЗначениеЗаполнено(СтрокаТаблицы.РодительВопрос) Тогда
			НайденныеСтроки = Форма.ТаблицаВопросовРаздела.НайтиСтроки(Новый Структура("ВопросШаблона",СтрокаТаблицы.РодительВопрос));
			Если НайденныеСтроки.Количество() > 0 Тогда
				СтрокаРодитель = НайденныеСтроки[0];
				Если (НЕ Форма[АнкетированиеКлиентСервер.ПолучитьИмяВопроса(СтрокаРодитель.КлючСтроки)] = Истина) Тогда
					Продолжить;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Если СтрокаТаблицы.ТипВопроса = ПредопределенноеЗначение("Перечисление.ТипыВопросовШаблонаАнкеты.Комплексный") Тогда
			ЗаполнитьЗаметкиПоМотивации(Форма, СтрокаТаблицы, ЗаметкиПоМотивации, ВопросПоЗаметкам);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого ТекущаяСтрока Из Объект.Состав Цикл
		Если СтрокиТекущегоРаздела.Найти(ТекущаяСтрока) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		Если Не (ТекущаяСтрока.ЭлементарныйВопрос = ВопросПоЗаметкам И ЗначениеЗаполнено(ТекущаяСтрока.ОткрытыйОтвет)) Тогда
			Продолжить;
		КонецЕсли;
		СтруктураСтроки = Новый Структура;
		СтруктураСтроки.Вставить("Вопрос", ТекущаяСтрока.Вопрос);
		СтруктураСтроки.Вставить("Заметки", ТекущаяСтрока.ОткрытыйОтвет);
		ЗаметкиПоМотивации.Добавить(СтруктураСтроки);
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьЗаметкиПоМотивации(Форма, СтрокаДерева, ЗаметкиПоМотивации, ВопросПоЗаметкам)
	
	ИмяВопроса = АнкетированиеКлиентСервер.ПолучитьИмяВопроса(СтрокаДерева.КлючСтроки);
	
	Для каждого СтрокаКомплексногоВопроса Из СтрокаДерева.СоставКомплексногоВопроса Цикл
		Если СтрокаКомплексногоВопроса.ЭлементарныйВопрос = ВопросПоЗаметкам Тогда 
			ИмяРеквизита =  ИмяВопроса + "_Ответ_" + Формат(СтрокаКомплексногоВопроса.НомерСтроки, "ЧГ=");
			Заметки = Форма[ИмяРеквизита];
			Если Не ЗначениеЗаполнено(Заметки) Тогда
				Продолжить;
			КонецЕсли;
			
			СтруктураСтроки = Новый Структура;
			СтруктураСтроки.Вставить("Вопрос", СтрокаДерева.ВопросШаблона);
			СтруктураСтроки.Вставить("Заметки", Заметки);
			ЗаметкиПоМотивации.Добавить(СтруктураСтроки);
		КонецЕсли;
	КонецЦикла;
		
КонецПроцедуры

#Область ФормыНастроекВопросов

Процедура ЗаполнитьДеревоКритериевОценки(Форма, УстанавливатьДоступность = Истина, ЕстьКодКартинки = Истина) Экспорт 
	
	Элементы = Форма.Элементы;
	КритерииОценкиДерево = Форма.КритерииОценкиДерево;
	
	УстановитьДоступность(Форма, УстанавливатьДоступность, Истина, "КритерииОценкиДерево");
	ТекущиеДанные = Элементы.ВопросыДляСобеседования.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Или НЕ ЗначениеЗаполнено(ТекущиеДанные.ВопросДляСобеседования) Тогда
		ОчиститьДерево(Форма, УстанавливатьДоступность);
		Возврат;
	КонецЕсли;
	
	Если ЕстьКодКартинки Тогда
		Если (ТекущиеДанные.КодКартинки <> 5 И ТекущиеДанные.КодКартинки <> 3) 
			Или ТекущиеДанные.ТипВопроса = ПредопределенноеЗначение("Перечисление.ТипыВопросовПоМетодуСИвановой.Мотивация") Тогда
			ОчиститьДерево(Форма, УстанавливатьДоступность);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	ЗаполнитьКритерииОценкиДерево(Форма);
	
	Если Элементы.КритерииОценкиДерево.ТекущаяСтрока = Неопределено И КритерииОценкиДерево.ПолучитьЭлементы().Количество()>0 Тогда
		ПерваяСтрока = КритерииОценкиДерево.ПолучитьЭлементы()[0].ПолучитьИдентификатор();
		Элементы.КритерииОценкиДерево.ТекущаяСтрока = ПерваяСтрока;
	КонецЕсли; 	 
	
КонецПроцедуры

Процедура УстановитьОтборТаблицыКритериев(Форма, УстанавливатьДоступность = Истина) Экспорт 
	
	Элементы = Форма.Элементы;	
	ТекущиеДанные = Элементы.КритерииОценкиДерево.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		УстановитьДоступность(Форма, УстанавливатьДоступность, Ложь);
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.Уровень = 0 Тогда
		ОтборСтрок = Новый Структура;
		ОтборСтрок.Вставить("ЭлементарныйВопрос", ПредопределенноеЗначение("ПланВидовХарактеристик.ВопросыДляАнкетирования.ПустаяСсылка"));
		ОтборСтрок.Вставить("Уровень", 3);
		Элементы.Ответы.ОтборСтрок = Новый ФиксированнаяСтруктура(ОтборСтрок);
		УстановитьДоступность(Форма, УстанавливатьДоступность, Ложь);
	Иначе
		ЭлементарныйВопрос = ТекущиеДанные.ПолучитьРодителя().ЭлементарныйВопрос;
		ОтветНаВопрос = ТекущиеДанные.ОтветНаВопрос;
		ВопросДляСобеседования = ВопросСобеседования(Форма);
		ОтборСтрок = Новый Структура;
		ОтборСтрок.Вставить("ЭлементарныйВопрос", ЭлементарныйВопрос);
		ОтборСтрок.Вставить("ОтветНаВопрос", ОтветНаВопрос);
		ОтборСтрок.Вставить("ВопросДляСобеседования", ВопросДляСобеседования);
		ОтборСтрок.Вставить("Уровень", 3);
		Элементы.Ответы.ОтборСтрок = Новый ФиксированнаяСтруктура(ОтборСтрок);
		Если ЗначениеЗаполнено(ЭлементарныйВопрос) И ЗначениеЗаполнено(ОтветНаВопрос) Тогда
			УстановитьДоступность(Форма, УстанавливатьДоступность, Истина);
		Иначе
			УстановитьДоступность(Форма, УстанавливатьДоступность, Ложь);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОчиститьДерево(Форма, УстанавливатьДоступность)
	
	Элементы = Форма.Элементы;
	КритерииОценкиДерево = Форма.КритерииОценкиДерево;
	
	ОтборСтрок = Новый Структура;
	ОтборСтрок.Вставить("ВопросДляСобеседования", ПредопределенноеЗначение("Справочник.ВопросыДляСобеседования.ПустаяСсылка"));
	ОтборСтрок.Вставить("ЭлементарныйВопрос", ПредопределенноеЗначение("ПланВидовХарактеристик.ВопросыДляАнкетирования.ПустаяСсылка"));
	Элементы.Ответы.ОтборСтрок = Новый ФиксированнаяСтруктура(ОтборСтрок);
	УстановитьДоступность(Форма, УстанавливатьДоступность, Ложь, "КритерииОценкиДерево");
	КритерииОценкиДерево.ПолучитьЭлементы().Очистить();
			
КонецПроцедуры
 
Функция ВопросСобеседования(Форма) Экспорт 
	
	Элементы = Форма.Элементы;
	ТекущиеДанныеВопрос = Элементы.ВопросыДляСобеседования.ТекущиеДанные;
		
	Возврат ТекущиеДанныеВопрос.ВопросДляСобеседования;
	
КонецФункции

Процедура УстановитьДоступность(Форма, УстанавливатьДоступность, Доступность, ИмяЭлемента="") Экспорт 
	
	Элементы = Форма.Элементы;
	Если Не УстанавливатьДоступность Тогда
		Возврат;
	КонецЕсли;  
	
	Элементы.ОтветыДобавить.Доступность = Доступность;
	Элементы.ОтветыУдалить.Доступность = Доступность;	
	Если ИмяЭлемента = "КритерииОценкиДерево" Тогда
		Элементы.КритерииОценкиДеревоДобавитьКритерий.Доступность = Доступность;
		Элементы.КритерииОценкиДеревоДобавитьКлюч.Доступность = Доступность;
		Элементы.КритерииОценкиДеревоВвестиКомментарий.Доступность = Доступность;
		Элементы.КритерииОценкиДеревоОбновитьКритерии.Доступность = Доступность;
	КонецЕсли;

КонецПроцедуры

Процедура ЗаполнитьКритерииОценкиДерево(Форма)
	
	Элементы = Форма.Элементы;
	КритерииОценкиДерево = Форма.КритерииОценкиДерево;
	Ответы = Форма.Ответы;
	
	ТекущиеДанные = Элементы.ВопросыДляСобеседования.ТекущиеДанные;
	ВопросДляСобеседования = ТекущиеДанные.ВопросДляСобеседования;
	
	КритерииОценкиДерево.ПолучитьЭлементы().Очистить();
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ВопросДляСобеседования", ВопросДляСобеседования);
	ОтветыОтбор = Ответы.НайтиСтроки(СтруктураПоиска);
	МассивИтог = Новый Массив;
	МассивИтогСтроки = Новый Массив;
	Для Каждого СтрокаТЗ Из ОтветыОтбор Цикл
		Если МассивИтог.Найти(СтрокаТЗ.ЭлементарныйВопрос) = Неопределено И ЗначениеЗаполнено(СтрокаТЗ.ЭлементарныйВопрос) Тогда
			МассивИтог.Добавить(СтрокаТЗ.ЭлементарныйВопрос);
			МассивИтогСтроки.Добавить(СтрокаТЗ);
		КонецЕсли; 
	КонецЦикла; 
	
	Для Каждого Выборка0 Из МассивИтогСтроки Цикл
		НоваяСтрока0 = КритерииОценкиДерево.ПолучитьЭлементы().Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока0, Выборка0);
		НоваяСтрока0.Уровень = 0;
		
		Порядок = 1;
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("ЭлементарныйВопрос", Выборка0.ЭлементарныйВопрос);
		СтруктураПоиска.Вставить("ВопросДляСобеседования", ВопросДляСобеседования);
		Выборка2 = Ответы.НайтиСтроки(СтруктураПоиска);
		МассивИтог2 = Новый Массив;
		МассивИтогСтроки2 = Новый Массив;
		Для Каждого СтрокаТЗ Из Выборка2 Цикл
			Если МассивИтог2.Найти(СтрокаТЗ.ОтветНаВопрос) = Неопределено И ЗначениеЗаполнено(СтрокаТЗ.ОтветНаВопрос) Тогда
				МассивИтог2.Добавить(СтрокаТЗ.ОтветНаВопрос);
				МассивИтогСтроки2.Добавить(СтрокаТЗ);
			КонецЕсли; 
		КонецЦикла;

		Для Каждого Выборка1 Из МассивИтогСтроки2 Цикл
			Если ЗначениеЗаполнено(Выборка1.ОтветНаВопрос) Тогда
				НоваяСтрока1 = НоваяСтрока0.ПолучитьЭлементы().Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока1, Выборка1);
				НоваяСтрока1.ТребуетсяКомментарий = Ложь;
				НоваяСтрока1.ПояснениеКомментария = "";
				НоваяСтрока1.Наименование = Выборка1.ОтветНаименование;
				НоваяСтрока1.Уровень = 1;
				НоваяСтрока1.Порядок = Порядок;
				СтруктураПоиска = Новый Структура;
				СтруктураПоиска.Вставить("ЭлементарныйВопрос", НоваяСтрока0.ЭлементарныйВопрос);
				СтруктураПоиска.Вставить("ОтветНаВопрос", НоваяСтрока1.ОтветНаВопрос);
				СтруктураПоиска.Вставить("ВопросДляСобеседования", ВопросДляСобеседования);
				СтруктураПоиска.Вставить("Уровень", 3);
				Массив = Ответы.НайтиСтроки(СтруктураПоиска);
				НоваяСтрока1.КоличествоКлючей = Массив.Количество();
			КонецЕсли;
			Порядок = Порядок + 1;
			
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого ЭлДерева Из КритерииОценкиДерево.ПолучитьЭлементы() Цикл
		Элементы.КритерииОценкиДерево.Развернуть(ЭлДерева.ПолучитьИдентификатор(), Истина);
	КонецЦикла; 

КонецПроцедуры

#КонецОбласти

#КонецОбласти

