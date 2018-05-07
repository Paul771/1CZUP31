
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("ВедущийОбъект", ОбъектВладелец);
	Если Не ЗначениеЗаполнено(ОбъектВладелец) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	// Если объект еще не заблокирован для изменений и есть права на изменение набора
	// попытаемся установить блокировку.
	Если НЕ Пользователи.РолиДоступны("ДобавлениеИзменениеДанныхФизическихЛицЗарплатаКадры") Тогда
		
		ТолькоПросмотр = Истина;
		
	КонецЕсли; 
	
	Если ТолькоПросмотр Тогда
		
		Элементы.НаборЗаписей.ТолькоПросмотр = Истина;
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, 
			"ФормаКомандаОК",
			"Доступность",
			Ложь);
			
		Элементы.ФормаКомандаОтмена.КнопкаПоУмолчанию = Истина;
		
	КонецЕсли;
		
	Для Каждого ЗаписьНабора Из Параметры.МассивЗаписей Цикл
		ЗаполнитьЗначенияСвойств(НаборЗаписей.Добавить(), ЗаписьНабора);
	КонецЦикла;
	
	НаборЗаписей.Сортировать("Период");
	
	ДатаОтсчетаПериодическихСведений = ЗарплатаКадрыКлиентСервер.ДатаОтсчетаПериодическихСведений();
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Набор = РеквизитФормыВЗначение("НаборЗаписей");
	Если Не Набор.ПроверитьЗаполнение() Тогда
		Отказ = Истина;
		Сообщения = ПолучитьСообщенияПользователю(Истина);
		Если Сообщения <> Неопределено Тогда
			Для каждого ПолученноеСообщение Из Сообщения Цикл
				ПолученноеСообщение.КлючДанных = Неопределено;
				ПолученноеСообщение.Сообщить();
			КонецЦикла;
		КонецЕсли; 
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийТаблицыФормыНаборЗаписей

&НаКлиенте
Процедура НаборЗаписейПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		
		Если НоваяСтрока Тогда
			
			Элемент.ТекущиеДанные.ФизическоеЛицо = ОбъектВладелец;
			НовыйПериод = ОбщегоНазначенияКлиент.ДатаСеанса();
			Если НаборЗаписей.Количество() > 1 Тогда
				ЗаписьФИОФизическихЛиц = НаборЗаписей.Получить(НаборЗаписей.Количество() - 2);
				Элемент.ТекущиеДанные.Фамилия 	= ЗаписьФИОФизическихЛиц.Фамилия;
				Элемент.ТекущиеДанные.Имя 		= ЗаписьФИОФизическихЛиц.Имя;
				Элемент.ТекущиеДанные.Отчество 	= ЗаписьФИОФизическихЛиц.Отчество;
				ПоследнийПериод = ЗаписьФИОФизическихЛиц.Период;
			Иначе
				ПоследнийПериод = '00010101000000';
			КонецЕсли; 
			
			Если НовыйПериод <= ПоследнийПериод Тогда
				НовыйПериод = КонецДня(ПоследнийПериод) + 1;
			КонецЕсли; 
			
			Элемент.ТекущиеДанные.Период = НовыйПериод;
			
		Иначе
			
			ПериодПередНачаломИзменения = Элемент.ТекущиеДанные.Период;
			Если Элемент.ТекущиеДанные.Период = ДатаОтсчетаПериодическихСведений Тогда
				Элемент.ТекущиеДанные.Период = '00010101000000';
			КонецЕсли; 
			
		КонецЕсли;
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	Если Элемент.ТекущиеДанные <> Неопределено Тогда
		
		Если ОтменаРедактирования Тогда
			Элемент.ТекущиеДанные.Период = ПериодПередНачаломИзменения;
		Иначе
		
			Если Не ЗначениеЗаполнено(Элемент.ТекущиеДанные.Период) Тогда
				Элемент.ТекущиеДанные.Период = ДатаОтсчетаПериодическихСведений;
			КонецЕсли; 
	
			НайденныеСтроки = НаборЗаписей.НайтиСтроки(Новый Структура("Период", Элемент.ТекущиеДанные.Период));
			Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
				Если НайденнаяСтрока <> Элемент.ТекущиеДанные Тогда
					СообщениеОбОшибке = НСтр("ru = 'Уже есть запись с указанной датой сведений'");
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщениеОбОшибке,,"НаборЗаписей.Период", , Отказ);
					Элемент.ТекущиеДанные.Период = '00010101000000';
					Прервать;
				КонецЕсли; 
			КонецЦикла;
				
		КонецЕсли;
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура НаборЗаписейПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	РедактированиеПериодическихСведенийКлиент.УпорядочитьНаборЗаписейВФорме(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Если ПроверитьЗаполнение() Тогда
		РедактированиеПериодическихСведенийКлиент.ОповеститьОЗавершении(ЭтаФорма, "ФИОФизическихЛиц", ОбъектВладелец);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	Закрыть();
КонецПроцедуры

#КонецОбласти
