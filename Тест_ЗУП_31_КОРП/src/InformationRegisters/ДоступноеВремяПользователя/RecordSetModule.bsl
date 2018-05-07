#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	// Для записи набора записей требуем чтобы был установлен отбор по пользователю
	Пользователь = Отбор.Найти("Пользователь").Значение;
	Если Не ЗначениеЗаполнено(Пользователь) Тогда
		ВызватьИсключение НСтр("ru = 'Запрещено записывать набор регистра сведений ""Доступное время пользователя"" без установки отбора по пользователю.'");
	КонецЕсли;
	
	// Для каждого времени доступности требуем чтобы время начала было не больше времени окончания.
	Для Каждого Запись Из ЭтотОбъект Цикл
		
		Если Запись.ВремяОкончания < Запись.ВремяНачала Тогда
			ПромежутокВремениСтрокой = РаботаСРабочимКалендаремКлиентСервер.ПолучитьПромежутокВремениСтрокой(
				Запись.ВремяНачала, Запись.ВремяОкончания, Запись.ДеньНедели);
			ТекстИсключения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Время окончания не может быть меньше времени окончания доступности:
					|%1'"),
				ПромежутокВремениСтрокой);
			ВызватьИсключение ТекстИсключения;
		КонецЕсли;
		
	КонецЦикла;
	
	// Если есть дубликаты записей или же пересекающие записи то корректируем набор записей.
	Если НеобходимоСкорректироватьНаборЗаписей() Тогда
		СкорректироватьНаборЗаписей();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НеобходимоСкорректироватьНаборЗаписей()
	
	ЕстьДублированиеЗаписей = Ложь;
	ЕстьПересечениеЗаписей = Ложь;
	// Проверяем дублирование записей
	Для Каждого ПроверяемаяЗапись Из ЭтотОбъект Цикл
		НайденаЗапись = Ложь;
		Для Каждого Запись Из ЭтотОбъект Цикл
			Если ЗаписиСовпадают(ПроверяемаяЗапись, Запись) Тогда
				Если НайденаЗапись Тогда
					Возврат Истина;
				Иначе
					НайденаЗапись = Истина
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	// Проверяем пересечение записей
	Для Каждого ПроверяемаяЗапись Из ЭтотОбъект Цикл
		Для Каждого Запись Из ЭтотОбъект Цикл
			Если ПроверяемаяЗапись.ДеньНедели = Запись.ДеньНедели
				И ПроверяемаяЗапись.ВремяНачала <= Запись.ВремяОкончания
				И ПроверяемаяЗапись.ВремяОкончания >= Запись.ВремяНачала Тогда
				Возврат Истина;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ЗаписиСовпадают(Запись1, Запись2)
	
	Возврат Запись1.ДеньНедели = Запись2.ДеньНедели
		И Запись1.ВремяНачала = Запись2.ВремяНачала
		И Запись1.ВремяОкончания = Запись2.ВремяОкончания
		И Запись1.Пользователь = Запись2.Пользователь;
	
КонецФункции

Процедура СкорректироватьНаборЗаписей()
	
	ТребуетсяВнестиКоррективы = Истина;
	
	Пока ТребуетсяВнестиКоррективы Цикл
		
		ТребуетсяВнестиКоррективы = Ложь;
		
		МассивЗаписей = ЭтотОбъект.Выгрузить();
		
		ЭтотОбъект.Очистить();
		
		Для Каждого Запись Из МассивЗаписей Цикл
			
			ВнестиЗаписьВНаборЗначений = Истина;
			
			Для Каждого ВнесеннаяЗапись Из ЭтотОбъект Цикл
				
				Если ЗаписиСовпадают(Запись, ВнесеннаяЗапись) Тогда
					ВнестиЗаписьВНаборЗначений = Ложь;
					Прервать;
				КонецЕсли;
				
				Если Запись.Пользователь = ВнесеннаяЗапись.Пользователь 
					И Запись.ДеньНедели = ВнесеннаяЗапись.ДеньНедели
					И Запись.ВремяНачала <= ВнесеннаяЗапись.ВремяОкончания
					И Запись.ВремяОкончания >= ВнесеннаяЗапись.ВремяНачала Тогда
					
					ВнесеннаяЗапись.ВремяНачала = Мин(ВнесеннаяЗапись.ВремяНачала, Запись.ВремяНачала);
					ВнесеннаяЗапись.ВремяОкончания = Макс(ВнесеннаяЗапись.ВремяОкончания, Запись.ВремяОкончания);
					
					ТребуетсяВнестиКоррективы = Истина;
					ВнестиЗаписьВНаборЗначений = Ложь;
					Прервать;
					
				КонецЕсли;
				
			КонецЦикла;
			
			Если НЕ ВнестиЗаписьВНаборЗначений Тогда
				Продолжить;
			КонецЕсли;
			
			НоваяСтрока = ЭтотОбъект.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Запись);
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
