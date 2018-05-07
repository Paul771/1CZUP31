
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	мСкопированаФорма = Неопределено;
	мСохраненныйДок   = Неопределено;
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	НеОтображатьПредупреждение = Параметры.НеОтображатьПредупреждение;
	мСохраненныйДок			   = Параметры.ЗначениеКопирования;
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка)
		И ЗначениеЗаполнено(Объект.ВыбраннаяФорма) Тогда
		
		мСкопированаФорма = Объект.ВыбраннаяФорма;
		
	КонецЕсли;
	
	ИсточникОтчета = "";
	Объект.Свойство("ИсточникОтчета", ИсточникОтчета);
	Если ИсточникОтчета = "РегламентированныйОтчетТорговыйСбор1"
		Или ИсточникОтчета = "РегламентированныйОтчетТорговыйСбор2"
		Или ИсточникОтчета = "РегламентированныйОтчетНевозможностьПредоставления" Тогда 
		
		Отказ = Истина;
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = НСтр("ru='Отчет был сохранен в предыдущей редакции конфигурации. Открытие невозможно.'");
		Сообщение.Сообщить();
		
		Возврат;
	КонецЕсли;
	
	Если Не(РеквизитФормыВЗначение("Объект").ЭтоНовый()) ИЛИ (мСкопированаФорма <> Неопределено) Тогда
		                     		
		Если Объект.ИсточникОтчета = "РегламентированныйОтчетСведенияОДолеДоходовОтОбразовательнойИлиМедицинскойДеятельности" Тогда
			Объект.ИсточникОтчета = "РегламентированныйОтчетСведенияОДолеДоходовОтОбразовательнойИлиМедДеятельности";
		КонецЕсли;						  
		
		ПравоДоступаКОтчету = РегламентированнаяОтчетностьВызовСервера.ПравоДоступаКРегламентированномуОтчету(Объект.ИсточникОтчета);
		
		Если ПравоДоступаКОтчету = Ложь Тогда
			
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = НСтр("ru='Недостаточно прав.'");
			Сообщение.Сообщить();
			
			Возврат;
			
		ИначеЕсли ПравоДоступаКОтчету = Неопределено Тогда
			
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = НСтр("ru='Не удалось открыть сохраненные данные. Отчет не найден.'");
			Сообщение.Сообщить();
			
			Возврат;
			
		КонецЕсли;
		
		// Возвращает типы ВнешнийОтчетОбъект.<Имя> и ОтчетМенеджер.<Имя>
		ВариантФормыОтчета = Неопределено;
		ОбъектОтчет = РегламентированнаяОтчетность.РеглОтчеты(Объект.ИсточникОтчета);
		
		Если ОбъектОтчет = Неопределено Тогда
			
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = НСтр("ru='Не удалось открыть сохраненные данные. Отчет не найден.'");
			Сообщение.Сообщить();
			
			Возврат;
			
		КонецЕсли;
		
		ОткрытьФормуОтчета = Истина;
		ВариантФормыОтчета = ?(СтрНайти(ОбъектОтчет, "ОтчетМенеджер") > 0, "Отчет.", "ВнешнийОтчет.")
		
	ИначеЕсли РеквизитФормыВЗначение("Объект").ЭтоНовый() Тогда
		
		ОткрытьФормуОтчета = Ложь;
		
	КонецЕсли;
	
	Если НЕ Параметры.ОткрытьФормуОтчета Тогда
		ОткрытьФормуРСВ1 = Ложь;
	Иначе
		ОткрытьФормуРСВ1 = Истина;
	КонецЕсли;
	
	ЭлектронныйДокументооборотСКонтролирующимиОрганами.ОтметитьКакПрочтенное(Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Отказ = Истина;
	
	Если ОткрытьФормуОтчета Тогда
		
		СтандартнаяОбработка = Истина;
		
		ПараметрыФормы = Новый Структура;
		
		ПараметрыФормы.Вставить("мДатаНачалаПериодаОтчета", НачалоДня(Объект.ДатаНачала));
		ПараметрыФормы.Вставить("мСкопированаФорма",        мСкопированаФорма);
		ПараметрыФормы.Вставить("мДатаКонцаПериодаОтчета",  КонецДня(Объект.ДатаОкончания));
		ПараметрыФормы.Вставить("мПериодичность",           Объект.Периодичность);
		ПараметрыФормы.Вставить("Организация",              Объект.Организация);
		ПараметрыФормы.Вставить("мВыбраннаяФорма",          Объект.ВыбраннаяФорма);
		ПараметрыФормы.Вставить("ВидДокумента",             Объект.Вид);
		ПараметрыФормы.Вставить("ДоступенМеханизмПечатиРеглОтчетностиСДвухмернымШтрихкодомPDF417",
			РегламентированнаяОтчетностьКлиент.ДоступенМеханизмПечатиРеглОтчетностиСДвухмернымШтрихкодомPDF417());
		ПараметрыФормы.Вставить("НеОтображатьПредупреждение", НеОтображатьПредупреждение);
		ПараметрыФормы.Вставить("ПредставлениеВидаОтчета", 	Объект.НаименованиеОтчета);
		ПараметрыФормы.Вставить("мСохраненныйДок", 			мСохраненныйДок);
		
		Если Объект.ИсточникОтчета = "РегламентированныйОтчетСтатистикаПрочиеФормы" Тогда
			ВыбраннаяФорма = ?(СтрНайти(Объект.ВыбраннаяФорма, "_") = 0,
				Объект.ВыбраннаяФорма, Лев(Объект.ВыбраннаяФорма, СтрНайти(Объект.ВыбраннаяФорма, "_") - 1));
		Иначе
			ВыбраннаяФорма = Объект.ВыбраннаяФорма;
		КонецЕсли;
		
		Если Объект.ИсточникОтчета = "РегламентированныйОтчетРСВ1" Тогда
			СтартоваяФорма = РегламентированнаяОтчетностьКлиентСерверПереопределяемый.ИмяОсновнойФормыРСВ1();
		Иначе
			СтартоваяФорма = "ОсновнаяФорма";
		КонецЕсли;
		ЭтоСтартоваяФорма = ВыбраннаяФорма = СтартоваяФорма;
		
		Если мСкопированаФорма <> Неопределено Тогда
			Если (ВладелецФормы.ИмяФормы = "ОбщаяФорма.РегламентированнаяОтчетность") 
				ИЛИ (ВладелецФормы.ИмяФормы = "Обработка.ОбщиеОбъектыРеглОтчетности.Форма.УправлениеОтчетностью")
				ИЛИ (ВладелецФормы.ИмяФормы = "Документ.РегламентированныйОтчет.Форма.ФормаСписка") Тогда
				ЭтоСтартоваяФорма = Истина;
			КонецЕсли;
		КонецЕсли;
		
		Попытка
			
			КлючУникальности = Объект.Ссылка;
			
			Если мСкопированаФорма = Неопределено Тогда
				
				ПараметрыФормы.Вставить("мСохраненныйДок", Объект.Ссылка);
				
				Если Объект.ИсточникОтчета = "РегламентированныйОтчетРСВ1"
					И Объект.ДатаОкончания >= '20140101'
					И НЕ ОткрытьФормуРСВ1 Тогда
					
					ОписаниеРСВ_1 = Новый Структура;
					
					ОписаниеРСВ_1.Вставить("Организация",             Объект.Организация);
					ОписаниеРСВ_1.Вставить("ДатаНачалаПериодаОтчета", Объект.ДатаНачала);
					ОписаниеРСВ_1.Вставить("ДатаКонцаПериодаОтчета",  Объект.ДатаОкончания);
					ОписаниеРСВ_1.Вставить("КорректирующаяФорма",     ?(Объект.Вид = 0, Ложь, Истина));
					
					РегламентированнаяОтчетностьКлиентПереопределяемый.ПриОткрытииРСВ_1ИзЖурналаРеглОтчетов(
						Объект.Ссылка, ОписаниеРСВ_1, СтандартнаяОбработка);
					
					Если СтандартнаяОбработка Тогда
						
						ИмяФормыОтчета = ВариантФормыОтчета + Объект.ИсточникОтчета + ".Форма." + ВыбраннаяФорма;
						
						Если ЭтоСтартоваяФорма Тогда
							ФормаОтчета = ПолучитьФорму(ИмяФормыОтчета, ПараметрыФормы, , ИмяФормыОтчета);
						Иначе
							ФормаОтчета = ПолучитьФорму(ИмяФормыОтчета, ПараметрыФормы, , КлючУникальности);
						КонецЕсли;
						
						ФормаОтчета.СтруктураРеквизитовФормы.Организация = Объект.Организация;
						
					КонецЕсли;
					
				Иначе
					
					ИмяФормыОтчета = ВариантФормыОтчета + Объект.ИсточникОтчета + ".Форма." + ВыбраннаяФорма;
					
					Если ЭтоСтартоваяФорма Тогда
						ФормаОтчета = ПолучитьФорму(ИмяФормыОтчета, ПараметрыФормы, , ИмяФормыОтчета);
					Иначе
						ФормаОтчета = ПолучитьФорму(ИмяФормыОтчета, ПараметрыФормы, , КлючУникальности);
					КонецЕсли;
					
					ФормаОтчета.СтруктураРеквизитовФормы.Организация = Объект.Организация;
					
				КонецЕсли;
				
			Иначе
				
				Если Объект.ИсточникОтчета = "РегламентированныйОтчетРСВ1" Тогда
					
					Если Объект.ДатаОкончания >= '20140101' Тогда
						
						Сообщение = Новый СообщениеПользователю;
						Сообщение.Текст = НСтр(
							"ru='Копирование формы РСВ-1, начиная с отчетного периода ""1 квартал 2014 г."" и более поздние, не предусмотрено.'");
						Сообщение.Сообщить();
						
						Возврат;
						
					Иначе
						
						ИмяФормыОтчета = ВариантФормыОтчета + Объект.ИсточникОтчета + ".Форма."
							+ РегламентированнаяОтчетностьКлиентСерверПереопределяемый.ИмяОсновнойФормыРСВ1();
						ФормаОтчета = ПолучитьФорму(ИмяФормыОтчета, ПараметрыФормы, , ИмяФормыОтчета);
						
					КонецЕсли;
					
				ИначеЕсли Объект.ИсточникОтчета = "БухгалтерскаяОтчетностьВБанк" Тогда
					
					Сообщение = Новый СообщениеПользователю;
					Сообщение.Текст = НСтр("ru='Копирование отчетов для банков не предусмотрено.'");
					Сообщение.Сообщить();
					
					Возврат;
					
				Иначе
					
					ИмяФормыОтчета = ВариантФормыОтчета + Объект.ИсточникОтчета + ".Форма.ОсновнаяФорма";
					ФормаОтчета = ПолучитьФорму(ИмяФормыОтчета, ПараметрыФормы, , ИмяФормыОтчета);
					
				КонецЕсли;
				
				ФормаОтчета.Организация = Объект.Организация;
				
			КонецЕсли;
			
		Исключение
			
			Сообщение = Новый СообщениеПользователю;
			
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			
			Если ИнформацияОбОшибке.Причина = Неопределено Тогда
				Сообщение.Текст = НСтр("ru='При открытии формы регламентированного отчета произошла ошибка.'");
			ИначеЕсли СтрНайти(ИнформацияОбОшибке.Причина.Описание, ".Форма.") > 0 Тогда
				Сообщение.Текст = НСтр("ru='Отчет не может быть открыт. Устаревшая редакция формы отчета не поддерживается текущей версией конфигурации.'");
			Иначе
				Сообщение.Текст = ИнформацияОбОшибке.Причина.Описание;
			КонецЕсли;
			
			Сообщение.Сообщить();
			
			Возврат;
			
		КонецПопытки;
		
		Если СтандартнаяОбработка Тогда
			
			Если ЭтоСтартоваяФорма Тогда
				
				// Сначала попробуем найти его среди открытых стартовых форм.
				// Необходимо для предотвращения открытия нескольких стартовых форм одного отчета.
				НайденоОкно = Ложь;
				
				РегламентированнаяОтчетностьКлиент.ВебКлиентНайтиАктивизироватьОкно(ИмяФормыОтчета, ЭтаФорма, НайденоОкно);
				
				Если НайденоОкно <> Неопределено Тогда
					Если НайденоОкно Тогда
						
						Возврат;
						
					КонецЕсли;
				КонецЕсли;
				
				Если ВладелецФормы <> Неопределено Тогда
					
					ФормаОтчета.ВладелецФормы = ВладелецФормы;
					ВладелецФормы.Активизировать();
					
				КонецЕсли;
				
				ФормаОтчета.РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
				
			КонецЕсли;
			
			ФормаОтчета.ЗакрыватьПриЗакрытииВладельца = Ложь;
			
			ФормаОтчета.Открыть();
			
		КонецЕсли;
		
		Если НЕ ЭтоСтартоваяФорма Тогда
			
			Если (Объект.ИсточникОтчета = "РегламентированныйОтчетБухОтчетность"
					   И ВыбраннаяФорма = "ФормаОтчета2011Кв4")
			 ИЛИ (Объект.ИсточникОтчета = "РегламентированныйОтчетБухОтчетностьМП"
					   И ВыбраннаяФорма = "ФормаОтчета2012Кв4_2")
			 ИЛИ (Объект.ИсточникОтчета = "РегламентированныйОтчетБухОтчетностьСОНКО"
					   И ВыбраннаяФорма = "ФормаОтчета2012Кв4") Тогда
				
				ФормаОтчета.ОткрытьУведомление();
				
			КонецЕсли;
			
		КонецЕсли;
		
	Иначе
		
		ОткрытьФорму("Справочник.РегламентированныеОтчеты.Форма.ФормаСписка");
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти