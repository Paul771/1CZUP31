
#Область ПрограммныйИнтерфейс

// Регистрирует факт депонирования зарплаты.
//
// Параметры:
//	Движения          - КоллекцияДвижений - наборы записей движений документа-регистратора.
//	Отказ             - Булево            - признак отказа при выполнении операции.
//	Зарплата          - ТаблицаЗначений   - депонируемая зарплата, см. НоваяТаблицаДепонированнойЗарплаты.
//	ОтражатьВБухучете - Булево            - если Истина, то операция будет отражена в бухгалтерском учета.
//
Процедура ЗарегистрироватьДепонированнуюЗарплату(Движения, Отказ, Знач Зарплата, ОтражатьВБухучете = Ложь) Экспорт
	
	// Взаиморасчеты с депонентами.
	ДепонируемыеСуммы = Зарплата.Скопировать();
	
	ДепонируемыеСуммы.Колонки.Добавить("ВидДвижения");
	ДепонируемыеСуммы.ЗаполнитьЗначения(ВидДвиженияНакопления.Приход, "ВидДвижения");
	
	ДепонируемыеСуммы.Колонки.Дата.Имя = "Период";
	
	Движения.ВзаиморасчетыСДепонентами.Загрузить(ДепонируемыеСуммы);
	
	Движения.ВзаиморасчетыСДепонентами.Записывать = Истина;
	
	// Отражение в бухучете
	Если ОтражатьВБухучете Тогда
		
		КолонкиГруппировок = "Дата, Организация";
		ОрганизацииДаты = Зарплата.Скопировать(, КолонкиГруппировок);
		ОрганизацииДаты.Свернуть(КолонкиГруппировок);
		
		Отбор = Новый Структура(КолонкиГруппировок);
		Для Каждого ОрганизацияДата Из ОрганизацииДаты Цикл
			
			ЗаполнитьЗначенияСвойств(Отбор, ОрганизацияДата);
			
			Депоненты = Зарплата.Скопировать(Отбор, "ФизическоеЛицо, Сумма");
			Депоненты.Свернуть("ФизическоеЛицо", "Сумма");
			
			ОтразитьВБухучете(Перечисления.ВидыОперацийПоЗарплате.Депонирование, Движения, Отказ, ОрганизацияДата.Организация, ОрганизацияДата.Дата, Зарплата);
			
		КонецЦикла	
		
	КонецЕсли	
	
КонецПроцедуры

// Возвращает сведения об остатках депонированной зарплаты.
//
// Параметры:
//	Регистратор 	- ДокументСсылка - документ-заказчик (его выплаты депонентов не учитываются).
//	Организация		- СправочникСсылка.Организации - Организация.
//	ДатаВыплаты		- Дата   - дата, на которую определяются остатки (дата выплаты депонированных сумм).
//  ФизическиеЛица	- Массив - физические лица (необязательное, если не указано - по всем физлицам).
//	ДепонированоДо	- Дата   - дата депонирования, по которую учитываются депонированные суммы.
//
// Возвращаемое значение:
//		ТаблицаЗначений - таблица с колонками:
//			ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица.
//			Сумма			- Число - остаток депонированной зарплаты.
//			Ведомость		- ДокументСсылка.ВедомостьНаВыплатуЗарплатыВКассу - ведомость, зарплата которой была депонирована.
//
Функция ОстатокДепонированнойЗарплаты(Регистратор, Организация, ДатаВыплаты, ФизическиеЛица = Неопределено, ДепонированоДо = Неопределено) Экспорт
	
	Запрос = Новый Запрос();
	Запрос.УстановитьПараметр("Регистратор",		Регистратор);
	Запрос.УстановитьПараметр("Организация",		Организация);
	Запрос.УстановитьПараметр("ДатаВыплаты",		ДатаВыплаты);
	
	Запрос.УстановитьПараметр("ФизическиеЛица", ФизическиеЛица);
	Запрос.УстановитьПараметр("ПоВсемФизлицам", ФизическиеЛица = Неопределено);
	
	Запрос.УстановитьПараметр("ДепонированоДо",	ДепонированоДо);
	Запрос.УстановитьПараметр("ПоВсемПериодам",	ДепонированоДо = Неопределено);
	
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ВзаиморасчетыСДепонентами.Ведомость,
	|	ВзаиморасчетыСДепонентами.ФизическоеЛицо
	|ПОМЕСТИТЬ ВТДепонирования
	|ИЗ
	|	РегистрНакопления.ВзаиморасчетыСДепонентами КАК ВзаиморасчетыСДепонентами
	|ГДЕ
	|	ВзаиморасчетыСДепонентами.Организация = &Организация
	|	И (&ПоВсемФизлицам
	|			ИЛИ ВзаиморасчетыСДепонентами.ФизическоеЛицо В (&ФизическиеЛица))
	|	И ВзаиморасчетыСДепонентами.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|	И (&ПоВсемПериодам
	|			ИЛИ ВзаиморасчетыСДепонентами.Период < &ДепонированоДо)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	НеВыплаченныеДепоненты.ФизическоеЛицо,
	|	НеВыплаченныеДепоненты.Ведомость,
	|	СУММА(НеВыплаченныеДепоненты.Сумма) КАК Сумма
	|ИЗ
	|	(ВЫБРАТЬ
	|		ВзаиморасчетыСДепонентами.Ведомость КАК Ведомость,
	|		ВзаиморасчетыСДепонентами.ФизическоеЛицо КАК ФизическоеЛицо,
	|		ВзаиморасчетыСДепонентами.СуммаОстаток КАК Сумма
	|	ИЗ
	|		РегистрНакопления.ВзаиморасчетыСДепонентами.Остатки(
	|				КОНЕЦПЕРИОДА(&ДатаВыплаты, ДЕНЬ),
	|				(Ведомость, ФизическоеЛицо) В
	|					(ВЫБРАТЬ
	|						ВТДепонирования.Ведомость,
	|						ВТДепонирования.ФизическоеЛицо
	|					ИЗ
	|						ВТДепонирования)) КАК ВзаиморасчетыСДепонентами
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ВзаиморасчетыСДепонентами.Ведомость,
	|		ВзаиморасчетыСДепонентами.ФизическоеЛицо,
	|		ВЫБОР
	|			КОГДА ВзаиморасчетыСДепонентами.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				ТОГДА ВзаиморасчетыСДепонентами.Сумма
	|			ИНАЧЕ -ВзаиморасчетыСДепонентами.Сумма
	|		КОНЕЦ * -1
	|	ИЗ
	|		РегистрНакопления.ВзаиморасчетыСДепонентами КАК ВзаиморасчетыСДепонентами
	|	ГДЕ
	|		ВзаиморасчетыСДепонентами.Регистратор = &Регистратор
	|		И ВзаиморасчетыСДепонентами.Период < КОНЕЦПЕРИОДА(&ДатаВыплаты, ДЕНЬ)
	|		И (ВзаиморасчетыСДепонентами.Ведомость, ВзаиморасчетыСДепонентами.ФизическоеЛицо) В
	|				(ВЫБРАТЬ
	|					ВТДепонирования.Ведомость,
	|					ВТДепонирования.ФизическоеЛицо
	|				ИЗ
	|					ВТДепонирования)) КАК НеВыплаченныеДепоненты
	|
	|СГРУППИРОВАТЬ ПО
	|	НеВыплаченныеДепоненты.ФизическоеЛицо,
	|	НеВыплаченныеДепоненты.Ведомость
	|
	|ИМЕЮЩИЕ
	|	СУММА(НеВыплаченныеДепоненты.Сумма) > 0";
	
	ОстатокДепонированнойЗарплаты = Запрос.Выполнить().Выгрузить();
	
	Возврат ОстатокДепонированнойЗарплаты;
	
КонецФункции

// Регистрирует списание (выдачу) депонированных сумм.
//
// Параметры:
//	Движения     - КоллекцияДвижений - наборы записей движений документа-регистратора.
//	Отказ        - Булево            - признак отказа при выполнении операции.
//	Организация  - СправочникСсылка.Организации - организация.
//	ДатаСписания - Дата - дата списания депонированных сумм/
//	Зарплата     - ТаблицаЗначений - таблица списываемых сумм с колонками:
//	                   * ФизическоеЛицо - СправочникСсылка.ФизическиеЛица - депонент.
//	                   * Сумма          - Число - списываемая (выдаваемая) сумма.
//	                   * Ведомость      - ДокументСсылка.ВедомостьНаВыплатуЗарплатыВКассу - ведомость, по которой была депонирована зарплата.
//	ОтражатьВБухучете        - Булево - если Истина, то операция будет отражена в бухгалтерском учета
//	НомерПлатежногоДокумента - Строка - номер платежного документа, которым выдается депонированная зарплата.
//
Процедура СписатьДепонированнуюЗарплату(Движения, Отказ, Организация, ДатаСписания, Знач Зарплата, ОтражатьВБухучете = Ложь, НомерПлатежногоДокумента = "") Экспорт
	
	Регистратор = Движения.ВзаиморасчетыСДепонентами.Отбор.Регистратор.Значение;
	Если НЕ ЗначениеЗаполнено(НомерПлатежногоДокумента) Тогда
		НомерПлатежногоДокумента = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Регистратор, "Номер");
	КонецЕсли;	
	
	// Взаиморасчеты с депонентами.
	СписываемыеСуммы = Зарплата.Скопировать();
	
	СписываемыеСуммы.Колонки.Добавить("ВидДвижения");
	СписываемыеСуммы.ЗаполнитьЗначения(ВидДвиженияНакопления.Расход, "ВидДвижения");
	
	СписываемыеСуммы.Колонки.Добавить("Организация", Новый ОписаниеТипов("СправочникСсылка.Организации"));
	СписываемыеСуммы.ЗаполнитьЗначения(Организация, "Организация");
	
	СписываемыеСуммы.Колонки.Добавить("НомерПлатежногоДокумента", Новый ОписаниеТипов("Строка"));
	СписываемыеСуммы.ЗаполнитьЗначения(НомерПлатежногоДокумента, "НомерПлатежногоДокумента");
	
	СписываемыеСуммы.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	СписываемыеСуммы.ЗаполнитьЗначения(ДатаСписания, "Период");
	
	Движения.ВзаиморасчетыСДепонентами.Загрузить(СписываемыеСуммы);
	
	Движения.ВзаиморасчетыСДепонентами.Записывать = Истина;
	
	// Отражение в бухучете
	Если ОтражатьВБухучете Тогда
		ОтразитьВБухучете(Перечисления.ВидыОперацийПоЗарплате.СписаниеДепонента, Движения, Отказ, Организация, ДатаСписания, Зарплата)
	КонецЕсли	
	
КонецПроцедуры

// Конструктор таблицы данных о депонируемой зарплате.
//
// Возвращаемое значение:
// 	ТаблицаЗначений - таблица с колонками:
// 		* Дата           - Дата - дата депонирования.
// 		* Организация    - СправочникСсылка.Организации - Организация.
// 		* ФизическоеЛицо - СправочникСсылка.ФизическиеЛица - Депонент.
// 		* Сумма - Число  - Депонируемая сумма.
// 		* Ведомость            - ДокументСсылка.ВедомостьНаВыплатуЗарплатыВКассу - ведомость, зарплата которой депонируется.
// 		* СтатьяФинансирования - СправочникСсылка.СтатьиФинансированияЗарплата   - Статья финансирования.
// 		* СтатьяРасходов       - СправочникСсылка.СтатьиРасходовЗарплата         - Статья расходов.
//
Функция НоваяТаблицаДепонированнойЗарплаты() Экспорт
	
	НаборЗаписей = РегистрыНакопления.ВзаиморасчетыСДепонентами.СоздатьНаборЗаписей();
	
	Колонки = Новый Массив;
	Колонки.Добавить("Период");
	Колонки.Добавить("Организация");
	Колонки.Добавить("ФизическоеЛицо");
	Колонки.Добавить("Сумма");
	Колонки.Добавить("Ведомость");
	Колонки.Добавить("СтатьяФинансирования");
	Колонки.Добавить("СтатьяРасходов");
	Колонки = СтрСоединить(Колонки, ", ");
	
	Таблица = НаборЗаписей.ВыгрузитьКолонки(Колонки);
	Таблица.Колонки.Период.Имя = "Дата";
	
	Возврат Таблица
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

// См. ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ПриДобавленииОбработчиковОбновления.
Процедура ЗарегистрироватьОбработчикиОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "3.0.6.13";
	Обработчик.Процедура = "РегистрыНакопления.ВзаиморасчетыСДепонентами.ЗаполнитьВедомость";
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// См. УправлениеПечатьюПереопределяемый.ПриОпределенииОбъектовСКомандамиПечати.
Процедура ПриОпределенииОбъектовСКомандамиПечати(СписокОбъектов) Экспорт
	
	СписокОбъектов.Добавить(Документы.ДепонированиеЗарплаты);
	СписокОбъектов.Добавить(Документы.СписаниеДепонированнойЗарплаты);
	
КонецПроцедуры

#КонецОбласти

#Область ЗащитаПерсональныхДанных

// См. ЗащитаПерсональныхДанныхПереопределяемый.ЗаполнитьСведенияОПерсональныхДанных.
Процедура ЗаполнитьСведенияОПерсональныхДанных(ТаблицаСведений) Экспорт
	
	НовыеСведения = ТаблицаСведений.Добавить();
	НовыеСведения.Объект			= "Документ.СписаниеДепонированнойЗарплаты";
	НовыеСведения.ПоляРегистрации	= "Депоненты.ФизическоеЛицо";
	НовыеСведения.ПоляДоступа		= "СуммаДокумента,Депоненты.Сумма";
	НовыеСведения.ОбластьДанных		= "Доходы";
	
	НовыеСведения = ТаблицаСведений.Добавить();
	НовыеСведения.Объект			= "РегистрНакопления.ВзаиморасчетыСДепонентами";
	НовыеСведения.ПоляРегистрации	= "ФизическоеЛицо";
	НовыеСведения.ПоляДоступа		= "Сумма";
	НовыеСведения.ОбластьДанных		= "Доходы";
	
КонецПроцедуры

#КонецОбласти

#Область ДатыЗапретаИзмененияДанных

// См. ДатыЗапретаИзмененияПереопределяемый.ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения.
Процедура ЗаполнитьИсточникиДанныхДляПроверкиЗапретаИзменения(ИсточникиДанных) Экспорт
	
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.ДепонированиеЗарплаты", 									"Дата", 				"Зарплата", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "Документ.СписаниеДепонированнойЗарплаты", 				"Дата", 				"Зарплата", "Организация");
	ДатыЗапретаИзменения.ДобавитьСтроку(ИсточникиДанных, "РегистрНакопления.ВзаиморасчетыСДепонентами", 			"Период", 				"Зарплата", "Организация");
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОтразитьВБухучете(ВидОперации, Движения, Отказ, Организация, ДатаОперации, Знач Зарплата)

		Депоненты = Зарплата.Скопировать();
		Депоненты.Колонки.Добавить("ВидОперации", Новый ОписаниеТипов("ПеречислениеСсылка.ВидыОперацийПоЗарплате"));
		Депоненты.ЗаполнитьЗначения(ВидОперации, "ВидОперации");
		
		УчетДепонированнойЗарплатыПереопределяемый.ОтразитьВБухучете(Движения, Отказ, Организация, ДатаОперации, Депоненты);
		
КонецПроцедуры

/// Обработчики событий модуля объекта документов Депонирование зарплаты.

Процедура ДепонированиеЗарплатыОбработкаПроведения(ДокументОбъект, Отказ) Экспорт
	УчетДепонированнойЗарплатыВнутренний.ДепонированиеЗарплатыОбработкаПроведения(ДокументОбъект, Отказ);
КонецПроцедуры

#КонецОбласти
