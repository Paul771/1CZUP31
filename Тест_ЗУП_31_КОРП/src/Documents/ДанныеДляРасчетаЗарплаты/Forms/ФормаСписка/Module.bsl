
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		
		Возврат;
		
	КонецЕсли;
	
	Если Параметры.РежимВыбора Тогда
		Элементы.Список.РежимВыбора = Истина;
	КонецЕсли;
	
	ДобавитьКомандыСозданияДокументов();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.КоманднаяПанель = Элементы.КоманднаяПанельФормы;
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененВидДокументовВводДанныхДляРасчетаЗарплаты" Тогда
		Если Не Параметр.Свойство("Ссылка") Тогда
			Возврат;
		КонецЕсли;
		ИдентификаторКоманды = СоответствиеКомандШаблонам.Получить(Параметр.Ссылка);
		Если ИдентификаторКоманды <> Неопределено Тогда
			ЭлементСписка = СписокВидовДокументов.НайтиПоЗначению(ИдентификаторКоманды);
			Если ЭлементСписка.Представление = Параметр.Представление Тогда
				// Такая команда в форме есть, и ее представление не изменилось.
				Возврат;
			КонецЕсли;
		КонецЕсли;
		// Переходим на сервер для добавления новой команды (или изменения заголовка существующей).
		ДобавитьКомандуСозданияДокумента(Параметр.Ссылка, Параметр.Представление, Параметр.Родитель);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	Если Копирование Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	
	Если СоответствиеШаблоновКомандам.Количество() = 0 Тогда
		// Нет ни одного шаблона - предложим создать.
		ТекстВопроса = НСтр("ru = 'Документы ввода данных для расчета вводятся по заранее настроенным шаблонам (видам документов). Виды документов в системе не обнаружены.
	                         |Создать новый вид документов?'");
		Оповещение = Новый ОписаниеОповещения("СписокПередНачаломДобавленияСоздатьЭлемент", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавленияСоздатьЭлемент(Ответ, ДополнительныеПараметры) Экспорт 

	Если Ответ = КодВозвратаДиалога.Да Тогда
		ОткрытьФорму("Справочник.ВидыДокументовВводДанныхДляРасчетаЗарплаты.ФормаОбъекта", , ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, Настройки);
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		
		Возврат;
		
	КонецЕсли;
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, , СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Элементы.Список, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура СоздатьНаОснованииШаблона(Команда)
	
	СоздатьДокументПоИдентификатору(Команда.Имя);	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ДобавитьКомандуСозданияДокумента(ШаблонСсылка, ШаблонНаименование, ШаблонГруппа)
	
	КомандыШаблонам = ОбщегоНазначенияКлиентСервер.СкопироватьСоответствие(СоответствиеКомандШаблонам);
	ШаблоныКомандам = ОбщегоНазначенияКлиентСервер.СкопироватьСоответствие(СоответствиеШаблоновКомандам);
	
	ИдентификаторКоманды = КомандыШаблонам[ШаблонСсылка];
	Если ИдентификаторКоманды <> Неопределено Тогда
		// Такая команда существует нужно подменить заголовок...
		Команды[ИдентификаторКоманды].Заголовок = ШаблонНаименование;
		// ..И представление для списка выбора.
		ЭлементСписка = СписокВидовДокументов.НайтиПоЗначению(Команды[ИдентификаторКоманды].Имя);
		Если ЭлементСписка <> Неопределено Тогда
			ЭлементСписка.Представление = ШаблонНаименование;
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	// Такой команды не было - добавляем ее.
	НоваяКоманда = НоваяКомандаСозданияДокумента(ШаблонНаименование, ШаблонГруппа);
	ШаблоныКомандам.Вставить(НоваяКоманда.Имя, ШаблонСсылка);
	КомандыШаблонам.Вставить(ШаблонСсылка, НоваяКоманда.Имя);
	// Список составляем для интерактивного выбора.
	СписокВидовДокументов.Добавить(НоваяКоманда.Имя, ШаблонНаименование);
	
	СоответствиеШаблоновКомандам = Новый ФиксированноеСоответствие(ШаблоныКомандам);
	СоответствиеКомандШаблонам = Новый ФиксированноеСоответствие(КомандыШаблонам);
	
КонецПроцедуры	

&НаСервере
Процедура ДобавитьКомандыСозданияДокументов()
	
	КомандыШаблонам = Новый Соответствие;
	ШаблоныКомандам = Новый Соответствие;
	
	ТаблицаВидовДокументов = Справочники.ВидыДокументовВводДанныхДляРасчетаЗарплаты.ТаблицаВидовДокументов();
	Для Каждого СтрокаТаблицы Из ТаблицаВидовДокументов Цикл
		НоваяКоманда = НоваяКомандаСозданияДокумента(СтрокаТаблицы.Представление, СтрокаТаблицы.Родитель);
		ШаблоныКомандам.Вставить(НоваяКоманда.Имя, СтрокаТаблицы.ВидДокумента);
		КомандыШаблонам.Вставить(СтрокаТаблицы.ВидДокумента, НоваяКоманда.Имя);
		// Список составляем для интерактивного выбора.
		СписокВидовДокументов.Добавить(НоваяКоманда.Имя, СтрокаТаблицы.Представление);
	КонецЦикла;	
	
	СоответствиеШаблоновКомандам = Новый ФиксированноеСоответствие(ШаблоныКомандам);
	СоответствиеКомандШаблонам = Новый ФиксированноеСоответствие(КомандыШаблонам);
	
КонецПроцедуры	

&НаСервере
Функция НоваяКомандаСозданияДокумента(Заголовок, Подменю)
	
	ИдентификаторКоманды = ЗарплатаКадрыРасширенныйКлиентСервер.УникальноеИмяРеквизита();
	
	// Добавляем команду
	НоваяКоманда = Команды.Добавить("СоздатьДокумент" + ИдентификаторКоманды);
	НоваяКоманда.Заголовок	= Заголовок;
	НоваяКоманда.Действие	= "СоздатьНаОснованииШаблона";
	
	// Определяем в какое подменю, добавить кнопку
	ГруппаКнопок = ПодменюСозданияДокументов(Подменю);
	
	// Добавляем кнопку
	Кнопка = Элементы.Добавить("СоздатьДокумент" + ИдентификаторКоманды, Тип("КнопкаФормы"), ГруппаКнопок); 
	Кнопка.ИмяКоманды	= НоваяКоманда.Имя;
	Кнопка.Заголовок	= Заголовок;
	
	Возврат НоваяКоманда;
	
КонецФункции

&НаСервере
Функция ПодменюСозданияДокументов(ПодменюСсылка)
	
	Если Не ЗначениеЗаполнено(ПодменюСсылка) Тогда
		Возврат Элементы.Найти("ПодменюСоздать");
	КонецЕсли;
	
	Если ГруппыКоманд <> Неопределено Тогда
		ПодменюИмя = ГруппыКоманд.Получить(ПодменюСсылка);
		Если ПодменюИмя <> Неопределено Тогда
			Возврат Элементы.Найти(ПодменюИмя);
		КонецЕсли;
	КонецЕсли;
	
	ИдентификаторЭлемента = ЗарплатаКадрыРасширенныйКлиентСервер.УникальноеИмяРеквизита();
	
	// Получаем родителя от родителя
	ПодменюРодитель = ПодменюСозданияДокументов(ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПодменюСсылка, "Родитель"));
	
	// Место вставки перед первой же командой (не подменю)
	МестоВставки = Неопределено;
	Для Каждого Элемент Из ПодменюРодитель.ПодчиненныеЭлементы Цикл
		Если ТипЗнч(Элемент) = Тип("КнопкаФормы") Тогда
			Прервать;
		КонецЕсли;
		Если Элемент.Заголовок < Строка(ПодменюСсылка) Тогда
			Прервать;
		КонецЕсли;
		МестоВставки = Элемент;
	КонецЦикла;
	
	Если МестоВставки = Неопределено Тогда
		Подменю = Элементы.Добавить("Подменю" + ИдентификаторЭлемента, Тип("ГруппаФормы"), ПодменюРодитель); 
	Иначе
		Подменю = Элементы.Вставить("Подменю" + ИдентификаторЭлемента, Тип("ГруппаФормы"), ПодменюРодитель, МестоВставки); 
	КонецЕсли;
	Подменю.Вид = ВидГруппыФормы.Подменю;
	Подменю.Заголовок = Строка(ПодменюСсылка);
	
	Соответствие = Новый Соответствие;
	Если ГруппыКоманд <> Неопределено Тогда
		Соответствие = Новый Соответствие(ГруппыКоманд);
	КонецЕсли;
	Соответствие.Вставить(ПодменюСсылка, Подменю.Имя);
	ГруппыКоманд = Новый ФиксированноеСоответствие(Соответствие);
	
	Возврат Подменю;
	
КонецФункции

&НаКлиенте
Процедура СоздатьДокументПоИдентификатору(Идентификатор)
	
	ПараметрыОткрываемойФормы = Новый Структура;
	ПараметрыОткрываемойФормы.Вставить("ВидДокумента", СоответствиеШаблоновКомандам.Получить(Идентификатор));
	
	ОткрытьФорму("Документ.ДанныеДляРасчетаЗарплаты.ФормаОбъекта", ПараметрыОткрываемойФормы, , Истина);
	
КонецПроцедуры

#КонецОбласти
