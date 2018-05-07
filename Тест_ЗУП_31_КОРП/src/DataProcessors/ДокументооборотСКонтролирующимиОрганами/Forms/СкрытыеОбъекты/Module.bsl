&НаКлиенте
Перем КонтекстЭДОКлиент;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Инициализируем цвета
	Желтый		= Новый Цвет(251, 225, 81);  // Желтый.
	Серый	= Новый Цвет(242, 242, 242); // Серый.
	Черный		= Новый Цвет(0, 0, 0);       // Черный.

	УстановитьОрганизацию();
	
	ТекстОшибкиИнициализацииКонтекстаЭДО = НСтр("ru = 'Подождите, пожалуйста. Выполняется обновление модуля 1С-Отчетности...'");
	
	ОформитьКнопку(ЭтотОбъект, Элементы.ГиперссылкаОтчеты, Элементы.ГиперссылкаОтчеты);
	
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриОткрытииЗавершение", ЭтотОбъект);
	ДокументооборотСКОКлиент.ПолучитьКонтекстЭДО(ОписаниеОповещения);
	// В процедуре ниже ничего не писать - это асинхронный метод!

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Скрытие/восстановление объекта" Тогда
		
		ОрганизацияВКлюче 	= Параметр.Организация;
		СсылкаВКлюче 		= Параметр.Ссылка;
			
		// Обновляем текущую таблицу
		Если Элементы.Разделы.ТекущаяСтраница = Элементы.СтраницаОтчеты Тогда
			
			Отборы = Новый Массив;
			Отборы.Добавить(Новый Структура("Организация, Ссылка", ОрганизацияВКлюче, СсылкаВКлюче));
			
			КлючЗаписи = Новый(Тип("РегистрСведенийКлючЗаписи.ЖурналОтчетовСтатусы"), Отборы);
			
			Если НЕ КлючЗаписи.Пустой() Тогда
				
				ОповеститьОбИзменении(КлючЗаписи);
				Элементы.Отчеты.ТекущаяСтрока = КлючЗаписи;
				
			КонецЕсли;
			
		Иначе
			
			// Определем текущую страницу
			СтраницаЖурнала = ТекущаяСтраница(ЭтотОбъект);
			
			Отборы = Новый Массив;
			Отборы.Добавить(Новый Структура("СтраницаЖурнала, Организация, Ссылка", СтраницаЖурнала, ОрганизацияВКлюче, СсылкаВКлюче));
			
			КлючЗаписи = Новый(Тип("РегистрСведенийКлючЗаписи.ЖурналОтправокВКонтролирующиеОрганы"), Отборы);
			
			Если НЕ КлючЗаписи.Пустой() Тогда
				
				ТекущаяТаблица = ТекущаяТаблица(ЭтотОбъект);

				Если ТекущаяТаблица = Неопределено Тогда
					Возврат;
				КонецЕсли;
				
				ОповеститьОбИзменении(КлючЗаписи);
				
				ТекущаяТаблица.ТекущаяСтрока = КлючЗаписи;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПриПереключенииРаздела(Элемент)
	
	ВыделитьТекущийРаздел(ЭтаФорма, Элемент);
	ВывестиТаблицуРаздела(ЭтаФорма, Элемент.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	УстановитьОтборПоОрганизации(ЭтотОбъект);
	ДополнитьОтборПоТипуВходящих(Входящие, 
		Элементы.ГруппаКатегориииВх.ТекущаяСтраница, 
		Элементы.СтраницаКатегорияРассылки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура Выбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ПоказатьЗначение(, Элемент.ТекущиеДанные.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Восстановить(Команда)
	
	СтандартнаяОбработка = Ложь;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПослеПодтвержденияВосстановления", 
		ЭтотОбъект);
	
	ПодтвердитьВосстановление(ОписаниеОповещения);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПодтвердитьВосстановление(ВыполняемоеОповещение)
	
	ТекущаяСтраница = ТекущаяСтраница(ЭтотОбъект);
	
	ТекущаяТаблица 			= ТекущаяТаблица(ЭтотОбъект);
	ВыделеноНесколькоСтрок 	= ТекущаяТаблица.ВыделенныеСтроки.Количество() > 1;
	
	Если ТекущаяСтраница = ПредопределенноеЗначение("Перечисление.СтраницыЖурналаОтчетность.Отчеты") Тогда
		
		Если ВыделеноНесколькоСтрок Тогда 
			ВидОбъекта = НСтр("ru = 'отчеты'");
		Иначе
			ВидОбъекта = НСтр("ru = 'отчет'");
		КонецЕсли;
		
	ИначеЕсли ТекущаяСтраница = ПредопределенноеЗначение("Перечисление.СтраницыЖурналаОтчетность.Уведомления") Тогда
		
		Если ВыделеноНесколькоСтрок Тогда 
			ВидОбъекта = НСтр("ru = 'уведомления'");
		Иначе
			ВидОбъекта = НСтр("ru = 'уведомление'");
		КонецЕсли;

	ИначеЕсли ТекущаяСтраница = ПредопределенноеЗначение("Перечисление.СтраницыЖурналаОтчетность.Сверки") Тогда
		
		Если ВыделеноНесколькоСтрок Тогда 
			ВидОбъекта = НСтр("ru = 'запросы на сверку'");
		Иначе
			ВидОбъекта = НСтр("ru = 'запрос на сверку'");
		КонецЕсли;

	ИначеЕсли ТекущаяСтраница = ПредопределенноеЗначение("Перечисление.СтраницыЖурналаОтчетность.ЕГРЮЛ") Тогда
		
		Если ВыделеноНесколькоСтрок Тогда 
			ВидОбъекта = НСтр("ru = 'выписки из ЕГРЮЛ'");
		Иначе
			ВидОбъекта = НСтр("ru = 'выписку из ЕГРЮЛ'");
		КонецЕсли;
		
	ИначеЕсли ТекущаяСтраница = ПредопределенноеЗначение("Перечисление.СтраницыЖурналаОтчетность.Входящие")
		ИЛИ ТекущаяСтраница = ПредопределенноеЗначение("Перечисление.СтраницыЖурналаОтчетность.Письма") Тогда
		
		Если ВыделеноНесколькоСтрок Тогда 
			ВидОбъекта = НСтр("ru = 'письма'");
		Иначе
			ВидОбъекта = НСтр("ru = 'письмо'");
		КонецЕсли;
		
	КонецЕсли;
	
	ТекстСообщения = НСтр("ru = 'Вы уверены, что хотите восстановить %1?'");
	ТекстСообщения = СтрШаблон(ТекстСообщения, ВидОбъекта);
	
	ПоказатьВопрос(ВыполняемоеОповещение,ТекстСообщения, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПодтвержденияВосстановления(Ответ, ДополнительныеПараметры) Экспорт
	
	Если Ответ = КодВозвратаДиалога.Да Тогда
		
		ВосстановленныеОбъекты = ВосстановитьОбъект1СОтчетности();
		
		Для каждого ВосстановленныйОбъект Из ВосстановленныеОбъекты Цикл
			
			Оповестить("Скрытие/восстановление объекта", 
				ВосстановленныйОбъект, 
				ВосстановленныйОбъект.Ссылка);

		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ВосстановитьОбъект1СОтчетности()

	ВосстановленныеОбъекты = Новый Массив;
	
	ТекущаяТаблица = ТекущаяТаблица(ЭтотОбъект);
	Для каждого Строка Из ТекущаяТаблица.ВыделенныеСтроки Цикл
		
		ВосстановленныйОбъект = Новый Структура;
		ВосстановленныйОбъект.Вставить("Ссылка", 		Строка.Ссылка);
		ВосстановленныйОбъект.Вставить("Организация", 	Строка.Организация);
		
		ЭлектронныйДокументооборотСКонтролирующимиОрганамиВызовСервера.СкрытьВосстановитьОбъект1СОтчетности(
			ВосстановленныйОбъект.Ссылка, 
			Ложь);
			
		ВосстановленныеОбъекты.Добавить(ВосстановленныйОбъект);
				
	КонецЦикла;

	Возврат ВосстановленныеОбъекты;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ВыделитьТекущийРаздел(Форма, ТекущийРаздел)
	
	МассивРазделов = Новый Массив;
	МассивРазделов.Добавить(Форма.Элементы.ГиперссылкаОтчеты);
	МассивРазделов.Добавить(Форма.Элементы.ГиперссылкаУведомления);
	МассивРазделов.Добавить(Форма.Элементы.ГиперссылкаПисьма);
	МассивРазделов.Добавить(Форма.Элементы.ГиперссылкаСверки);
	МассивРазделов.Добавить(Форма.Элементы.ГиперссылкаЕГРЮЛ);
	МассивРазделов.Добавить(Форма.Элементы.ГиперссылкаВходящие);
	
	// Делаем текущий раздел желтым
	Для каждого Раздел Из МассивРазделов Цикл
		
		Если Раздел.ЦветФона = Форма.Желтый Тогда
			ОформитьКнопку(Форма, Раздел, ТекущийРаздел);
		ИначеЕсли Раздел = ТекущийРаздел Тогда
			ОформитьКнопку(Форма, Раздел, ТекущийРаздел);
		КонецЕсли;
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОформитьКнопку(Форма, Гиперссылка, ТекущаяГиперссылка)
	
	АктивнаКнопка = (Гиперссылка = ТекущаяГиперссылка);
	
	Гиперссылка.ЦветФона	= ?(АктивнаКнопка, Форма.Желтый, Форма.Серый);
	Гиперссылка.Гиперссылка	= ?(АктивнаКнопка, Ложь, Истина);
	Гиперссылка.ЦветТекста	= Форма.Черный;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	КонтекстЭДОКлиент 						= Результат.КонтекстЭДО;
	ТекстОшибкиИнициализацииКонтекстаЭДО 	= Результат.ТекстОшибки;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДобавитьОтборПоРассылке(Куда, Знач ТолькоРассылка)
	
	Для Каждого ЭлОтбора Из Куда.Элементы Цикл
		Если ЭлОтбора.ИдентификаторПользовательскойНастройки = "ЭтоРассылкаГруппа" Тогда 
			ДобавитьОтборПоРассылке(ЭлОтбора, ТолькоРассылка);
			Возврат;
		ИначеЕсли ЭлОтбора.ИдентификаторПользовательскойНастройки = "ЭтоРассылкаЭлемент" Тогда 
			ЭлОтбора.ПравоеЗначение = ТолькоРассылка;
			Возврат;
		КонецЕсли;
	КонецЦикла;
	
	ГруппаОтбора = Куда.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
	ГруппаОтбора.ИдентификаторПользовательскойНастройки = "ЭтоРассылкаГруппа";
	ГруппаОтбора.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ;
	
	ЭлементОтбора = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ИдентификаторПользовательскойНастройки = "ЭтоРассылкаЭлемент";
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ЭтоРассылка");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = ТолькоРассылка;
	
КонецПроцедуры

&НаКлиенте
Процедура ГруппаКатегориииВхПриСменеСтраницы(Элемент, ТекущаяСтраница)	
	
	ДополнитьОтборПоТипуВходящих(Входящие, 
		ТекущаяСтраница, 
		Элементы.СтраницаКатегорияРассылки);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДополнитьОтборПоТипуВходящих(ТабВходящие, ТекущаяСтраница, СтраницаРассылки)
	
	АктивнаСтраницаРассылки = ТекущаяСтраница = СтраницаРассылки;	
	ДобавитьОтборПоРассылке(ТабВходящие.Отбор, АктивнаСтраницаРассылки);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ВывестиТаблицуРаздела(Форма, РазделОтчетности)
	
	ИмяЭлемента = СтрЗаменить(РазделОтчетности, "Гиперссылка", "");
	Форма.Элементы.Разделы.ТекущаяСтраница = Форма.Элементы["Страница" + ИмяЭлемента];
	ЭлементТаблица = Форма.Элементы.Найти(ИмяЭлемента);
	
	Если ЭлементТаблица <> Неопределено Тогда 
		Форма.ТекущийЭлемент = ЭлементТаблица;
	КонецЕсли;
	
	Если ИмяЭлемента = "Входящие" Тогда 
		ДополнитьОтборПоТипуВходящих(Форма.Входящие, 
			Форма.Элементы.ГруппаКатегориииВх.ТекущаяСтраница,
			Форма.Элементы.СтраницаКатегорияРассылки);
	КонецЕсли;
				
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборПоОрганизации(Форма)
	
	ДинамическиеСписки = Новый Массив;
	ДинамическиеСписки.Добавить(Форма.Отчеты);
	ДинамическиеСписки.Добавить(Форма.Уведомления);
	ДинамическиеСписки.Добавить(Форма.Письма);
	ДинамическиеСписки.Добавить(Форма.Сверки);
	ДинамическиеСписки.Добавить(Форма.ЕГРЮЛ);
	ДинамическиеСписки.Добавить(Форма.Входящие);
	
	Для каждого ДинамическийСписок Из ДинамическиеСписки Цикл
	
		ДинамическийСписок.Отбор.Элементы.Очистить();
		ГруппаОтбора = ДинамическийСписок.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
		ГруппаОтбора.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИ;

		// отбор по организации
		Если ЗначениеЗаполнено(Форма.Организация) Тогда
			ЭлементОтбора = ГруппаОтбора.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
			ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Организация");
			ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
			ЭлементОтбора.Использование = Истина;
			ЭлементОтбора.ПравоеЗначение = Форма.Организация;
		КонецЕсли;
	
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОрганизацию()
	
	// Определяем организацию по-умолчанию в случае использования одной организации
	Организация = Неопределено;
	Если РегламентированнаяОтчетностьВызовСервера.ИспользуетсяОднаОрганизация() Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("Справочники.Организации");
		Организация = Модуль.ОрганизацияПоУмолчанию();
	КонецЕсли;
	
	// Если организаций больше одной, то используем основную организацию
	Если НЕ ЗначениеЗаполнено(Организация) Тогда
		Организация = РегламентированнаяОтчетность.ПолучитьОрганизациюПоУмолчанию();
	КонецЕсли;
	
	УстановитьОтборПоОрганизации(ЭтотОбъект);
	ДополнитьОтборПоТипуВходящих(Входящие, 
		Элементы.ГруппаКатегориииВх.ТекущаяСтраница, 
		Элементы.СтраницаКатегорияРассылки);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ТекущийРазделФормы(Форма)
	
	Результат = Неопределено;
	
	Для каждого Раздел Из Разделы(Форма) Цикл
		
		Гиперссылка = Форма.Элементы["Гиперссылка" + Раздел];
		
		Если Гиперссылка.ЦветФона = Форма.Желтый Тогда
			Результат = Гиперссылка;
		КонецЕсли;
	
	КонецЦикла; 
	
	Возврат Результат;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ТекущаяТаблица(Форма)
	
	ТекущийРаздел 		= ТекущийРазделФормы(Форма);
	ИмяТекущейТаблицы 	= СтрЗаменить(ТекущийРаздел.Имя, "Гиперссылка", ""); 
	
	Если ИмяТекущейТаблицы = "Входящие" Тогда //Есть вложенные таблицы/вкладки
		АктивнаСтраницаРассылки = 
			Форма.Элементы.ГруппаКатегориииВх.ТекущаяСтраница = Форма.Элементы.СтраницаКатегорияРассылки;	
			
		Если АктивнаСтраницаРассылки Тогда 
			ИмяТекущейТаблицы = ИмяТекущейТаблицы + "Рассылки";
		КонецЕсли;
	КонецЕсли;
	
	Возврат Форма.Элементы[ИмяТекущейТаблицы];
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ТекущаяСтраница(Форма)
	
	ТекущийРаздел 		= ТекущийРазделФормы(Форма);
	ИмяТекущейТаблицы 	= СтрЗаменить(ТекущийРаздел.Имя, "Гиперссылка", ""); 
	
	Возврат ПредопределенноеЗначение("Перечисление.СтраницыЖурналаОтчетность." + ИмяТекущейТаблицы);
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Разделы(Форма)
	
	ОписаниеРазделов = Новый Массив;
	
	ОписаниеРазделов.Добавить("Отчеты");
	ОписаниеРазделов.Добавить("Уведомления");
	ОписаниеРазделов.Добавить("Письма");
	ОписаниеРазделов.Добавить("Сверки");
	ОписаниеРазделов.Добавить("ЕГРЮЛ");
	ОписаниеРазделов.Добавить("Входящие");
	
	Возврат ОписаниеРазделов;
	
КонецФункции

&НаКлиенте
Процедура ОрганизацияОчистка(Элемент, СтандартнаяОбработка)
	
	УстановитьОтборПоОрганизации(ЭтотОбъект);
	ДополнитьОтборПоТипуВходящих(Входящие, 
		Элементы.ГруппаКатегориииВх.ТекущаяСтраница, 
		Элементы.СтраницаКатегорияРассылки);
	
КонецПроцедуры

#КонецОбласти
