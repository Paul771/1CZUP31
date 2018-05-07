#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаДокумента.
Функция ОписаниеСоставаДокумента() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.РезультатыАттестацииСотрудников;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаДокументаПоМетаданнымФизическиеЛицаВТабличныхЧастях(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#Область Печать
// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	Если ПолучитьФункциональнуюОпцию("ИспользоватьАттестацииСотрудников") Тогда
		// График аттестации сотрудников.
		КомандаПечати = КомандыПечати.Добавить();
		КомандаПечати.Обработчик = "ЗарплатаКадрыКлиент.ВыполнитьКомандуПечати";
		КомандаПечати.Идентификатор = "ПФ_MXL_ПротоколЗаседанияАттестационнойКомиссии";
		КомандаПечати.Представление = НСтр("ru = 'Протокол заседания аттестационной комиссии'");
		КомандаПечати.Порядок = 10;
		КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
		
	КонецЕсли;	
	
КонецПроцедуры

// Сформировать печатные формы объектов.
//
// ВХОДЯЩИЕ:
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать.
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы.
//   ОшибкиПечати          - Список значений  - Ошибки печати  (значение - ссылка на объект, представление - текст
//                           ошибки).
//   ОбъектыПечати         - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя
//                           области в которой был выведен объект).
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПараметрыВывода.ДоступнаПечатьПоКомплектно = Истина;
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_ПротоколЗаседанияАттестационнойКомиссии") Тогда
		ТабличныйДокумент = ТабличныйДокументПротоколЗаседанияАттестационнойКомиссии(МассивОбъектов, ОбъектыПечати);
		Если НЕ ТабличныйДокумент = Неопределено Тогда
			УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм,	"ПФ_MXL_ПротоколЗаседанияАттестационнойКомиссии", НСтр("ru = 'Протокол заседания аттестационной комиссии'"), ТабличныйДокумент);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Процедура печати документа.
// Возвращает табличный документ - сформированную печатную форму протокол заседания Комиссии.
//
// Параметры:
//	МассивОбъектов - массив сотрудников.
//  ОбъектыПечати  - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя области в
//                   которой был выведен объект).
//
// Возвращаемое значение:
//	Табличный документ
//
Функция ТабличныйДокументПротоколЗаседанияАттестационнойКомиссии(МассивСсылок, ОбъектыПечати)
	
	ДокументРезультат = Новый ТабличныйДокумент;
	ДокументРезультат.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	ДокументРезультат.АвтоМасштаб = Истина;
	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_ПротоколАттестацииСотрудников";
	
	МассивДанныхДляПечати = ДанныеДляПечатиПротоколЗаседанияАттестационнойКомиссии(МассивСсылок);
	ДанныеДляПечати			 		= МассивДанныхДляПечати[1].Выбрать();
	ДанныеДляПечатиОтветственных 	= МассивДанныхДляПечати[2].Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	ДанныеДляПечатиСотрудников	 	= МассивДанныхДляПечати[3].Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	ПервыйДокумент = Истина;
	
	Пока ДанныеДляПечати.СледующийПоЗначениюПоля("Ссылка") Цикл
		
		ОбластиМакета = ОбластиМакетаПротоколЗаседанияАттестационнойКомиссии(ДанныеДляПечати.ВидАттестации);
		
		Если Не ПервыйДокумент Тогда
			ДокументРезультат.ВывестиГоризонтальныйРазделительСтраниц();
		Иначе
			ПервыйДокумент = Ложь;
		КонецЕсли;
		НомерСтрокиНачало = ДокументРезультат.ВысотаТаблицы + 1;
		
		СтруктураЗаполнения = Новый Структура("Организация, Дата, Номер");
		СтруктураЗаполнения.Организация = ?(ЗначениеЗаполнено(ДанныеДляПечати.НаименованиеПолное), ДанныеДляПечати.НаименованиеПолное, ДанныеДляПечати.НаименованиеСокращенное);
		СтруктураЗаполнения.Дата 		= Формат(ДанныеДляПечати.Дата, "ДЛФ=DD");
		СтруктураЗаполнения.Номер 		= КадровыйУчетРасширенный.НомерКадровогоПриказа(ДанныеДляПечати.Номер);
		
		ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьШапка.Параметры, СтруктураЗаполнения);
		ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьПовестка.Параметры, ДанныеДляПечати);
		ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьРешениеКомиссииНачало.Параметры, ДанныеДляПечати);
		
		ДокументРезультат.Вывести(ОбластиМакета.ОбластьШапка);
		
		ДанныеДляПечатиОтветственных.Сбросить(); 
		ДанныеДляПечатиОтветственныхДокумента = Неопределено;
		Если ДанныеДляПечатиОтветственных.НайтиСледующий(Новый Структура("Ссылка", ДанныеДляПечати.Ссылка)) Тогда
			ДанныеДляПечатиОтветственныхДокумента = ДанныеДляПечатиОтветственных.Выбрать();
			НомерПоПорядку = 1;
			Пока ДанныеДляПечатиОтветственныхДокумента.Следующий() Цикл
				ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьЧленКомиссии.Параметры, ДанныеДляПечатиОтветственныхДокумента);
				
				СтруктураЗаполнения = Новый Структура("НомерПоПорядку");
				СтруктураЗаполнения.НомерПоПорядку = НомерПоПорядку;
				ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьЧленКомиссии.Параметры, СтруктураЗаполнения);
				НомерПоПорядку = НомерПоПорядку + 1;
				
				ДокументРезультат.Вывести(ОбластиМакета.ОбластьЧленКомиссии);
			КонецЦикла; 
		КонецЕсли;
		
		ДокументРезультат.Вывести(ОбластиМакета.ОбластьПовестка);
		
		ДанныеДляПечатиСотрудников.Сбросить();
		ДанныеДляПечатиСотрудниковДокумента = Неопределено;
		Если ДанныеДляПечатиСотрудников.НайтиСледующий(Новый Структура("Ссылка", ДанныеДляПечати.Ссылка)) Тогда
			ДанныеДляПечатиСотрудниковДокумента = ДанныеДляПечатиСотрудников.Выбрать();
			НомерПоПорядку = 1;
			Пока ДанныеДляПечатиСотрудниковДокумента.Следующий() Цикл
				ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьАттестуемый.Параметры, ДанныеДляПечатиСотрудниковДокумента);
				
				СтруктураЗаполнения = Новый Структура("НомерПоПорядку");
				СтруктураЗаполнения.НомерПоПорядку = НомерПоПорядку;
				ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьАттестуемый.Параметры, СтруктураЗаполнения);
				НомерПоПорядку = НомерПоПорядку + 1;
				
				ДокументРезультат.Вывести(ОбластиМакета.ОбластьАттестуемый);
			КонецЦикла; 
		КонецЕсли;
		
		ДокументРезультат.Вывести(ОбластиМакета.ОбластьРешениеКомиссииНачало);
		
		Если НЕ ДанныеДляПечатиСотрудниковДокумента = Неопределено Тогда
			ДанныеДляПечатиСотрудниковДокумента.Сбросить();
			НомерПоПорядку = 1;
			Пока ДанныеДляПечатиСотрудниковДокумента.Следующий() Цикл
				ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьРешениеКомиссии.Параметры, ДанныеДляПечатиСотрудниковДокумента);
				СтруктураЗаполнения = Новый Структура("НомерПоПорядку");
				СтруктураЗаполнения.НомерПоПорядку = НомерПоПорядку;
				ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьРешениеКомиссии.Параметры, СтруктураЗаполнения);
				ДокументРезультат.Вывести(ОбластиМакета.ОбластьРешениеКомиссии);
				НомерПоПорядку = НомерПоПорядку + 1;
			КонецЦикла; 
		КонецЕсли;
		
		Если НЕ ДанныеДляПечатиОтветственныхДокумента = Неопределено  Тогда
			
			ДанныеДляПечатиОтветственныхДокумента.Сбросить();
			
			СтруктураЗаполнения = Новый Структура("ФамилияИОПредседателя, ФамилияИОЗаместителяПредседателя, ФамилияИОСекретаря");
			Если ДанныеДляПечатиОтветственныхДокумента.НайтиСледующий(1, "ПорядокРолей") Тогда
				СтруктураЗаполнения.ФамилияИОПредседателя = ДанныеДляПечатиОтветственныхДокумента.ФамилияИОЧленаКомиссии;
			КонецЕсли;
			Если ДанныеДляПечатиОтветственныхДокумента.НайтиСледующий(2, "ПорядокРолей") Тогда
				СтруктураЗаполнения.ФамилияИОЗаместителяПредседателя = ДанныеДляПечатиОтветственныхДокумента.ФамилияИОЧленаКомиссии;
			КонецЕсли;
			Если ДанныеДляПечатиОтветственныхДокумента.НайтиСледующий(3, "ПорядокРолей") Тогда
				СтруктураЗаполнения.ФамилияИОСекретаря = ДанныеДляПечатиОтветственныхДокумента.ФамилияИОЧленаКомиссии;
			КонецЕсли;
			ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьПодвал.Параметры, СтруктураЗаполнения);
			ДокументРезультат.Вывести(ОбластиМакета.ОбластьПодвал);
			
			Пока ДанныеДляПечатиОтветственныхДокумента.СледующийПоЗначениюПоля("ЧленКомиссии") Цикл
				Если ДанныеДляПечатиОтветственныхДокумента.РольВКомиссии = Перечисления.РолиЧленовАттестационнойКомиссии.ЧленКомиссии Тогда
					ЗаполнитьЗначенияСвойств(ОбластиМакета.ОбластьПодписьЧленаКомиссии.Параметры, ДанныеДляПечатиОтветственныхДокумента);
					ДокументРезультат.Вывести(ОбластиМакета.ОбластьПодписьЧленаКомиссии);
				КонецЕсли;
			КонецЦикла;
			
		КонецЕсли;
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ДокументРезультат, НомерСтрокиНачало, ОбъектыПечати, ДанныеДляПечати.Ссылка);
		
	КонецЦикла;	

	Возврат ДокументРезультат;
	
КонецФункции

Функция ОбластиМакетаПротоколЗаседанияАттестационнойКомиссии(ВидАттестации)
	
	ОбластиМакета = Новый Структура;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") 
		И АттестацииСотрудников.ЭтоАттестацияГосударственныхСлужащих(ВидАттестации) Тогда
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужба");
		ОбластиМакета = Модуль.ОбластиМакетаПротоколЗаседанияАттестационнойКомиссии();		
		
	Иначе		
		
		Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.РезультатыАттестацииСотрудников.ПФ_MXL_ПротоколЗаседанияАттестационнойКомиссии");
		ОбластиМакета.Вставить("ОбластьШапка", Макет.ПолучитьОбласть("Шапка"));
		ОбластиМакета.Вставить("ОбластьЧленКомиссии", Макет.ПолучитьОбласть("ЧленКомиссии"));
		ОбластиМакета.Вставить("ОбластьПовестка", Макет.ПолучитьОбласть("Повестка"));
		ОбластиМакета.Вставить("ОбластьАттестуемый", Макет.ПолучитьОбласть("Аттестуемый"));
		ОбластиМакета.Вставить("ОбластьРешениеКомиссииНачало", Макет.ПолучитьОбласть("РешениеКомиссииНачало"));
		ОбластиМакета.Вставить("ОбластьРешениеКомиссии", Макет.ПолучитьОбласть("РешениеКомиссии"));
		ОбластиМакета.Вставить("ОбластьПодвал", Макет.ПолучитьОбласть("Подвал"));
		ОбластиМакета.Вставить("ОбластьПодписьЧленаКомиссии", Макет.ПолучитьОбласть("ПодписьЧленаКомиссии"));
		
	КонецЕсли;
	
	Возврат ОбластиМакета;
	
КонецФункции

Функция ДанныеДляПечатиПротоколЗаседанияАттестационнойКомиссии(МассивСсылок)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);

	СоздатьВТКадровыхДанных(Запрос);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	РезультатыАттестацииСотрудников.Ссылка
	|ПОМЕСТИТЬ ВТПодходящиеДокументы
	|ИЗ
	|	Документ.РезультатыАттестацииСотрудников КАК РезультатыАттестацииСотрудников
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыАттестацийСотрудников КАК ВидыАттестацийСотрудников
	|		ПО РезультатыАттестацииСотрудников.ВидАттестации = ВидыАттестацийСотрудников.Ссылка
	|			И (НЕ ВидыАттестацийСотрудников.ЭтоВнешняяАттестация)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РезультатыАттестацииСотрудников.Ссылка КАК Ссылка,
	|	РезультатыАттестацииСотрудников.Организация,
	|	РезультатыАттестацииСотрудников.Номер,
	|	РезультатыАттестацииСотрудников.Дата,
	|	Организации.НаименованиеПолное,
	|	Организации.НаименованиеСокращенное,
	|	РезультатыАттестацииСотрудников.ВидАттестации
	|ИЗ
	|	ВТПодходящиеДокументы КАК ВТПодходящиеДокументы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.РезультатыАттестацииСотрудников КАК РезультатыАттестацииСотрудников
	|		ПО ВТПодходящиеДокументы.Ссылка = РезультатыАттестацииСотрудников.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Организации КАК Организации
	|		ПО (РезультатыАттестацииСотрудников.Организация = Организации.Ссылка)
	|ГДЕ
	|	РезультатыАттестацииСотрудников.Ссылка В(&МассивСсылок)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧленыКомиссии.Ссылка КАК Ссылка,
	|	ЧленыКомиссии.ЧленКомиссии,
	|	ЧленыКомиссии.РольВКомиссии,
	|	ВЫБОР
	|		КОГДА ЧленыКомиссии.РольВКомиссии = ЗНАЧЕНИЕ(Перечисление.РолиЧленовАттестационнойКомиссии.Председатель)
	|			ТОГДА 1
	|		КОГДА ЧленыКомиссии.РольВКомиссии = ЗНАЧЕНИЕ(Перечисление.РолиЧленовАттестационнойКомиссии.ЗаместительПредседателя)
	|			ТОГДА 2
	|		КОГДА ЧленыКомиссии.РольВКомиссии = ЗНАЧЕНИЕ(Перечисление.РолиЧленовАттестационнойКомиссии.Секретарь)
	|			ТОГДА 3
	|		ИНАЧЕ 4
	|	КОНЕЦ КАК ПорядокРолей,
	|	ВТКадровыеДанныеФизическихЛиц.ФИОПолные КАК ФИОЧленаКомиссии,
	|	ВТКадровыеДанныеФизическихЛиц.ИОФамилия КАК ФамилияИОЧленаКомиссии
	|ИЗ
	|	ВТПодходящиеДокументы КАК ВТПодходящиеДокументы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.РезультатыАттестацииСотрудников.СоставАттестационнойКомиссии КАК ЧленыКомиссии
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТКадровыеДанныеФизическихЛиц КАК ВТКадровыеДанныеФизическихЛиц
	|			ПО ЧленыКомиссии.ЧленКомиссии = ВТКадровыеДанныеФизическихЛиц.ФизическоеЛицо
	|				И ЧленыКомиссии.Ссылка.Дата = ВТКадровыеДанныеФизическихЛиц.Период
	|		ПО ВТПодходящиеДокументы.Ссылка = ЧленыКомиссии.Ссылка
	|ГДЕ
	|	ЧленыКомиссии.Ссылка В(&МассивСсылок)
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПорядокРолей
	|ИТОГИ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Результаты.Ссылка КАК Ссылка,
	|	Результаты.Сотрудник КАК Сотрудник,
	|	Результаты.РезультатАттестации,
	|	ВТКадровыеДанныеСотрудников.ФИОПолные КАК ФИОАттестуемого,
	|	Результаты.Должность
	|ИЗ
	|	ВТПодходящиеДокументы КАК ВТПодходящиеДокументы
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.РезультатыАттестацииСотрудников.РезультатыАттестации КАК Результаты
	|			ЛЕВОЕ СОЕДИНЕНИЕ ВТКадровыеДанныеСотрудников КАК ВТКадровыеДанныеСотрудников
	|			ПО Результаты.Сотрудник = ВТКадровыеДанныеСотрудников.Сотрудник
	|				И Результаты.Ссылка.Дата = ВТКадровыеДанныеСотрудников.Период
	|		ПО ВТПодходящиеДокументы.Ссылка = Результаты.Ссылка
	|ГДЕ
	|	Результаты.Ссылка В(&МассивСсылок)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Сотрудник
	|ИТОГИ ПО
	|	Ссылка";
	
	Возврат Запрос.ВыполнитьПакет();
	
КонецФункции

Процедура СоздатьВТКадровыхДанных(Запрос)
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Сотрудники.Сотрудник КАК Сотрудник,
	|	Сотрудники.Ссылка.Дата КАК Период
	|ПОМЕСТИТЬ ВТСотрудники
	|ИЗ
	|	Документ.РезультатыАттестацииСотрудников.РезультатыАттестации КАК Сотрудники
	|ГДЕ
	|	Сотрудники.Ссылка В(&МассивСсылок)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЧленыКомиссии.ЧленКомиссии КАК ФизическоеЛицо,
	|	ЧленыКомиссии.Ссылка.Дата КАК Период
	|ПОМЕСТИТЬ ВТФизическиеЛица
	|ИЗ
	|	Документ.РезультатыАттестацииСотрудников.СоставАттестационнойКомиссии КАК ЧленыКомиссии
	|ГДЕ
	|	ЧленыКомиссии.Ссылка В(&МассивСсылок)";
	
	Запрос.Выполнить();
	
	Описатель = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеСотрудников(Запрос.МенеджерВременныхТаблиц, "ВТСотрудники");
	КадровыйУчет.СоздатьВТКадровыеДанныеСотрудников(Описатель, Истина, "ФИОПолные,ИОФамилия");
	
	Описатель = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеФизическихЛиц(Запрос.МенеджерВременныхТаблиц, "ВТФизическиеЛица");
	КадровыйУчет.СоздатьВТКадровыеДанныеФизическихЛиц(Описатель, Истина, "ФИОПолные,ИОФамилия");
	
КонецПроцедуры

#КонецОбласти

Функция ПолныеПраваНаДокумент() Экспорт 
	
	Возврат Пользователи.РолиДоступны("ДобавлениеИзменениеДанныхДляНачисленияЗарплатыРасширенная, ЧтениеДанныхДляНачисленияЗарплатыРасширенная", , Ложь);
	
КонецФункции	

Функция ДанныеДляПроверкиОграниченийНаУровнеЗаписей(Объект) Экспорт 
	
	ДанныеДляПроверкиОграничений = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("ТаблицаСотрудников", Объект.РезультатыАттестации.Выгрузить(, "Сотрудник,ДатаАттестации"));
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ДанныеСотрудников.ДатаАттестации КАК Период,
	|	ДанныеСотрудников.Сотрудник КАК Сотрудник
	|ПОМЕСТИТЬ ВТСписокСотрудников
	|ИЗ
	|	&ТаблицаСотрудников КАК ДанныеСотрудников";
	
	Запрос.Выполнить();
	
	ОписательВременныхТаблиц = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеСотрудников(
		Запрос.МенеджерВременныхТаблиц,
		"ВТСписокСотрудников");
	КадровыйУчет.СоздатьВТКадровыеДанныеСотрудников(ОписательВременныхТаблиц, Истина, "ФизическоеЛицо,Подразделение");
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КадровыеДанныеСотрудников.Сотрудник,
	|	КадровыеДанныеСотрудников.Период КАК ДатаАттестации,
	|	КадровыеДанныеСотрудников.ФизическоеЛицо КАК ФизическоеЛицо,
	|	КадровыеДанныеСотрудников.Подразделение КАК Подразделение
	|ИЗ
	|	ВТКадровыеДанныеСотрудников КАК КадровыеДанныеСотрудников
	|
	|УПОРЯДОЧИТЬ ПО
	|	Подразделение,
	|	ФизическоеЛицо";
	КадровыеДанныеСотрудников = Запрос.Выполнить().Выгрузить();

	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.СледующийПоЗначениюПоля("Подразделение") Цикл
		
		ОписаниеСтруктурыДанных = ЗарплатаКадрыРасширенный.ОписаниеСтруктурыДанныхДляПроверкиОграниченийНаУровнеЗаписей();
		ОписаниеСтруктурыДанных.Организация = Объект.Организация;
		ОписаниеСтруктурыДанных.Подразделение = Выборка.Подразделение;
		
		Пока Выборка.Следующий() Цикл
			Если ОписаниеСтруктурыДанных.МассивФизическихЛиц = Неопределено Тогда
				ОписаниеСтруктурыДанных.МассивФизическихЛиц = Новый Массив;
			КонецЕсли; 
			ОписаниеСтруктурыДанных.МассивФизическихЛиц.Добавить(Выборка.ФизическоеЛицо);
		КонецЦикла; 
		
		ДанныеДляПроверкиОграничений.Добавить(ОписаниеСтруктурыДанных);
		
	КонецЦикла;
	
	Возврат ДанныеДляПроверкиОграничений;
	
КонецФункции

#КонецОбласти

#КонецЕсли
