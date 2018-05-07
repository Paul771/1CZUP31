
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Объект.Ссылка.Пустая() Тогда
		
		ЗначенияДляЗаполнения = Новый Структура(
			"Организация, Ответственный", "Объект.Организация", "Объект.Ответственный");
		
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
		
		Если Не ЗначениеЗаполнено(Объект.СовмещающийСотрудник) Тогда
			
			Если Параметры.Свойство("ЗначенияЗаполнения") Тогда
				Параметры.ЗначенияЗаполнения.Свойство("Сотрудник", Объект.СовмещающийСотрудник);
			КонецЕсли;
			
		КонецЕсли;
		
		УстановитьПривилегированныйРежим(Истина);
		
		РасчетЗарплатыРасширенныйФормы.ЗаполнитьНачислениеВФормеДокументаПоКатегории(
			ЭтаФорма, Объект.Начисление, Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДоплатаЗаСовмещение);
		
		УстановитьПривилегированныйРежим(Ложь);
		ЗаполнитьДанныеФормыПоОрганизации();
		
		ПриПолученииДанныхНаСервере();
		
	КонецЕсли;
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужбаФормы");
		Модуль.УстановитьПараметрыВыбораСотрудников(ЭтаФорма, "СовмещающийСотрудник");
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ПриПолученииДанныхНаСервере();
	
	ОбменДаннымиЗарплатаКадры.ПриЧтенииНаСервереДокумента(ЭтотОбъект, ТекущийОбъект);
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_ОтменаСовмещения", ПараметрыЗаписи, Объект.Ссылка);
	ИсправлениеДокументовЗарплатаКадрыКлиент.ОповеститьОбИсправленииДокумента(Объект.Ссылка, Объект.ИсправленныйДокумент, ПараметрыЗаписи.РежимЗаписи, "ПериодическиеСведения");
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ДанныеВРеквизиты();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ИмяСобытия = "ИзмененыНачисления" И Источник = ЭтаФорма Тогда
		ЗаполнитьНачисленияИзВРеменногоХранилища(Параметр.АдресВХранилище);
	КонецЕсли;
	ИсправлениеДокументовЗарплатаКадрыКлиент.ОбработкаОповещенияИсправленногоДокумента(ЭтотОбъект, Объект.Ссылка, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура СовмещающийСотрудникПриИзменении(Элемент)
	
	СовмещающийСотрудникПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаОтменыПриИзменении(Элемент)
	
	ДатаНачалаПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументОснованиеПриИзменении(Элемент)
	ДокументОснованиеПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияИзменитьФОТНажатие(Элемент)
	
	Если ЗначениеЗаполнено(Объект.СовмещающийСотрудник) Тогда
		
		ПараметрыОткрытия = Новый Структура;
		ПараметрыОткрытия.Вставить("АдресВХранилище", АдресВХранилищеНачисленийИУдержаний(Объект.СовмещающийСотрудник));
		ПараметрыОткрытия.Вставить("ТолькоПросмотр", ТолькоПросмотр);
		
		ЗарплатаКадрыРасширенныйКлиент.ОткрытьФормуРедактированияСоставаНачисленийИУдержаний(ПараметрыОткрытия, ЭтаФорма);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОтменаДоплатыУтвержденаПриИзменении(Элемент)
	ОтменаДоплатыУтвержденаПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОтменаДоплатыУтвержденаПриИзмененииНаСервере()
	ЗарплатаКадрыРасширенный.УстановитьПредупреждающуюНадписьВМногофункциональныхДокументах(ЭтаФорма, "ОтменаДоплатыУтверждена");
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОткрытьДокументыВведенныеПозже(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЗарплатаКадрыРасширенныйКлиент.ОткрытьВведенныеНаДатуДокументы(ЭтотОбъект.ДокументыВведенныеПозже);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОткрытьРанееВведенныеДокументы(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЗарплатаКадрыРасширенныйКлиент.ОткрытьВведенныеНаДатуДокументы(ЭтотОбъект.РанееВведенныеДокументы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

// ИсправлениеДокументов
&НаКлиенте
Процедура Подключаемый_Исправить(Команда)
	ИсправлениеДокументовЗарплатаКадрыКлиент.Исправить(Объект.Ссылка, "ОтменаСовмещения");
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПерейтиКИсправлению(Команда)
	ИсправлениеДокументовЗарплатаКадрыКлиент.ПерейтиКИсправлению(ЭтаФорма.ДокументИсправление, "ОтменаСовмещения");
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПерейтиКИсправленному(Команда)
	ИсправлениеДокументовЗарплатаКадрыКлиент.ПерейтиКИсправленному(Объект.ИсправленныйДокумент, "ОтменаСовмещения");
КонецПроцедуры
// Конец ИсправлениеДокументов

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства 
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаСервере
Процедура СовмещающийСотрудникПриИзмененииНаСервере()
	
	ПриИзмененииРеквизитовОпределяющихОграниченияНаУровнеЗаписей();
	
	ПрочитатьВремяРегистрации();
	ЗаполнитьНачисленияСотрудника();
	РассчитатьФОТПоДокументу();
	УстановитьОтображениеНадписей();
	
КонецПроцедуры

&НаСервере
Процедура ДатаНачалаПриИзмененииНаСервере()
	ПрочитатьВремяРегистрации();
	ЗаполнитьНачисленияСотрудника();
	РассчитатьФОТПоДокументу();
	УстановитьОтображениеНадписей();
КонецПроцедуры

&НаСервере
Процедура ДокументОснованиеПриИзмененииНаСервере()
	Объект.Начисление = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.ДокументОснование, "Начисление");
	ЗаполнитьНачисленияСотрудника();
	РассчитатьФОТПоДокументу();
КонецПроцедуры

&НаСервере
Процедура ПриПолученииДанныхНаСервере()
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОписаниеТаблицыВидовРасчета = ОписаниеТаблицыНачислений();
	ЗарплатаКадрыРасширенный.РедактированиеСоставаНачисленийДополнитьФорму(ЭтаФорма, ОписаниеТаблицыВидовРасчета, "Начисления", 1, Ложь);
	
	ЗарплатаКадрыРасширенный.ОформлениеНесколькихДокументовНаОднуДатуДополнитьФорму(ЭтотОбъект);
	
	ИсправлениеДокументовЗарплатаКадры.ГруппаИсправлениеДополнитьФорму(ЭтаФорма, Истина, Ложь);
	
	УстановитьПривилегированныйРежим(Ложь);
	
	ДанныеВРеквизиты();
	
КонецПроцедуры

&НаСервере
Процедура ДанныеВРеквизиты()
	
	ИспользуетсяРасчетЗарплаты = ПолучитьФункциональнуюОпцию("ИспользоватьРасчетЗарплатыРасширенная");
	УстановитьДоступностьРегистрацииНачислений();
	
	ПрочитатьВремяРегистрации();
	
	ЗарплатаКадрыРасширенный.МногофункциональныеДокументыДобавитьЭлементыФормы(
		ЭтаФорма, НСтр("ru='Отмена доплаты утверждена'"), , "ОтменаДоплатыУтверждена");
		
	
	Если ИспользуетсяРасчетЗарплаты И Не ОграниченияНаУровнеЗаписей.ИзменениеБезОграничений И Объект.ОтменаДоплатыУтверждена Тогда 
		ТолькоПросмотр = Истина;
	КонецЕсли;
	
	УстановитьВидимостьРасчетныхПолей();
	
	Если ОграниченияНаУровнеЗаписей.ЧтениеБезОграничений Тогда
		РассчитатьФОТНаФорме(ЭтаФорма);
	КонецЕсли;
	
	ЗарплатаКадрыРасширенный.УстановитьПредупреждающуюНадписьВМногофункциональныхДокументах(ЭтаФорма, "ОтменаДоплатыУтверждена");
	ЗарплатаКадрыРасширенный.УстановитьВидимостьКомандПечатиМногофункциональногоДокумента(ЭтаФорма);
	
	ИсправлениеДокументовЗарплатаКадры.ПрочитатьРеквизитыИсправления(ЭтаФорма, "ПериодическиеСведения");
	ИсправлениеДокументовЗарплатаКадрыКлиентСервер.УстановитьПоляИсправления(ЭтаФорма, "ПериодическиеСведения");
	
	УстановитьОтображениеНадписей();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеТаблицыНачислений()
	
	ОписаниеТаблицыВидовРасчета = РасчетЗарплатыРасширенныйКлиентСервер.ОписаниеТаблицыРасчета();
	ОписаниеТаблицыВидовРасчета.ПутьКДанным = "Объект.НачисленияСотрудника";
	ОписаниеТаблицыВидовРасчета.ПутьКДаннымПоказателей = "";
	ОписаниеТаблицыВидовРасчета.ИмяРеквизитаДокументОснование = "ДокументОснование";
	
	Возврат ОписаниеТаблицыВидовРасчета;	
	
КонецФункции	

&НаСервере
Процедура УстановитьВидимостьРасчетныхПолей()
	
	ИменаЭлементов = Новый Массив;
	ИменаЭлементов.Добавить("ГруппаФОТ");
	
	ЗарплатаКадрыРасширенный.УстановитьОтображениеПолейМногофункциональныхДокументов(ЭтаФорма, ИменаЭлементов);
	
	Если ОграниченияНаУровнеЗаписей.ЧтениеБезОграничений Тогда 
		ЗарплатаКадрыРасширенный.УстановитьОтображениеГруппыФормы(Элементы, "ГруппаФОТ", "ТолькоПросмотр", Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьРегистрацииНачислений()
	
	ПраваНаДокумент = ЗарплатаКадрыРасширенный.ПраваНаМногофункциональныйДокумент(Объект);
	РегистрацияНачисленийДоступна = ПраваНаДокумент.ПолныеПраваПоРолям;
	ОграниченияНаУровнеЗаписей = Новый ФиксированнаяСтруктура(ПраваНаДокумент.ОграниченияНаУровнеЗаписей);
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииРеквизитовОпределяющихОграниченияНаУровнеЗаписей()
	
	БылиОграничения = ОграниченияНаУровнеЗаписей;
	УстановитьДоступностьРегистрацииНачислений();
	
	Если БылиОграничения.ЧтениеБезОграничений <> ОграниченияНаУровнеЗаписей.ЧтениеБезОграничений
		Или БылиОграничения.ИзменениеБезОграничений <> ОграниченияНаУровнеЗаписей.ИзменениеБезОграничений
		Или БылиОграничения.ИзменениеКадровыхДанных <> ОграниченияНаУровнеЗаписей.ИзменениеКадровыхДанных Тогда 
		
		Объект.ОтменаДоплатыУтверждена = ОграниченияНаУровнеЗаписей.ИзменениеБезОграничений;
		
		УстановитьВидимостьРасчетныхПолей();
		
		Если БылиОграничения.ЧтениеБезОграничений <> ОграниченияНаУровнеЗаписей.ЧтениеБезОграничений Тогда 
			ЗарплатаКадрыРасширенный.УстановитьВидимостьКомандПечатиМногофункциональногоДокумента(ЭтаФорма);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьФОТНаФорме(Форма)
	Форма.ФОТ = Форма.Объект.НачисленияСотрудника.Итог("Размер");
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНачисленияСотрудника()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Объект.НачисленияСотрудника.Очистить();
	
	СотрудникиДаты = Новый ТаблицаЗначений;
	СотрудникиДаты.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
	СотрудникиДаты.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	
	НоваяСтрока = СотрудникиДаты.Добавить();
	НоваяСтрока.Сотрудник = Объект.СовмещающийСотрудник;
	НоваяСтрока.Период = ВремяРегистрации;
	
	ДанныеНачислений = РасчетЗарплатыРасширенный.ДействующиеПлановыеНачисления(СотрудникиДаты, Объект.Ссылка);
	
	СтрокиДоплаты = ДанныеНачислений.Начисления.НайтиСтроки(Новый Структура("Начисление", Объект.Начисление));
	Для Каждого СтрокаДоплаты Из СтрокиДоплаты Цикл
		ДанныеНачислений.Начисления.Удалить(СтрокаДоплаты);
	КонецЦикла;
	
	Объект.НачисленияСотрудника.Загрузить(ДанныеНачислений.Начисления);
	
КонецПроцедуры

&НаСервере
Процедура РассчитатьФОТПоДокументу()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Не ЗначениеЗаполнено(Объект.Организация) 
		Или Не ЗначениеЗаполнено(Объект.СовмещающийСотрудник) 
		Или Не ЗначениеЗаполнено(Объект.ДатаОтмены) Тогда
		Возврат;
	КонецЕсли;
	
	// Подготовка к расчету ФОТ
	
	ТаблицаНачислений = ПлановыеНачисленияСотрудников.ТаблицаНачисленийДляРасчетаВторичныхДанных();
	
	ГоловнаяОрганизация = ЗарплатаКадрыПовтИсп.ГоловнаяОрганизация(Объект.Организация);
	
	// Все начисления сотрудника
	Для Каждого СтрокаНачисления Из Объект.НачисленияСотрудника Цикл
		ДанныеНачисления = ТаблицаНачислений.Добавить();
		ДанныеНачисления.Сотрудник = Объект.СовмещающийСотрудник;
		ДанныеНачисления.ГоловнаяОрганизация = ГоловнаяОрганизация;
		ДанныеНачисления.Период = ВремяРегистрации;
		ДанныеНачисления.Начисление = СтрокаНачисления.Начисление;
		ДанныеНачисления.ДокументОснование = СтрокаНачисления.ДокументОснование;
		ДанныеНачисления.Размер = СтрокаНачисления.Размер;
	КонецЦикла;
	
	РассчитанныеДанные = ПлановыеНачисленияСотрудников.РассчитатьВторичныеДанныеПлановыхНачислений(ТаблицаНачислений);
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Объект.НачисленияСотрудника.Очистить();
	
	Для Каждого ОписаниеНачисления Из РассчитанныеДанные.ПлановыйФОТ Цикл
		
		НовоеНачисление = Объект.НачисленияСотрудника.Добавить();
		НовоеНачисление.Начисление = ОписаниеНачисления.Начисление;
		НовоеНачисление.ДокументОснование = ОписаниеНачисления.ДокументОснование;
		НовоеНачисление.Размер = ОписаниеНачисления.ВкладВФОТ;
		
	КонецЦикла;
	
	РассчитатьФОТНаФорме(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьВремяРегистрации()
	
	ВремяРегистрации = ЗарплатаКадрыРасширенный.ВремяРегистрацииСотрудникаДокумента(Объект.Ссылка, Объект.СовмещающийСотрудник, Объект.ДатаОтмены);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтображениеНадписей()
	
	МассивСотрудников = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Объект.СовмещающийСотрудник);
	ЗарплатаКадрыРасширенный.УстановитьТекстНадписиОДокументахВведенныхНаДату(ЭтотОбъект, ВремяРегистрации, 
		МассивСотрудников, Объект.Ссылка, ОграниченияНаУровнеЗаписей.ЧтениеБезОграничений, Объект.ИсправленныйДокумент);
	
КонецПроцедуры

// Работа с данными формы редактирования начислений.

&НаСервере
Функция АдресВХранилищеНачисленийИУдержаний(Сотрудник)
	
	ПараметрыОткрытия = ЗарплатаКадрыРасширенныйКлиентСервер.ПараметрыРедактированияСоставаНачисленийИУдержаний();
	
	ПараметрыОткрытия.ВладелецНачисленийИУдержаний = Сотрудник;
	ПараметрыОткрытия.ДатаРедактирования = ВремяРегистрации;
	ПараметрыОткрытия.Организация = Объект.Организация;
	ПараметрыОткрытия.РежимРаботы = 3;
	ПараметрыОткрытия.ДополнитьНедостающиеЗначенияПоказателей = Истина;
	
	ДополнитьСтруктуруНачислениямиИПоказателями(Сотрудник, ПараметрыОткрытия.Подразделение, ПараметрыОткрытия);
	
	Возврат ПоместитьВоВременноеХранилище(ПараметрыОткрытия, УникальныйИдентификатор);
	
КонецФункции

&НаСервере
Процедура ДополнитьСтруктуруНачислениямиИПоказателями(Сотрудник, Подразделение, ПараметрыОткрытия)
	
	МассивНачислений = Новый Массив;
	МассивПоказателей = Новый Массив;
	
	ИдентификаторСтрокиВидаРасчета = 1;
	
	// Добавление всех начислений сотрудника (кроме начисления шапки).
	Для Каждого СтрокаНачислений Из Объект.НачисленияСотрудника Цикл
		
		СтруктураНачисления = Новый Структура("Начисление,ДокументОснование,ИдентификаторСтрокиВидаРасчета,Размер");
		ЗаполнитьЗначенияСвойств(СтруктураНачисления, СтрокаНачислений);
		СтруктураНачисления.ИдентификаторСтрокиВидаРасчета = ИдентификаторСтрокиВидаРасчета;
		МассивНачислений.Добавить(СтруктураНачисления);
		
		// Добавление показателей доплаты за совмещение.
		Если СтрокаНачислений.Начисление = Объект.Начисление Тогда
			
			СтруктураПоказателя = Новый Структура("Показатель,ИдентификаторСтрокиВидаРасчета,Значение");
			СтруктураПоказателя.Показатель = Справочники.ПоказателиРасчетаЗарплаты.РазмерДоплатыЗаСовмещение;
			СтруктураПоказателя.ИдентификаторСтрокиВидаРасчета = ИдентификаторСтрокиВидаРасчета;
			СтруктураПоказателя.Значение = Объект.РазмерДоплаты;
			МассивПоказателей.Добавить(СтруктураПоказателя);
			
		КонецЕсли;
		
		ИдентификаторСтрокиВидаРасчета = ИдентификаторСтрокиВидаРасчета + 1;
		
	КонецЦикла;
	
	ПараметрыОткрытия.ОписаниеТаблицыНачислений.Используется = Истина;
	ПараметрыОткрытия.ОписаниеТаблицыНачислений.Таблица = МассивНачислений;
	ПараметрыОткрытия.ОписаниеТаблицыНачислений.ИзменятьСоставВидовРасчета = Ложь;
	ПараметрыОткрытия.ОписаниеТаблицыНачислений.ИзменятьЗначенияПоказателей = Ложь;
	ПараметрыОткрытия.ОписаниеТаблицыНачислений.НомерТаблицы = 1;
	ПараметрыОткрытия.ОписаниеТаблицыНачислений.ПоказатьФОТ = Истина;
	
	ПараметрыОткрытия.Показатели = МассивПоказателей;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНачисленияИзВРеменногоХранилища(АдресВХранилище);
	
	ДанныеИзХранилища = ПолучитьИзВременногоХранилища(АдресВХранилище);
	Если ДанныеИзХранилища = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Сотрудник = ДанныеИзХранилища.ВладелецНачисленийИУдержаний;
	Если Сотрудник <> Объект.СовмещающийСотрудник Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого НачислениеСотрудника Из ДанныеИзХранилища.Начисления Цикл
		
		СтрокиНачисления = Объект.НачисленияСотрудника.НайтиСтроки(Новый Структура("Начисление", НачислениеСотрудника.Начисление));
		Если СтрокиНачисления.Количество() > 0 Тогда
			СтрокиНачисления[0].Размер = НачислениеСотрудника.Размер;
		КонецЕсли;		
		
	КонецЦикла;
	
	РассчитатьФОТНаФорме(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеФормыПоОрганизации()
	
	Если НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
		Возврат;
	КонецЕсли; 
	
	ЗапрашиваемыеЗначения = Новый Структура;
	ЗапрашиваемыеЗначения.Вставить("Организация", "Объект.Организация");
	
	ЗапрашиваемыеЗначения.Вставить("Руководитель", "Объект.Руководитель");
	ЗапрашиваемыеЗначения.Вставить("ДолжностьРуководителя", "Объект.ДолжностьРуководителя");
	
	ЗарплатаКадры.ЗаполнитьЗначенияВФорме(ЭтаФорма, ЗапрашиваемыеЗначения, ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве("Организация"));	
	
КонецПроцедуры

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	
	ПриИзмененииРеквизитовОпределяющихОграниченияНаУровнеЗаписей();
	ЗаполнитьДанныеФормыПоОрганизации();
	
КонецПроцедуры

#КонецОбласти
