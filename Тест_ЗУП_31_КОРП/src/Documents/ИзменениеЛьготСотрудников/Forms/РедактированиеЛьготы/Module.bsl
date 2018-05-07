
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Сотрудник = Параметры.Сотрудник;
	Льгота = Параметры.Льгота;
	ПоказателиСотрудника = Параметры.ПоказателиСотрудника;
	
	Заголовок = Строка(Параметры.Льгота);
	
	ОписаниеЛьготы = ЗарплатаКадрыРасширенныйПовтИсп.ПолучитьИнформациюОВидеРасчета(Параметры.Льгота);
	
	МассивПоказателей = Новый Массив;
	Для Каждого ОписаниеПоказателя Из ОписаниеЛьготы.Показатели Цикл 
		Если ОписаниеПоказателя.ЗапрашиватьПриВводе Тогда 
			МассивПоказателей.Добавить(ОписаниеПоказателя.Показатель);
		КонецЕсли;
	КонецЦикла;
	
	КоличествоПоказателей = ?(ОписаниеЛьготы.Рассчитывается, МассивПоказателей.Количество(), 1);;
	
	Если Не ОписаниеЛьготы.Рассчитывается Тогда 
		ПоказателиСотрудника = Новый Соответствие;
		ПоказателиСотрудника.Вставить(Справочники.ПоказателиРасчетаЗарплаты.ПустаяСсылка(), Параметры.Размер);
	КонецЕсли;
	
	ДополнитьФорму(ОписаниеЛьготы, МассивПоказателей);
	
	ЗаполнитьТекущиеДанные(ОписаниеЛьготы, МассивПоказателей, ПоказателиСотрудника);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	ДанныеЛьготы = Новый Структура("Сотрудник, Льгота, Размер, ПоказателиСотрудника");
	ДанныеЛьготы.Сотрудник = Сотрудник;
	ДанныеЛьготы.Льгота = Льгота;
	
	ПоказателиСотрудника = Новый Соответствие;
	
	Для Сч = 1 По КоличествоПоказателей Цикл
		
		Показатель = ЭтотОбъект["Показатель" + Сч];
		Значение = ЭтотОбъект["Показатель" + Сч + "Значение"];
		
		Если Не ЗначениеЗаполнено(Показатель) Тогда 
			ДанныеЛьготы.Размер = Значение;
		Иначе 
			ПоказателиСотрудника.Вставить(Показатель, Значение);
		КонецЕсли;
		
	КонецЦикла;
	
	ДанныеЛьготы.ПоказателиСотрудника = ПоказателиСотрудника;
	
	Оповестить("ИзмененыПоказателиЛьготы", ДанныеЛьготы, ЭтотОбъект.ВладелецФормы);
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ДополнитьФорму(ОписаниеЛьготы, МассивПоказателей)

	НаименованияПоказателей = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(МассивПоказателей, "Наименование");
	
	МассивИменРеквизитовФормы = Новый Массив;
	ЗарплатаКадры.ЗаполнитьМассивИменРеквизитовФормы(ЭтотОбъект, МассивИменРеквизитовФормы);
	
	ДобавляемыеРеквизиты = Новый Массив;
	
	Для Сч = 1 По КоличествоПоказателей Цикл
		
		ПоказательРеквизит = Новый РеквизитФормы(
			"Показатель" + Сч, Новый ОписаниеТипов("СправочникСсылка.ПоказателиРасчетаЗарплаты"));
		ДобавляемыеРеквизиты.Добавить(ПоказательРеквизит);
		
		НаименованиеПоказателя = ?(ОписаниеЛьготы.Рассчитывается, 
			НаименованияПоказателей[МассивПоказателей[Сч-1]], НСтр("ru = 'Фиксированная сумма'"));
			
		ЗначениеРеквизит = Новый РеквизитФормы("Показатель" + Сч + "Значение",
			Справочники.ПоказателиРасчетаЗарплаты.ОписаниеТиповЗначенияПоказателяРасчетаЗарплаты(), , НаименованиеПоказателя);
		ДобавляемыеРеквизиты.Добавить(ЗначениеРеквизит);
		
	КонецЦикла;
	
	ЗарплатаКадры.ИзменитьРеквизитыФормы(ЭтотОбъект, ДобавляемыеРеквизиты, МассивИменРеквизитовФормы);
	
	Для Сч = 1 По КоличествоПоказателей Цикл
		
		Если Элементы.Найти("Показатель" + Сч + "Значение") = Неопределено Тогда 
			Значение = Элементы.Добавить("Показатель" + Сч + "Значение", Тип("ПолеФормы"), Элементы.ГруппаПоказатели);
			Значение.Вид = ВидПоляФормы.ПолеВвода;
			Значение.ПутьКДанным = "Показатель" + Сч + "Значение";
			Значение.РастягиватьПоГоризонтали = Ложь;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТекущиеДанные(ОписаниеЛьготы, МассивПоказателей, ПоказателиСотрудника)
	
	Для Сч = 1 По КоличествоПоказателей Цикл
		
		Показатель = ?(ОписаниеЛьготы.Рассчитывается, МассивПоказателей[Сч-1], Справочники.ПоказателиРасчетаЗарплаты.ПустаяСсылка());
		ЭтотОбъект["Показатель" + Сч] = Показатель;
		
		Если ПоказателиСотрудника <> Неопределено Тогда
			ЭтотОбъект["Показатель" + Сч + "Значение"] = ПоказателиСотрудника[Показатель];
		КонецЕсли;
		
		ТочностьПоказателя = 2;
		Если ЗначениеЗаполнено(Показатель) Тогда 
			СведенияОПоказателе = ЗарплатаКадрыРасширенный.СведенияОПоказателеРасчетаЗарплаты(Показатель);
		    ТочностьПоказателя = СведенияОПоказателе.Точность;
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "Показатель" + Сч + "Значение", "ФорматРедактирования", "ЧДЦ=" + ТочностьПоказателя);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
