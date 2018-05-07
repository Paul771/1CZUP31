
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Заголовок = Параметры.ЗаголовокФормыВыбора;
	СтруктураЗаполняемыхЗначений = Новый Структура("ИмяТаблицыДляЗаполнения, ИмяКолонкиДляЗаполнения", 
													Параметры.ИмяЭлементаФормыДляЗаполнения, 
													Параметры.ИмяРеквизитаЭлементаФормыДляЗаполнения);
	
	Если Параметры.ПараметрыВнешнегоСоединения = Неопределено Тогда
		
		Если ЗначениеЗаполнено(Параметры.МассивВыбранныхЗначений) Тогда
			МассивПереданныхЗначений = Параметры.МассивВыбранныхЗначений;
		Иначе
			МассивПереданныхЗначений = Новый Массив();
		КонецЕсли;
		
		КоллекцияДополнительныхРеквизитов = Неопределено;
		Параметры.Свойство("КоллекцияДополнительныхРеквизитов", КоллекцияДополнительныхРеквизитов);
		
		// Обновление дополнительных реквизитов и связанных с ними колонок в списке выбираемых значений.
		Если Не КоллекцияДополнительныхРеквизитов = Неопределено Тогда
			ДобавляемыеРеквизиты	= Новый Массив;
			
			Для Каждого ДополнительныйРеквизит Из КоллекцияДополнительныхРеквизитов Цикл
				НовыйРеквизит = Новый РеквизитФормы("_" + ДополнительныйРеквизит.ИмяРеквизита,
					Новый ОписаниеТипов("Строка"), "СписокВыбираемыхЗначений", ДополнительныйРеквизит.Представление);
					
				ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
			КонецЦикла;
			
			ИзменитьРеквизиты(ДобавляемыеРеквизиты);
			
			Для Каждого ДополнительныйРеквизит Из КоллекцияДополнительныхРеквизитов Цикл
				КолонкаСписка = Элементы.Добавить("СписокВыбираемыхЗначений_" + ДополнительныйРеквизит.ИмяРеквизита,
					Тип("ПолеФормы"), Элементы.СписокВыбираемыхЗначений);
					
				КолонкаСписка.ПутьКДанным = "СписокВыбираемыхЗначений._" + ДополнительныйРеквизит.ИмяРеквизита;
				
				Если ЗначениеЗаполнено(ДополнительныйРеквизит.ПредставлениеНеЗаполненного) Тогда
					Элемент = УсловноеОформление.Элементы.Добавить();
	
					ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
					ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(КолонкаСписка.Имя);
					
					ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
					ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("СписокВыбираемыхЗначений._" + ДополнительныйРеквизит.ИмяРеквизита);
					ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
					
					Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru = '" + ДополнительныйРеквизит.ПредставлениеНеЗаполненного + "'"));
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		
		ЗаполнитьСписокДоступныхЗначений( МассивПереданныхЗначений, 
										  Параметры.ИмяТаблицыВыбора,
										  Параметры.КоллекцияФильтров,
										  КоллекцияДополнительныхРеквизитов);
	
	Иначе
		
		Если Параметры.ПараметрыВнешнегоСоединения.ТипСоединения = "ВнешнееСоединение" Тогда
			
			СтрокаСообщенияОбОшибке = "";
			
			Подключение = ОбменДаннымиСервер.УстановитьВнешнееСоединениеСБазой(Параметры.ПараметрыВнешнегоСоединения);
			СтрокаСообщенияОбОшибке = Подключение.ПодробноеОписаниеОшибки;
			ВнешнееСоединение       = Подключение.Соединение;
			
			Если ВнешнееСоединение = Неопределено Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрокаСообщенияОбОшибке,,,, Отказ);
				Возврат;
			КонецЕсли;
			
			СвойстваОбъектаМетаданных = 
				ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.СвойстваОбъектаМетаданных(Параметры.ИмяТаблицыВыбора);
			
			Если ЗначениеЗаполнено(Параметры.МассивВыбранныхЗначений) Тогда
				МассивПереданныхЗначений = Параметры.МассивВыбранныхЗначений;
			Иначе
				МассивПереданныхЗначений = Новый Массив();
			КонецЕсли;
			
			Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7
				Или Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
				
				ПолученнаяКоллекцияОбъектов = 
				ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.ПолучитьОбъектыТаблицы_2_0_1_6(Параметры.ИмяТаблицыВыбора);
				
				ТаблицаБазыКорреспондента = ОбщегоНазначения.ЗначениеИзСтрокиXML(ПолученнаяКоллекцияОбъектов);
				
			Иначе
				
				ПолученнаяКоллекцияОбъектов = 
				ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.ПолучитьОбъектыТаблицы(Параметры.ИмяТаблицыВыбора);
				
				ТаблицаБазыКорреспондента = ЗначениеИзСтрокиВнутр( ПолученнаяКоллекцияОбъектов);
				
			КонецЕсли;
			
			ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение( СписокВыбираемыхЗначений, 
			МассивПереданныхЗначений, 
			ТаблицаБазыКорреспондента);
			
			Если ЗначениеЗаполнено(Параметры.КоллекцияФильтров) Тогда
				
				ПроверитьПрохождениеФильтраВнешнееСоединение(Параметры.КоллекцияФильтров);
				
			КонецЕсли;
			
		ИначеЕсли Параметры.ПараметрыВнешнегоСоединения.ТипСоединения = "ВебСервис" Тогда
			
			СтрокаСообщенияОбОшибке = "";
			
			Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7 Тогда
				
				WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси_2_1_1_7(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
				
			ИначеЕсли Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
				
				WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси_2_0_1_6(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
				
			Иначе
				
				WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
				
			КонецЕсли;
			
			Если WSПрокси = Неопределено Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрокаСообщенияОбОшибке,,,, Отказ);
				Возврат;
			КонецЕсли;
			
			Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7
				ИЛИ Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
				
				ДанныеБазыКорреспондента = СериализаторXDTO.ПрочитатьXDTO(WSПрокси.GetIBData(Параметры.ИмяТаблицыВыбора));
				
				СвойстваОбъектаМетаданных = ДанныеБазыКорреспондента.СвойстваОбъектаМетаданных;
				ТаблицаБазыКорреспондента = ОбщегоНазначения.ЗначениеИзСтрокиXML(ДанныеБазыКорреспондента.ТаблицаБазыКорреспондента);
				
			Иначе
				
				ДанныеБазыКорреспондента = ЗначениеИзСтрокиВнутр(WSПрокси.GetIBData(Параметры.ПолноеИмяТаблицыБазыКорреспондента));
				
				СвойстваОбъектаМетаданных = ЗначениеИзСтрокиВнутр(ДанныеБазыКорреспондента.СвойстваОбъектаМетаданных);
				ТаблицаБазыКорреспондента = ЗначениеИзСтрокиВнутр(ДанныеБазыКорреспондента.ТаблицаБазыКорреспондента);
				
			КонецЕсли;
			
			Если ЗначениеЗаполнено(Параметры.МассивВыбранныхЗначений) Тогда
				МассивПереданныхЗначений = Параметры.МассивВыбранныхЗначений;
			Иначе
				МассивПереданныхЗначений = Новый Массив();
			КонецЕсли;
			
			ПереинициализироватьИдентификаторСсылки(ТаблицаБазыКорреспондента);
			
			ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение( СписокВыбираемыхЗначений, 
			МассивПереданныхЗначений, 
			ТаблицаБазыКорреспондента);
			
			Если ЗначениеЗаполнено(Параметры.КоллекцияФильтров) Тогда
				
				ПроверитьПрохождениеФильтраВнешнееСоединение(Параметры.КоллекцияФильтров);
				
			КонецЕсли;
			
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьЗакрыть(Команда)
	
	ПараметрыЗакрытияФормы = Новый Структура();
	ПараметрыЗакрытияФормы.Вставить("АдресТаблицыВоВременномХранилище", СформироватьТаблицуВыбранныхЗначений());
	ПараметрыЗакрытияФормы.Вставить("ИмяТаблицыДляЗаполнения",          СтруктураЗаполняемыхЗначений.ИмяТаблицыДляЗаполнения);
	ПараметрыЗакрытияФормы.Вставить("ИмяКолонкиДляЗаполнения",          СтруктураЗаполняемыхЗначений.ИмяКолонкиДляЗаполнения);
	
	ОповеститьОВыборе(ПараметрыЗакрытияФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьОтметку(Команда)
	
	ЗаполнитьОтметки(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьВсе(Команда)
	
	ЗаполнитьОтметки(Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Процедура ЗаполнитьСписокДоступныхЗначений( МассивПереданныхЗначений, 
											ВидСправочника,
											ДополнительныеУсловия = Неопределено,
											ДополнительныеРеквизиты = Неопределено)
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СправочникДляВыбораОтборов.Ссылка КАК Представление,
	|	ВЫБОР
	|		КОГДА СправочникДляВыбораОтборов.Ссылка В (&МассивПереданныхЗначений)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК Пометка
	|	,%ДополнительныеПоляЗапроса%
	|ИЗ
	|	%ВидСправочника% КАК СправочникДляВыбораОтборов
	|ГДЕ
	|	СправочникДляВыбораОтборов.ПометкаУдаления = ЛОЖЬ";
	
	
	ТекстДополнительныеПоляЗапроса = "";
	Если Не ДополнительныеРеквизиты = Неопределено Тогда
		Для Каждого ДополнительныйРеквизит Из ДополнительныеРеквизиты Цикл
			ТекстДополнительныеПоляЗапроса = ТекстДополнительныеПоляЗапроса
				+ ",СправочникДляВыбораОтборов." + ДополнительныйРеквизит.ПутьКДанным
				+ " КАК _" + ДополнительныйРеквизит.ИмяРеквизита;
		КонецЦикла;
	КонецЕсли;	
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, ",%ДополнительныеПоляЗапроса%", ТекстДополнительныеПоляЗапроса);
	Запрос = Новый Запрос(ТекстЗапроса);
	
	Если ЗначениеЗаполнено(ДополнительныеУсловия) Тогда
		
		Для Каждого Фильтр Из ДополнительныеУсловия Цикл
			
			Запрос.Текст = ДобавитьТекстУсловия(Запрос.Текст, " СправочникДляВыбораОтборов.", "И", Фильтр);
			Запрос.УстановитьПараметр(Фильтр.ИмяПараметра, Фильтр.ЗначениеПараметра);
			
		КонецЦикла; 
		
	КонецЕсли;
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%ВидСправочника%", ВидСправочника);
	Запрос.УстановитьПараметр("МассивПереданныхЗначений", МассивПереданныхЗначений);
	
	СписокВыбираемыхЗначений.Загрузить(Запрос.Выполнить().Выгрузить());
	
	Для Каждого ЭлементСписка Из СписокВыбираемыхЗначений Цикл
		
		Если ТипЗнч(ЭлементСписка.Представление) <> Тип("Строка") Тогда
			ЭлементСписка.Идентификатор = Строка(ЭлементСписка.Представление.УникальныйИдентификатор());
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение( ТаблицаЗначенийБазыКорреспондента, 
															 МассивПереданныхЗначений, 
															 ДеревоЗначений)
	
	Для Каждого Строка Из ДеревоЗначений.Строки Цикл
		
		Если Строка.Строки.Количество() > 0 Тогда
			
			ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение( ТаблицаЗначенийБазыКорреспондента, 
															   МассивПереданныхЗначений, 
															   Строка);
			
		Иначе
			
			НоваяСтрока = ТаблицаЗначенийБазыКорреспондента.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
			
			Если МассивПереданныхЗначений.Найти(НоваяСтрока.Идентификатор) <> Неопределено Тогда
				НоваяСтрока.Пометка = Истина;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция СформироватьТаблицуВыбранныхЗначений()
	
	ТаблицаВыбранныхЗначений = 
		СписокВыбираемыхЗначений.Выгрузить(Новый Структура("Пометка", Истина), "Представление, Идентификатор");
	
	Возврат ПоместитьВоВременноеХранилище( ТаблицаВыбранныхЗначений, УникальныйИдентификатор);
		
КонецФункции

&НаСервере
Процедура ЗаполнитьОтметки(ЗначениеОтметки)
	
	ТаблицаЗаполняемыхЗначений = СписокВыбираемыхЗначений.Выгрузить();
	ТаблицаЗаполняемыхЗначений.ЗаполнитьЗначения(ЗначениеОтметки, "Пометка");
	СписокВыбираемыхЗначений.Загрузить(ТаблицаЗаполняемыхЗначений);
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьПрохождениеФильтраВнешнееСоединение(КоллекцияФильтров)
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ТаблицаЗначений.Представление,
	                      |	ТаблицаЗначений.Пометка,
	                      |	ТаблицаЗначений.Ключ,
	                      |	ТаблицаЗначений.Идентификатор
	                      |ПОМЕСТИТЬ СписокОтфильтрованныхЭлементов
	                      |ИЗ
	                      |	&СписокОтобранныхЗначений КАК ТаблицаЗначений
	                      |ГДЕ");
	
	Запрос.УстановитьПараметр("СписокОтобранныхЗначений", СписокВыбираемыхЗначений.Выгрузить());
	
	Для Каждого Фильтр Из КоллекцияФильтров Цикл
		
		Если Прав(Запрос.Текст, 3) = "ГДЕ" Тогда
			
			СоединительУсловий = "";
			
		Иначе
			
			СоединительУсловий = "И";
			
		КонецЕсли;
		
		Запрос.Текст = ДобавитьТекстУсловия(Запрос.Текст, " ТаблицаЗначений.", СоединительУсловий, Фильтр);
		Запрос.УстановитьПараметр(Фильтр.ИмяПараметра, Фильтр.ЗначениеПараметра);
		
	КонецЦикла; 
	
	Запрос.Текст = Запрос.Текст + "
	                      |;
	                      |ВЫБРАТЬ
	                      |	СписокОтфильтрованныхЭлементов.Представление,
	                      |	СписокОтфильтрованныхЭлементов.Пометка,
	                      |	СписокОтфильтрованныхЭлементов.Ключ,
	                      |	СписокОтфильтрованныхЭлементов.Идентификатор
	                      |ИЗ
	                      |	СписокОтфильтрованныхЭлементов КАК СписокОтфильтрованныхЭлементов";
	
	СписокВыбираемыхЗначений.Загрузить(Запрос.Выполнить().Выгрузить());
	
КонецПроцедуры

&НаСервере
Функция ДобавитьТекстУсловия(ТекстЗапроса, ИмяТаблицы, СоединительУсловий, Фильтр)
	
	ТекстЗапроса = ТекстЗапроса + Символы.ПС + " " + СоединительУсловий 
		+ ИмяТаблицы
		+ Фильтр.РеквизитОтбора
		+ " " + Фильтр.Условие
		+ ?(Фильтр.Условие = "В", " (","")
		+ " &"
		+ Фильтр.ИмяПараметра
		+ ?(Фильтр.Условие = "В", ") ","");

	Возврат ТекстЗапроса;
	
КонецФункции

&НаСервере
Процедура ПереинициализироватьИдентификаторСсылки(ТаблицаБазыКорреспондента)
	
	Для Каждого Строка Из ТаблицаБазыКорреспондента.Строки Цикл
		
		Если Строка.Строки.Количество() > 0 Тогда
			
			ПереинициализироватьИдентификаторСсылки(Строка);
			
		Иначе
			
			Строка.Идентификатор = ИдентификаторСсылки(Строка.Идентификатор);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ИдентификаторСсылки(Знач СтрокаВнутр)
	
	СтрокаУИД = Сред(СтрокаВнутр, 1 + СтрНайти(СтрокаВнутр, ":"), 32);
	
	Идентификатор =
		Сред(СтрокаУИД, 25, 8) 
		+ "-" + Сред(СтрокаУИД, 21, 4) 
		+ "-" + Сред(СтрокаУИД, 17, 4) 
		+ "-" + Сред(СтрокаУИД, 1, 4)
		+ "-" + Сред(СтрокаУИД, 5, 12);
	
	Возврат Идентификатор;
	
КонецФункции

#КонецОбласти

#КонецОбласти
