
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеТаблицыВидовРасчета = ОписаниеТаблицыЛьгот();
	ЗарплатаКадрыРасширенный.РедактированиеСоставаНачисленийДополнитьФорму(ЭтаФорма, ОписаниеТаблицыВидовРасчета, "Начисления", 3);
	
	ЛьготыОрганизации = Параметры.ЛьготыОрганизации; 
	
	Организация = ЛьготыОрганизации.Организация;
	ЗаполнитьДанныеПозицииНаСервере(ЛьготыОрганизации.ДанныеЛьгот, ЛьготыОрганизации.ДанныеПоказателейЛьгот, ЛьготыОрганизации.ДанныеИндивидуальныхЛьгот);
	
	ИспользоватьШтатноеРасписание = ПолучитьФункциональнуюОпцию("ИспользоватьШтатноеРасписание");
	Если ИспользоватьШтатноеРасписание Тогда 
		Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Льготы организации %1'"), Организация);
	КонецЕсли;
	
	ИспользоватьСамообслуживание = ПолучитьФункциональнуюОпцию("ИспользоватьСамообслуживаниеСотрудников");
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаСамообслуживание", "Видимость", ИспользоватьСамообслуживание);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыЛьготы

&НаКлиенте
Процедура ЛьготыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	ЗарплатаКадрыРасширенныйКлиент.РедактированиеСоставаНачисленийПриНачалеРедактирования(ЭтотОбъект, "Льготы", 1);
	
КонецПроцедуры

&НаКлиенте
Процедура ЛьготыЛьготаПриИзменении(Элемент)
	
	ОписаниеТаблицыВидовРасчета = ОписаниеТаблицыЛьгот();
	ЗарплатаКадрыРасширенныйКлиент.РедактированиеСоставаНачисленийНачислениеПриИзменении(ЭтотОбъект, ОписаниеТаблицыВидовРасчета, 1);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ЛьготыОрганизации = СтруктураЛьготОрганизации();
	ОповеститьОВыборе(ЛьготыОрганизации);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьДанныеПозицииНаСервере(ДанныеЛьгот, ДанныеПоказателейЛьгот, ДанныеИндивидуальныхЛьгот)
	
	Льготы.Очистить();
	Показатели.Очистить();
	ИндивидуальныеЛьготы.Очистить();
	
	Если ДанныеЛьгот <> Неопределено Тогда 
	
		ИдентификаторСтрокиВидаРасчета = 1;
		Для Каждого ДанныеЛьготы Из ДанныеЛьгот Цикл
			НоваяСтрока = Льготы.Добавить();
			НоваяСтрока.Льгота = ДанныеЛьготы.Ключ;
			НоваяСтрока.Размер = ДанныеЛьготы.Значение;
			НоваяСтрока.ИдентификаторСтрокиВидаРасчета = ИдентификаторСтрокиВидаРасчета;
			Если ДанныеПоказателейЛьгот <> Неопределено Тогда 
				ЗначенияПоказателей = ДанныеПоказателейЛьгот.Получить(ДанныеЛьготы.Ключ);
				Если ЗначенияПоказателей <> Неопределено Тогда 
					Для Каждого КлючИЗначение Из ЗначенияПоказателей Цикл 
						НоваяСтрока = Показатели.Добавить();
						НоваяСтрока.Показатель = КлючИЗначение.Ключ;
						НоваяСтрока.Значение = КлючИЗначение.Значение;
						НоваяСтрока.ИдентификаторСтрокиВидаРасчета = ИдентификаторСтрокиВидаРасчета;
					КонецЦикла;
				КонецЕсли;
			КонецЕсли;
			ИдентификаторСтрокиВидаРасчета = ИдентификаторСтрокиВидаРасчета + 1;
		КонецЦикла;
		
		ОписаниеТаблицыВидовРасчета = ОписаниеТаблицыЛьгот();
		ЗарплатаКадрыРасширенный.ВводНачисленийДанныеВРеквизит(ЭтаФорма, ОписаниеТаблицыВидовРасчета, 1);	
		
	КонецЕсли;
	
	Если ДанныеИндивидуальныхЛьгот <> Неопределено Тогда 
		Для Каждого ДанныеЛьготы Из ДанныеИндивидуальныхЛьгот Цикл
			НоваяСтрока = ИндивидуальныеЛьготы.Добавить();
			НоваяСтрока.Льгота = ДанныеЛьготы.Ключ;
		КонецЦикла;	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СтруктураЛьготОрганизации()
	
	ОписаниеТаблицыВидовРасчета = ОписаниеТаблицыЛьгот();
	ЗарплатаКадрыРасширенный.ВводНачисленийРеквизитВДанные(ЭтотОбъект, ЭтотОбъект, ОписаниеТаблицыВидовРасчета, 1);	
	
	ДанныеЛьгот = Новый Соответствие;
	ДанныеПоказателейЛьгот = Новый Соответствие;
	
	Для Каждого ДанныеЛьготы Из Льготы Цикл
		
		Если Не ЗначениеЗаполнено(ДанныеЛьготы.Льгота) Тогда 
			Продолжить;
		КонецЕсли;
		
		Размер = 0;
		Если ДанныеЛьготы.ФиксированнаяСумма Тогда 
			Размер = ДанныеЛьготы.Значение1;
		КонецЕсли;
		
		ДанныеЛьгот.Вставить(ДанныеЛьготы.Льгота, Размер);
		
		СтруктураОтбора = Новый Структура("ИдентификаторСтрокиВидаРасчета", ДанныеЛьготы.ИдентификаторСтрокиВидаРасчета);
		СтрокиПоказателей = Показатели.НайтиСтроки(СтруктураОтбора);
		
		ЗначенияПоказателей = Новый Соответствие;
		Для Каждого ДанныеПоказателя Из СтрокиПоказателей Цикл 
			ЗначенияПоказателей.Вставить(ДанныеПоказателя.Показатель, ДанныеПоказателя.Значение);
		КонецЦикла;
		
		ДанныеПоказателейЛьгот.Вставить(ДанныеЛьготы.Льгота, ЗначенияПоказателей);
		
	КонецЦикла;
	
	ДанныеИндивидуальныхЛьгот = Новый Соответствие;
	Для Каждого ДанныеЛьготы Из ИндивидуальныеЛьготы Цикл
		Если Не ЗначениеЗаполнено(ДанныеЛьготы.Льгота) Тогда 
			Продолжить;
		КонецЕсли;
		ДанныеИндивидуальныхЛьгот.Вставить(ДанныеЛьготы.Льгота, Истина);
	КонецЦикла;
	
	ЛьготыОрганизации = Новый Структура;
	ЛьготыОрганизации.Вставить("Организация", Организация);
	ЛьготыОрганизации.Вставить("ДанныеЛьгот", ДанныеЛьгот);
	ЛьготыОрганизации.Вставить("ДанныеПоказателейЛьгот", ДанныеПоказателейЛьгот);
	ЛьготыОрганизации.Вставить("ДанныеИндивидуальныхЛьгот", ДанныеИндивидуальныхЛьгот);
	
	Возврат ЛьготыОрганизации;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеТаблицыЛьгот()
	
	ОписаниеТаблицыВидовРасчета = РасчетЗарплатыРасширенныйКлиентСервер.ОписаниеТаблицыПлановыхНачислений(Ложь, Ложь);
	ОписаниеТаблицыВидовРасчета.ИмяТаблицы = "Льготы";
	ОписаниеТаблицыВидовРасчета.ИмяРеквизитаВидРасчета = "Льгота";
	ОписаниеТаблицыВидовРасчета.ПутьКДанным = "Льготы";
	ОписаниеТаблицыВидовРасчета.ПутьКДаннымПоказателей = "Показатели";
	ОписаниеТаблицыВидовРасчета.ИмяРеквизитаФиксРасчет = "ЛьготыФиксРасчет";
	ОписаниеТаблицыВидовРасчета.ИмяРеквизитаДокументОснование = "";
	
	Возврат ОписаниеТаблицыВидовРасчета;
	
КонецФункции

#КонецОбласти
