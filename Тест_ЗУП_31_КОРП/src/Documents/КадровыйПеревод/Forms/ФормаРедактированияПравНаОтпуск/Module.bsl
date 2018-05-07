
#Область ОбработкаСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры,, "ЕжегодныеОтпуска, ЗакрыватьПриВыборе, ЗакрыватьПриЗакрытииВладельца, ТолькоПросмотр");
	
	Для каждого СтрокаЕжегодныеОтпуска Из Параметры.ЕжегодныеОтпуска Цикл
		ЗаполнитьЗначенияСвойств(ЕжегодныеОтпуска.Добавить(), СтрокаЕжегодныеОтпуска);
	КонецЦикла;
	
	ПараметрыСтажевыхЭлементов = ОстаткиОтпусков.ПараметрыДляДополнитьТабличнуюЧастьСтажевымиЭлементами();
	ПараметрыСтажевыхЭлементов.Форма = ЭтаФорма;
	ПараметрыСтажевыхЭлементов.ИмяТаблицы = "ЕжегодныеОтпуска";
	ПараметрыСтажевыхЭлементов.ТабличнаяЧастьВОбъекте = Ложь;
	ПараметрыСтажевыхЭлементов.ЗаполнятьРеквизитыПоСотруднику = Истина;
	ПараметрыСтажевыхЭлементов.Сотрудник = Сотрудник;
	ПараметрыСтажевыхЭлементов.ДатаСреза = ДатаСобытия;
	ОстаткиОтпусков.ДополнитьТабличнуюЧастьСтажевымиЭлементами(ПараметрыСтажевыхЭлементов);
	
	ОстаткиОтпусков.УстановитьУсловноеОформлениеЕжегодныхОтпусков(ЭтаФорма);
		
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененСтажФизическогоЛица" И Источник.ВладелецФормы = ЭтаФорма Тогда
		
		ОбновитьЗначенияСтажей();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ОбработкаСобытийЭлементовФормы

&НаКлиенте
Процедура ЕжегодныеОтпускаПриАктивизацииСтроки(Элемент)
	
	ОстаткиОтпусковКлиент.ПриАктивизацииСтрокиЕжегодногоОтпуска(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ЕжегодныеОтпускаПередУдалением(Элемент, Отказ)
	
	ОстаткиОтпусковКлиент.ПередУдалениемЕжегодногоОтпуска(ЭтаФорма, Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ЕжегодныеОтпускаПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	ОстаткиОтпусковКлиент.ПриНачалеРедактированияЕжегодногоОтпуска(ЭтаФорма, Элементы.ЕжегодныеОтпуска.ТекущиеДанные, НоваяСтрока);
КонецПроцедуры

&НаКлиенте
Процедура ЕжегодныеОтпускаПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	ОстаткиОтпусковКлиент.ПриОкончанииРедактированияЕжегодногоОтпуска(Элемент.ТекущиеДанные, НоваяСтрока);
	
КонецПроцедуры

&НаКлиенте
Процедура ЕжегодныеОтпускаВидЕжегодногоОтпускаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ЕжегодныеОтпуска.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	КоличествоДнейВГод = КоличествоДнейЕжегодногоОтпускаПоУмолчанию(ТекущиеДанные.ВидЕжегодногоОтпуска);
	Если КоличествоДнейВГод <> Неопределено Тогда
		ТекущиеДанные.КоличествоДнейВГод = КоличествоДнейВГод;
	КонецЕсли;
	
	ОстаткиОтпусковКлиентСервер.УстановитьКомментарииДействийСЕжегоднымОтпуском(Элементы.ЕжегодныеОтпуска.ТекущиеДанные);
	ЗаполнитьЗначенияСтажевыхРеквизитовВСтроке(Сотрудник, ТекущиеДанные.ПолучитьИдентификатор());
	
КонецПроцедуры

&НаКлиенте
Процедура ЕжегодныеОтпускаКоличествоДнейВГодПриИзменении(Элемент)
	ОстаткиОтпусковКлиент.ПриИзмененииЕжегодныеОтпускаКоличество(ЭтаФорма, Элементы.ЕжегодныеОтпуска.ТекущиеДанные, "ДействующийОтпуск");
КонецПроцедуры

#КонецОбласти


#Область ОбработкаКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Если Модифицированность Тогда
		
		Если НЕ ПроверитьЗаполнениеОтпусков() Тогда
			Возврат;
		КонецЕсли; 
		
		СтруктураПараметраОповещения = Новый Структура;
		СтруктураПараметраОповещения.Вставить("ЕжегодныеОтпуска", ЕжегодныеОтпуска);
		
		Оповестить("ИзмененыЕжегодныеОтпуска", СтруктураПараметраОповещения, ВладелецФормы);
		
	КонецЕсли;
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоПозиции(Команда)
	
	Оповещение = Новый ОписаниеОповещения("ЗаполнитьЕжегодныеОтпускаПоПозицииЗавершение", ЭтотОбъект);
	ПроверитьВозможностьОчисткиТабличныхЧастей(ЭтаФорма, "ЕжегодныеОтпуска", Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ЕжегодныеОтпускаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.ЕжегодныеОтпуска.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Поле.Имя = "ЕжегодныеОтпускаОписаниеСтажевыхПоказателей" Тогда
		
		ОстаткиОтпусковКлиент.ОткрытьФормуРедактированияСтажаОтпускаСотрудника(
			ЭтаФорма, Сотрудник, ДатаСобытия, ТекущиеДанные.ВидЕжегодногоОтпуска);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ПроверитьЗаполнениеОтпусков()
	
	Отказ = Ложь;
	Для каждого СтрокаОтпуска Из ЕжегодныеОтпуска Цикл
		
		ПутьКДанным = "ЕжегодныеОтпуска[" + ЕжегодныеОтпуска.Индекс(СтрокаОтпуска) + "].";
		
		Если НЕ ЗначениеЗаполнено(СтрокаОтпуска.ВидЕжегодногоОтпуска) Тогда
			ТекстСообщения = НСтр("ru='Не заполнен вид ежегодного отпуска'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , ПутьКДанным + "ВидЕжегодногоОтпуска", , Отказ);
		КонецЕсли; 
		
		Если НЕ ЗначениеЗаполнено(СтрокаОтпуска.КоличествоДнейВГод) И НЕ СтрокаОтпуска.ОтпускЗависитОтСтажа Тогда
			ТекстСообщения = НСтр("ru='Не заполнено количество дней в год'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , ПутьКДанным + "КоличествоДнейВГод", , Отказ);
		КонецЕсли; 
		
		ПараметрыОтбора = Новый Структура("ВидЕжегодногоОтпуска", СтрокаОтпуска.ВидЕжегодногоОтпуска);
		Если ЕжегодныеОтпуска.НайтиСтроки(ПараметрыОтбора).Количество() > 1 Тогда
			ТекстСообщения = НСтр("ru='Вид отпуска ""%1"" использован в нескольких строках'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, СтрокаОтпуска.ВидЕжегодногоОтпуска);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , ПутьКДанным + "ВидЕжегодногоОтпуска", , Отказ);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат НЕ Отказ;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьЕжегодныеОтпускаПоПозицииЗавершение(Отказ, ДополнительныеПараметры) Экспорт 
	
	Если Не Отказ Тогда
		ЗаполнитьЕжегодныеОтпускаПоПозицииНаСервере();
		Модифицированность = Истина;
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьЕжегодныеОтпускаПоПозицииНаСервере()
	
	ДанныеДокумента = ОстаткиОтпусков.ОписаниеПараметровДанныхКадровогоДокумента();
	ДанныеДокумента.Регистратор = Ссылка;
	ДанныеДокумента.Сотрудник = Сотрудник;
	ДанныеДокумента.ДатаСобытия = ДатаСобытия;
	
	ДанныеНовойПозиции = ОстаткиОтпусков.ОписаниеПараметровДанныхПозиции();
	ДанныеНовойПозиции.ДолжностьПоШтатномуРасписанию = ДолжностьПоШтатномуРасписанию;
	ДанныеНовойПозиции.Подразделение = Подразделение;
	ДанныеНовойПозиции.Территория = Территория;
	ДанныеНовойПозиции.Должность = Должность;
	
	ДанныеПрошлойПозиции = ОстаткиОтпусков.ОписаниеПараметровДанныхПозиции();
	ДанныеПрошлойПозиции.ДолжностьПоШтатномуРасписанию = ТекущаяДолжностьПоШтатномуРасписанию;
	ДанныеПрошлойПозиции.Подразделение = ТекущееПодразделение;
	ДанныеПрошлойПозиции.Должность = ТекущаяДолжность;
	ДанныеПрошлойПозиции.Территория = ТекущаяТерритория;
	
	ОстаткиОтпусков.ЗаполнитьПоложеннымиПравамиСотрудника(ЕжегодныеОтпуска, ДанныеДокумента, ДанныеНовойПозиции, ДанныеПрошлойПозиции);
		
	ОстаткиОтпусков.ЗаполнитьВторичныеРеквизитыСтажевыхОтпусков(ЭтаФорма.ЕжегодныеОтпуска, Сотрудник, ДатаСобытия);
		
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВозможностьОчисткиТабличныхЧастей(Форма, ТабличныеЧасти, ОповещениеЗавершения = Неопределено)
	
	СписокТабличныхЧастей = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ТабличныеЧасти);
	
	НеобходимоОчистить = Ложь;
	Для каждого ТабличнаяЧасть Из СписокТабличныхЧастей Цикл
		
		Если Форма[ТабличнаяЧасть].Количество() > 0 Тогда
			НеобходимоОчистить = Истина;
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ОповещениеЗавершения", ОповещениеЗавершения);
	
	Если НеобходимоОчистить Тогда
		
		Если СписокТабличныхЧастей.Количество() > 1 Тогда
			ТекстВопроса = НСтр("ru = 'Табличные части документа будут очищены. Продолжить?'");
		Иначе
			ТекстВопроса = НСтр("ru = 'Табличная часть документа будет очищена. Продолжить?'");
		КонецЕсли;
		
		Оповещение = Новый ОписаниеОповещения("ПроверитьВозможностьОчисткиТабличныхЧастейЗавершение",ЗарплатаКадрыРасширенныйКлиент, ДополнительныеПараметры);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		
	Иначе 
		
		ЗарплатаКадрыРасширенныйКлиент.ПроверитьВозможностьОчисткиТабличныхЧастейЗавершение(КодВозвратаДиалога.Да, ДополнительныеПараметры);
		
	КонецЕсли; 
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция КоличествоДнейЕжегодногоОтпускаПоУмолчанию(ВидЕжегодногоОтпуска)
	Возврат ОстаткиОтпусков.КоличествоДнейОтпускаВГодПоУмолчанию(ВидЕжегодногоОтпуска);
КонецФункции

&НаСервере
Процедура ЗаполнитьЗначенияСтажевыхРеквизитовВСтроке(Сотрудник, ИдентификаторСтроки)
	ТекущиеДанные = ЕжегодныеОтпуска.НайтиПоИдентификатору(ИдентификаторСтроки);
	ОстаткиОтпусков.ЗаполнитьЗначенияСтажевыхРеквизитовВСтроке(ТекущиеДанные, Сотрудник, ДатаСобытия);
КонецПроцедуры

&НаСервере
Процедура ОбновитьЗначенияСтажей()
	
	ОстаткиОтпусков.ЗаполнитьВторичныеРеквизитыСтажевыхОтпусков(ЭтаФорма.ЕжегодныеОтпуска, Сотрудник, ДатаСобытия);
	
КонецПроцедуры

#КонецОбласти
