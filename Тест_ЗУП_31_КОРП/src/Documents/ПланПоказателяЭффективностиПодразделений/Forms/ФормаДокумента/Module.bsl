
#Область ОбработкаСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Ключ.Пустая() Тогда
		ЗначенияДляЗаполнения = Новый Структура("Ответственный, Месяц", "Объект.Ответственный", "Объект.Период");
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
		
		ПриПолученииДанныхНаСервере();
	КонецЕсли;
	
	// Обработчик подсистемы "ВерсионированиеОбъектов".
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	ПриПолученииДанныхНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриПолученииДанныхНаСервере();
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_ПланПоказателяЭффективностиПодразделений");
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПоказательПриИзменении(Элемент)
	УстановитьПараметрыВыбораПодразделений();
КонецПроцедуры

#Область МесяцСтрокой

&НаКлиенте
Процедура МесяцСтрокойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаНачалоВыбора(ЭтаФорма, ЭтаФорма, "Объект.Период", "МесяцСтрокой");
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойРегулирование(Элемент, Направление, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаРегулирование(ЭтаФорма, "Объект.Период", "МесяцСтрокой", Направление);
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойАвтоПодбор(Элемент, Текст, ДанныеВыбора, Ожидание, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаАвтоПодборТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка)
	ЗарплатаКадрыКлиент.ВводМесяцаОкончаниеВводаТекста(Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура МесяцСтрокойПриИзменении(Элемент)
	МесяцПриИзмененииНаКлиенте();
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьПоОтветственному(Команда)
	ЗаполнитьСписокПодразделенийПоОтветственномуНаСервере();
КонецПроцедуры

#Область ЗагрузкаДанныхИзФайла

&НаКлиенте
Процедура ЗагрузитьИзФайла(Команда)
	
	ПараметрыЗагрузки = ЗагрузкаДанныхИзФайлаКлиент.ПараметрыЗагрузкиДанных();
	ПараметрыЗагрузки.ПолноеИмяТабличнойЧасти = "ПланПоказателяЭффективностиПодразделений.Подразделения";
	ПараметрыЗагрузки.Заголовок = НСтр("ru = 'Загрузка плановых значений показателя подразделений из файла'");
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьПодразделенияИзФайлаЗавершение", ЭтотОбъект);
	ЗагрузкаДанныхИзФайлаКлиент.ПоказатьФормуЗагрузки(ПараметрыЗагрузки, Оповещение);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ЗагрузкаДанныхИзФайла

&НаКлиенте
Процедура ЗагрузитьПодразделенияИзФайлаЗавершение(АдресЗагруженныхДанных, ДополнительныеПараметры) Экспорт
	
	Если АдресЗагруженныхДанных = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ЗагрузитьПодразделенияИзФайлаНаСервере(АдресЗагруженныхДанных);
			
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьПодразделенияИзФайлаНаСервере(АдресЗагруженныхДанных)
	
	ДобавленыСтроки = Ложь;
	
	ЗагруженныеДанные = ПолучитьИзВременногоХранилища(АдресЗагруженныхДанных);
	Для Каждого СтрокаДанных Из ЗагруженныеДанные Цикл 
		
		Если Не ЗначениеЗаполнено(СтрокаДанных.Подразделение) Тогда 
			Продолжить;
		КонецЕсли;
		ЗаполнитьЗначенияСвойств(Объект.Подразделения.Добавить(), СтрокаДанных);
		
	    ДобавленыСтроки = Истина;
	КонецЦикла;
	
	Модифицированность = Модифицированность ИЛИ ДобавленыСтроки;
		
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура ПриПолученииДанныхНаСервере()
	
	ЗаполнитьВторичныеРеквизитыФормы();
	
	УстановитьСвойстваЭлементовФормы();

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичныеРеквизитыФормы()
	
	ЗарплатаКадрыКлиентСервер.ЗаполнитьМесяцПоДате(ЭтаФорма, "Объект.Период", "МесяцСтрокой");
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСвойстваЭлементовФормы()
	
	УстановитьПараметрыВыбораПодразделений();
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцПриИзмененииНаКлиенте()
	МесяцПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура МесяцПриИзмененииНаСервере()
	УстановитьПараметрыВыбораПодразделений();
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыВыбораПодразделений()

	КоллекцияОтборов = КоллекцияОтборов();
	
	ТаблицаПодразделений = КлючевыеПоказателиЭффективности.ТаблицаПодразделенийПоПоказателю(Объект.Период, Объект.Показатель, КоллекцияОтборов);
	МассивПодразделений = ТаблицаПодразделений.ВыгрузитьКолонку("Подразделение");
	
	КлючевыеПоказателиЭффективностиФормы.УстановитьПараметрыВыбораПодразделениям(Элементы.ПодразделенияПодразделение, МассивПодразделений);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокПодразделенийПоОтветственномуНаСервере()

	КоллекцияОтборов = КоллекцияОтборов();
	ЗарплатаКадрыОбщиеНаборыДанных.ДобавитьВКоллекциюОтбор(
		КоллекцияОтборов, "ОтветственныйЗаВводПлана", "=", Объект.Ответственный);
		
	ТаблицаПодразделенийОтветственного = КлючевыеПоказателиЭффективности.ТаблицаПодразделенийПоПоказателю(Объект.Период, Объект.Показатель, КоллекцияОтборов);
	
	Объект.Подразделения.Очистить();
	Для каждого СтрокаПодразделения Из ТаблицаПодразделенийОтветственного Цикл
		ЗаполнитьЗначенияСвойств(Объект.Подразделения.Добавить(), СтрокаПодразделения);
	КонецЦикла; 

КонецПроцедуры

&НаСервере
Функция КоллекцияОтборов()

	КоллекцияОтборов = Новый Массив;
	
	ЗарплатаКадрыОбщиеНаборыДанных.ДобавитьВКоллекциюОтбор(
		КоллекцияОтборов, "Показатель.ТребуетсяВводПлана", "=", Истина);

	Возврат КоллекцияОтборов;
		
КонецФункции

#КонецОбласти
