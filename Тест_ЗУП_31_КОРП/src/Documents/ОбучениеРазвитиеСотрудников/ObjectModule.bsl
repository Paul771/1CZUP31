#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, Режим)
	
	ПроведениеСервер.ПодготовитьНаборыЗаписейКРегистрацииДвижений(ЭтотОбъект);
	
	ДанныеДляПроведения = Документы.ОбучениеРазвитиеСотрудников.ПолучитьДанныеДляПроведения(Ссылка);
	
	ОбучениеРазвитие.СформироватьДвиженияОбучения(Движения, ДанныеДляПроведения.ДвиженияОбучения);
	
	ЗарегистрироватьЭлектронныеКурсы(Движения, ДанныеДляПроведения.ЭлектронныеКурсы);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЗаявкаНаОбучениеРазвитие") Тогда
		
		РеквизитыДанныеЗаполнения = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
			ДанныеЗаполнения,
			"Статус, Подразделение, Мероприятие, ДатаНачала, ДатаОкончания, СуммаРасходов");
		
		Если НЕ РеквизитыДанныеЗаполнения.Статус = ПредопределенноеЗначение("Перечисление.СостоянияСогласования.Согласовано") Тогда
			ВызватьИсключение НСтр("ru = 'Обучение может вводиться только на основании утвержденных заявок.'");
			Возврат;
		КонецЕсли;
	
		Основание = ДанныеЗаполнения;
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, РеквизитыДанныеЗаполнения, "Подразделение, Мероприятие, ДатаНачала, ДатаОкончания, СуммаРасходов");
		
		МероприятиеСтруктураРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Мероприятие,
			"Наименование, Стоимость, СпособОпределенияСтоимости, Преподаватель, Контрагент, МестоПроведения, КоличествоУчебныхЧасов");
		ЗаполнитьЗначенияСвойств(ЭтотОбъект,МероприятиеСтруктураРеквизитов,"Преподаватель, Контрагент, МестоПроведения, КоличествоУчебныхЧасов");
		
		// Заполнение табличной части "Сотрудники".
		Сотрудники.Загрузить(ДанныеЗаполнения.Сотрудники.Выгрузить());
		
		// Заполнение табличной части "Расходы".
		Расходы.Очистить();
		Если Сотрудники.Количество() > 0 Тогда
			НоваяСтрокаРасходов = Расходы.Добавить();
			НоваяСтрокаРасходов.Сумма = СуммаРасходов;
			НоваяСтрокаРасходов.Примечание = ОбучениеРазвитие.ПримечаниеРасходовНаОбучение(
				МероприятиеСтруктураРеквизитов.Наименование, Сотрудники.Количество());
		КонецЕсли;
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ПубликацияМероприятияОбученияРазвития") Тогда
	
		Основание = ДанныеЗаполнения;
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения, "Мероприятие, ДатаОкончания");
		ДатаНачала = ДанныеЗаполнения.ДатаНачалаСобытия;
		
		МероприятиеСтруктураРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Мероприятие,
			"Наименование, Стоимость, КоличествоУчебныхЧасов, СпособОпределенияСтоимости, Преподаватель, Контрагент, МестоПроведения");
		ЗаполнитьЗначенияСвойств(ЭтотОбъект,МероприятиеСтруктураРеквизитов,"КоличествоУчебныхЧасов, Преподаватель, Контрагент, МестоПроведения");
		
		// Заполнение табличной части "Сотрудники" откликнувшимися на публикацию
		// но не подобранными в другие документы.
		ЗаполнитьОткликнувшимися(ДанныеЗаполнения);
		
		// Заполнение табличной части "Расходы".
		ОбучениеРазвитие.ЗаполнитьТабличнуюЧастьРасходовПоМероприятию(МероприятиеСтруктураРеквизитов, Расходы, Сотрудники.Количество());
		СуммаРасходов = Расходы.Итог("Сумма");
		
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ОбучениеРазвитиеСотрудников") Тогда // продолжение поэтапного обучения
	
		Если ЗначениеЗаполнено(ДанныеЗаполнения.ПервичныйЭтапОбучения) Тогда
			ПервичныйЭтапОбучения = ДанныеЗаполнения.ПервичныйЭтапОбучения;
		Иначе
			ПервичныйЭтапОбучения = ДанныеЗаполнения;
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(ЭтотОбъект,ДанныеЗаполнения,"Подразделение, Мероприятие, Преподаватель, Контрагент, МестоПроведения");
		
		// Заполнение табличной части "Сотрудники".
		Сотрудники.Загрузить(ДанныеЗаполнения.Сотрудники.Выгрузить());
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.МероприятияОбученияРазвития") Тогда
		
		Мероприятие = ДанныеЗаполнения;
		ЗаполнитьЗначенияСвойств(ЭтотОбъект,ДанныеЗаполнения,"КоличествоУчебныхЧасов, Преподаватель, Контрагент, МестоПроведения");
		
		// Заполнение табличной части "Расходы".
		МероприятиеСтруктураРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Мероприятие,
			"Наименование, Стоимость, СпособОпределенияСтоимости");
		ОбучениеРазвитие.ЗаполнитьТабличнуюЧастьРасходовПоМероприятию(МероприятиеСтруктураРеквизитов, Расходы, Сотрудники.Количество());
		СуммаРасходов = Расходы.Итог("Сумма");
	
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда // Заполнение по данным плана.
		
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
		
		МероприятиеСтруктураРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Мероприятие,
			"Наименование, Стоимость, СпособОпределенияСтоимости, Преподаватель, Контрагент, МестоПроведения");
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, МероприятиеСтруктураРеквизитов, "Преподаватель, Контрагент, МестоПроведения");
		
		// Заполнение табличной части "Сотрудники".
		Если ДанныеЗаполнения.Свойство("Сотрудники") Тогда
			Сотрудники.Очистить();
			Для каждого Сотрудник Из ДанныеЗаполнения.Сотрудники Цикл
				НовыйСотрудник = Сотрудники.Добавить();
				НовыйСотрудник.Сотрудник = Сотрудник;
			КонецЦикла;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	СуммаРасходов = Расходы.Итог("Сумма");
	
	Если Сотрудники.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	// Рассчитываем сумму по каждому сотруднику.
	СуммаНаЧеловека = Окр(СуммаРасходов / Сотрудники.Количество(),2);
	Остаток = СуммаРасходов - СуммаНаЧеловека*Сотрудники.Количество();
	Для каждого Сотрудник Из Сотрудники Цикл
		Сотрудник.СуммаНаСотрудника = СуммаНаЧеловека + ?(Сотрудник = Сотрудники[Сотрудники.Количество()-1],Остаток,0);
	КонецЦикла; 
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, ДатаНачала, "Объект.ДатаНачала", Отказ, НСтр("ru='Начало периода обучения'"), , , Ложь);
	
	МассивНепроверяемыхРеквизитов = Новый Массив();
	
	Если ЗначениеЗаполнено(ДатаОкончания) И ДатаНачала > ДатаОкончания Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ЭтотОбъект, НСтр("ru ='Неверно заполнен период обучения'"), "ДатаНачала",, Отказ);
		МассивНепроверяемыхРеквизитов.Добавить("ДатаНачала");
	КонецЕсли;
	
	ОбучениеРазвитие.ПроверитьТабличнуюЧастьСотрудниковНаДублиФизическихЛиц(ЭтотОбъект, Отказ);
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты,МассивНепроверяемыхРеквизитов);
	
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
	
	МассивПараметров = Новый Массив;
	МассивПараметров.Добавить(Новый Структура("Сотрудники", "Сотрудник"));
	
	Возврат ОбменДаннымиЗарплатаКадрыРасширенный.ОграниченияРегистрацииПоПодразделениюИСотрудникам(ЭтотОбъект, Подразделение, МассивПараметров, ДатаНачала);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьОткликнувшимися(Публикация)

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ОбучениеРазвитиеСотрудниковСотрудники.Сотрудник.ФизическоеЛицо КАК ФизическоеЛицо
		|ПОМЕСТИТЬ УжеПодобранныеСотрудники
		|ИЗ
		|	Документ.ОбучениеРазвитиеСотрудников.Сотрудники КАК ОбучениеРазвитиеСотрудниковСотрудники
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ОбучениеРазвитиеСотрудников КАК ОбучениеРазвитиеСотрудников
		|		ПО ОбучениеРазвитиеСотрудниковСотрудники.Ссылка = ОбучениеРазвитиеСотрудников.Ссылка
		|ГДЕ
		|	ОбучениеРазвитиеСотрудников.Основание = &Публикация
		|	И ОбучениеРазвитиеСотрудниковСотрудники.Ссылка <> &Ссылка
		|	И ОбучениеРазвитиеСотрудников.Проведен
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ОткликиНаПубликациюМероприятияОбученияРазвития.ФизическоеЛицо КАК ФизическоеЛицо
		|ПОМЕСТИТЬ Отклики
		|ИЗ
		|	РегистрСведений.ОткликиНаПубликациюМероприятияОбученияРазвития КАК ОткликиНаПубликациюМероприятияОбученияРазвития
		|ГДЕ
		|	ОткликиНаПубликациюМероприятияОбученияРазвития.Публикация = &Публикация
		|	И (ОткликиНаПубликациюМероприятияОбученияРазвития.Отклик = &Согласие
		|			ИЛИ ОткликиНаПубликациюМероприятияОбученияРазвития.Отклик = &ВозможноеСогласие)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Отклики.ФизическоеЛицо КАК ФизическоеЛицо
		|ИЗ
		|	Отклики КАК Отклики
		|		ЛЕВОЕ СОЕДИНЕНИЕ УжеПодобранныеСотрудники КАК УжеПодобранныеСотрудники
		|		ПО Отклики.ФизическоеЛицо = УжеПодобранныеСотрудники.ФизическоеЛицо
		|ГДЕ
		|	УжеПодобранныеСотрудники.ФизическоеЛицо ЕСТЬ NULL ";
	
	Запрос.УстановитьПараметр("Согласие", ПредопределенноеЗначение("Перечисление.ВариантыОткликовСотрудников.Согласие"));
	Запрос.УстановитьПараметр("ВозможноеСогласие", ПредопределенноеЗначение("Перечисление.ВариантыОткликовСотрудников.ВозможноеСогласие"));
	Запрос.УстановитьПараметр("Публикация", Публикация);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	СписокФизическихЛиц = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ФизическоеЛицо");
	
	ПараметрыСотрудников = КадровыйУчет.ПараметрыПолученияСотрудниковОрганизацийПоСпискуФизическихЛиц();
	ПараметрыСотрудников.СписокФизическихЛиц = СписокФизическихЛиц;
	
	СписокСотрудников = КадровыйУчет.СотрудникиОрганизации(Истина,ПараметрыСотрудников);
	Сотрудники.Загрузить(УдалитьСовместителей(СписокСотрудников));
	

КонецПроцедуры

// Удаляет лишних сотрудников из таблицы значений, в случае если в выборке попался совместитель
//  и сделал несколько строк с сотрудниками для одного физического лица.
Функция УдалитьСовместителей(СписокСотрудников)

	МассивУдаляемыхСтрок = Новый Массив();
	СписокФизическихЛиц = Новый СписокЗначений;
	
	Для каждого Сотрудник Из СписокСотрудников Цикл
		Если СписокФизическихЛиц.НайтиПоЗначению(Сотрудник.ФизическоеЛицо) = Неопределено Тогда
			СписокФизическихЛиц.Добавить(Сотрудник.ФизическоеЛицо);
		Иначе
			МассивУдаляемыхСтрок.Добавить(Сотрудник);
		КонецЕсли;
	КонецЦикла; 
	
	Для каждого УдаляемаяСтрока Из МассивУдаляемыхСтрок Цикл
		СписокСотрудников.Удалить(УдаляемаяСтрока);
	КонецЦикла; 
	
	Возврат СписокСотрудников;

КонецФункции

Процедура ЗарегистрироватьЭлектронныеКурсы(Движения, ЭлектронныеКурсы)
	
	Для Каждого Строка Из ЭлектронныеКурсы Цикл
		НоваяСтрока = Движения.ЭлектронныеКурсыСотрудников.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
		Движения.ЭлектронныеКурсыСотрудников.Записывать = Истина;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти 

#КонецЕсли
