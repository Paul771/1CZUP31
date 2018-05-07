
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры, "Заголовок,ФизическоеЛицоСсылка");
	ЗначениеВРеквизитФормы(СотрудникиФормы.ФизическоеЛицоФормыСотрудника(ФизическоеЛицоСсылка), "ФизическоеЛицо");
	
	СозданиеНового = Параметры.СозданиеНового И НЕ ЗначениеЗаполнено(ФизическоеЛицо.Ссылка);
	
	СотрудникиФормы.ПрочитатьДанныеИзХранилищаВФорму(
		ЭтотОбъект,
		СотрудникиКлиентСервер.ОписаниеДополнительнойФормы(ИмяФормы),
		Параметры.АдресВХранилище);
	
	ЦветСтиляПоясняющийТекст		= ЦветаСтиля.ПоясняющийТекст;
	ЦветСтиляПоясняющийОшибкуТекст 	= ЦветаСтиля.ПоясняющийОшибкуТекст;
	ЦветСтиляЦветТекстаПоля 		= ЦветаСтиля.ЦветТекстаПоля;
	
	ПроинициализироватьФорму();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	СотрудникиКлиент.ЗарегистрироватьОткрытиеФормы(ЭтотОбъект, "ЛичныеДанные");
	СотрудникиКлиент.ПроверитьРежимТолькоПросмотраДополнительнойФормы(ЭтотОбъект, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	СотрудникиКлиент.ОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	
	Если ИмяСобытия = "ОтредактированаИстория" И ФизическоеЛицоСсылка = Источник Тогда
		Если Параметр.ИмяРегистра = "ГражданствоФизическихЛиц" Тогда
			Если ГражданствоФизическихЛицНаборЗаписейПрочитан Тогда
				РедактированиеПериодическихСведенийКлиент.ОбработкаОповещения(
					ЭтотОбъект,
					ФизическоеЛицоСсылка,
					ИмяСобытия,
					Параметр,
					Источник);
					
				Если ЗначениеЗаполнено(ГражданствоФизическихЛиц.Страна) Тогда
					ГражданствоФизическихЛицЛицоБезГражданства = 0;
				Иначе
					ГражданствоФизическихЛицЛицоБезГражданства = 1;
				КонецЕсли;
				
				СотрудникиКлиентСервер.ОбновитьДоступностьПолейВводаГражданства(ЭтотОбъект, ОбщегоНазначенияКлиент.ДатаСеанса());
				
			КонецЕсли;
		ИначеЕсли Параметр.ИмяРегистра = "ДокументыФизическихЛиц" Тогда
			Если ДокументыФизическихЛицНаборЗаписейПрочитан Тогда
				СотрудникиКлиентБазовый.ОбработкаОповещенияОтредактированаИсторияДокументыФизическихЛиц(
					ЭтотОбъект,
					ФизическоеЛицоСсылка,
					ИмяСобытия,
					Параметр,
					Источник);
				СотрудникиКлиентСервер.ОбработатьОтображениеСерияДокументаФизическогоЛица(ДокументыФизическихЛиц.ВидДокумента, ДокументыФизическихЛиц.Серия ,Элементы.ДокументыФизическихЛицСерия, ЭтотОбъект);
				СотрудникиКлиентСервер.ОбработатьОтображениеНомерДокументаФизическогоЛица(ДокументыФизическихЛиц.ВидДокумента, ДокументыФизическихЛиц.Номер ,Элементы.ДокументыФизическихЛицНомер, ЭтотОбъект);
				СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтотОбъект);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИЗакрыть", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	СотрудникиФормы.ПроверитьСведенияОГражданствеИДокументеУдостоверяющемЛичность(ЭтотОбъект, Отказ);
		
	// СтандартныеПодсистемы.КонтактнаяИнформация
	УправлениеКонтактнойИнформацией.ОбработкаПроверкиЗаполненияНаСервере(ЭтотОбъект, ФизическоеЛицо, Отказ);
	// Конец СтандартныеПодсистемы.КонтактнаяИнформация
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриИзменении(Элемент)

	Если НЕ СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы) Тогда
		Возврат;
	КонецЕсли;
	
	МодульУправлениеКонтактнойИнформациейКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	
	МодульУправлениеКонтактнойИнформациейКлиент.ПриИзменении(ЭтотОбъект, Элемент);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияПриНажатии(Элемент, СтандартнаяОбработка)

	Если НЕ СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы) Тогда
		Возврат;
	КонецЕсли;
	
	МодульУправлениеКонтактнойИнформациейКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	
	МодульУправлениеКонтактнойИнформациейКлиент.НачалоВыбора(ЭтотОбъект, Элемент, , СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	Если НЕ СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы) Тогда
		Возврат;
	КонецЕсли;
	
	МодульУправлениеКонтактнойИнформациейКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	
	МодульУправлениеКонтактнойИнформациейКлиент.НачалоВыбора(
		ЭтотОбъект, Элемент, , СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияОчистка(Элемент, СтандартнаяОбработка)
	
	Если НЕ СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы) Тогда
		Возврат;
	КонецЕсли;
	
	МодульУправлениеКонтактнойИнформациейКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	
	МодульУправлениеКонтактнойИнформациейКлиент.Очистка(
		ЭтотОбъект, Элемент.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_КонтактнаяИнформацияВыполнитьКоманду(Команда)
	
	Если НЕ СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы) Тогда
		Возврат;
	КонецЕсли;
	
	МодульУправлениеКонтактнойИнформациейКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("УправлениеКонтактнойИнформациейКлиент");
	
	МодульУправлениеКонтактнойИнформациейКлиент.ВыполнитьКоманду(
		ЭтотОбъект, Команда.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ФизлицоДатаРегистрацииПриИзменении(Элемент)
	
	СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицЛицоБезГражданстваПриИзменении(Элемент)
	
	Если Не ГражданствоФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	Если ГражданствоФизическихЛицЛицоБезГражданства = 0 Тогда
		
		Если НЕ ЗначениеЗаполнено(ГражданствоФизическихЛиц.Страна)
			И ЗначениеЗаполнено(ГражданствоФизическихЛицПрежняя.Страна) Тогда
		КонецЕсли;
		
		ГражданствоФизическихЛиц.Страна = ГражданствоФизическихЛицПрежняя.Страна;
		Если НЕ ЗначениеЗаполнено(ГражданствоФизическихЛиц.Страна) Тогда
			ГражданствоФизическихЛиц.Страна = ПредопределенноеЗначение("Справочник.СтраныМира.Россия");
		КонецЕсли; 
		
	Иначе
		
		ГражданствоФизическихЛиц.Страна = ПредопределенноеЗначение("Справочник.СтраныМира.ПустаяСсылка");
		
	КонецЕсли;
	
	СотрудникиКлиентСервер.ОбновитьДоступностьПолейВводаГражданства(ЭтотОбъект, ОбщегоНазначенияКлиент.ДатаСеанса());
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицСтранаПриИзменении(Элемент)
	
	Если Не ГражданствоФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиентСервер.ОбновитьДоступностьПолейВводаГражданства(ЭтотОбъект, ОбщегоНазначенияКлиент.ДатаСеанса());
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицСтранаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ГражданствоФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицПериодПриИзменении(Элемент)
	
	Если Не ГражданствоФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	ГражданствоФизическихЛиц.Период = ГражданствоФизическихЛицПериод;
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицПериодНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ГражданствоФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицСтранаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	УправлениеКонтактнойИнформациейКлиент.СтранаМираОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ГражданствоФизическихЛицИННПриИзменении(Элемент)
	
	Если Не ГражданствоФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиентСервер.ОбновитьДоступностьПолейВводаГражданства(ЭтотОбъект, ОбщегоНазначенияКлиент.ДатаСеанса());
	
КонецПроцедуры

#Область ПриИзмененииДанныхФизлицаСотрудника

&НаКлиенте
Процедура ФизлицоМестоРожденияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ЗаблокироватьОбъектВФормеВладельце() Тогда
		
		СтандартнаяОбработка = Ложь;
		ФизическоеЛицо.МестоРождения = ФизическоеЛицоМестоРожденияПрежнее;
		Возврат;
		
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ФизлицоМестоРожденияНачалоВыбораЗавершение", ЭтотОбъект);
	СотрудникиКлиент.ФизическиеЛицаМестоРожденияНачалоВыбора(ЭтотОбъект, Элемент, СтандартнаяОбработка, ФизическоеЛицо.МестоРождения, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ФизлицоМестоРожденияНачалоВыбораЗавершение(МестоРожденияИзменено, ДополнительныеПараметры) Экспорт 
	
	СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ФизлицоМестоРожденияПриИзменении(Элемент)
	
	Если Не ЗаблокироватьОбъектВФормеВладельце() Тогда
		ФизическоеЛицо.МестоРождения = ФизическоеЛицоМестоРожденияПрежнее;
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиент.ЗаблокироватьФизическоеЛицоПриРедактировании(ВладелецФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицВидДокументаПриИзменении(Элемент)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиент.ДокументыФизическихЛицВидДокументаПриИзменении(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицСерияПриИзменении(Элемент)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиент.ДокументыФизическихЛицСерияПриИзменении(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицНомерПриИзменении(Элемент)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиент.ДокументыФизическихЛицНомерПриИзменении(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицВидДокументаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		СтандартнаяОбработка = Ложь;
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиент.ДокументыФизическихЛицВидДокументаНачалоВыбора(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицДатаВыдачиПриИзменении(Элемент)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицДатаВыдачиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицСрокДействияПриИзменении(Элемент)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицСрокДействияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицКемВыданПриИзменении(Элемент)
	
	СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицКодПодразделенияПриИзменении(Элемент)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
	СотрудникиКлиентСервер.ОбновитьПолеУдостоверениеЛичностиПериод(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицПериодПриИзменении(Элемент)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицПериодНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Если Не ДокументыФизическихЛицЗаблокироватьФизическоеЛицо() Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ГражданствоФизическихЛицИстория(Команда)

	СотрудникиКлиент.ОткрытьФормуРедактированияИстории("ГражданствоФизическихЛиц", ФизическоеЛицоСсылка, ЭтотОбъект);

КонецПроцедуры

&НаКлиенте
Процедура ВсеДокументыЭтогоЧеловека(Команда)
	
	СотрудникиКлиент.ОткрытьСписокВсехДокументовФизическогоЛица(ЭтотОбъект, ФизическоеЛицоСсылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ДокументыФизическихЛицИстория(Команда)
	
	СотрудникиКлиент.ОткрытьФормуРедактированияИстории("ДокументыФизическихЛиц", ФизическоеЛицоСсылка, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Ок(Команда)
	
	СохранитьИЗакрытьНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Модифицированность = Ложь;
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура СохранитьДанные(Отказ, ОповещениеЗавершения = Неопределено)
	
	ОчиститьСообщения();
	
	Если Не Модифицированность Тогда
		Если ОповещениеЗавершения <> Неопределено Тогда 
			ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Отказ);
		КонецЕсли;
		Возврат;
	КонецЕсли; 
		
	Если Не СозданиеНового И Не Отказ Тогда
		Оповещение = Новый ОписаниеОповещения("СохранитьДанныеУдостоверениеЛичности", ЭтотОбъект, ОповещениеЗавершения);
		СотрудникиКлиент.ЗапроситьРежимИзмененияГражданства(ЭтотОбъект, ГражданствоФизическихЛиц.Период, Отказ, Оповещение);
	Иначе 
		СохранитьДанныеУдостоверениеЛичности(Отказ, ОповещениеЗавершения);
	КонецЕсли; 
			
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДанныеУдостоверениеЛичности(Отказ, ОповещениеЗавершения) Экспорт 
	
	Если Отказ Тогда
		Если ОповещениеЗавершения <> Неопределено Тогда 
			ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Отказ);
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("СохранитьДанныеЗавершение", ЭтотОбъект, ОповещениеЗавершения);
	СотрудникиКлиент.ЗапроситьРежимИзмененияУдостоверенияЛичности(ЭтотОбъект, ДокументыФизическихЛиц.Период, Отказ, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДанныеЗавершение(Отказ, ОповещениеЗавершения) Экспорт

	Если Не Отказ Тогда
		
		Если ПроверитьЗаполнение() Тогда
			
			ЗапомнитьКонтактнуюИнформацию();
			
			ВозвращаемыйПараметр = Новый Структура;
			ВозвращаемыйПараметр.Вставить("ИмяФормы", ИмяФормы);
			ВозвращаемыйПараметр.Вставить("АдресВХранилище", АдресДанныхДополнительнойФормыНаСервере(СотрудникиКлиентСервер.ОписаниеДополнительнойФормы(ИмяФормы)));
			
			Оповестить(
			"ИзмененыДанныеДополнительнойФормы",
			ВозвращаемыйПараметр,
			ВладелецФормы);
			
		Иначе
			Отказ = Истина;
		КонецЕсли;
		
	КонецЕсли; 
	
	Если ОповещениеЗавершения <> Неопределено Тогда 
		ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИЗакрыть(Результат, ДополнительныеПараметры) Экспорт 
	
	СохранитьИЗакрытьНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИЗакрытьНаКлиенте(ЗакрытьФорму = Истина) Экспорт 

	Если НЕ ТолькоПросмотр Тогда
		ТекущийЭлемент = Элементы.ФормаОк;
	КонецЕсли; 
	
	ДополнительныеПараметры = Новый Структура("ЗакрытьФорму", ЗакрытьФорму);
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИЗакрытьНаКлиентеЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	СохранитьДанные(Ложь, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИЗакрытьНаКлиентеЗавершение(Отказ, ДополнительныеПараметры) Экспорт 

	Если Не Отказ И Открыта() Тогда
		
		Модифицированность = Ложь;
		Если ДополнительныеПараметры.ЗакрытьФорму Тогда
			Закрыть();
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Функция Подключаемый_ОбновитьКонтактнуюИнформацию(Результат)
	
	РезультатОбновления = УправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, ФизическоеЛицо, Результат);
	УправлениеКонтактнойИнформациейЗарплатаКадры.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Результат, СотрудникиКлиентСервер.ЗависимостиВидовАдресов());
	
	Возврат РезультатОбновления;
	
КонецФункции

&НаСервере
Процедура ПроинициализироватьФорму()
	
	ФизическоеЛицоМестоРожденияПрежнее = ФизическоеЛицо.МестоРождения;
	
	ДоступенПросмотрДанныхФизическихЛиц = Пользователи.РолиДоступны("ЧтениеДанныхФизическихЛицЗарплатаКадры,ДобавлениеИзменениеДанныхФизическихЛицЗарплатаКадры");
	
	Если ДоступенПросмотрДанныхФизическихЛиц Тогда
		
		Если ГражданствоФизическихЛицПрежняя = Неопределено Тогда
			
			Если СозданиеНового Тогда
				
				РедактированиеПериодическихСведений.ИнициализироватьЗаписьДляРедактированияВФорме(
					ЭтотОбъект, "ГражданствоФизическихЛиц", ФизическоеЛицоСсылка);
				
			Иначе
				
				РедактированиеПериодическихСведений.ПрочитатьЗаписьДляРедактированияВФорме(
					ЭтотОбъект,
					"ГражданствоФизическихЛиц",
					ФизическоеЛицоСсылка);
				
			КонецЕсли;
			
		КонецЕсли; 
			
		Если ЗначениеЗаполнено(ГражданствоФизическихЛиц.Страна) Тогда
			ГражданствоФизическихЛицЛицоБезГражданства = 0;
		Иначе
			ГражданствоФизическихЛицЛицоБезГражданства = 1;
		КонецЕсли;
		
	КонецЕсли;
	
	УправлениеКонтактнойИнформациейЗарплатаКадры.ПриСозданииНаСервере(ЭтотОбъект, ФизическоеЛицо, "ГруппаКонтактнаяИнформация");
	УправлениеКонтактнойИнформациейЗарплатаКадры.ОбновитьОтображениеПредупреждающихНадписейКонтактнойИнформации(ЭтотОбъект);
	
	ПравоИзменения = ПравоДоступа("Изменение", Метаданные.Справочники.ФизическиеЛица);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ГруппаКонтактнаяИнформация",
		"ТолькоПросмотр",
		Не ПравоИзменения);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ГруппаДействийКонтактнойИнформации",
		"Доступность",
		ПравоИзменения);
	
	СотрудникиФормы.ОбновитьОтображениеЛичныхДанных(ЭтотОбъект);
	
	СотрудникиФормы.ОбновитьОтображениеПредупреждающихНадписей(ЭтотОбъект);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ВсеДокументыЭтогоЧеловека",
		"Видимость",
		Не СозданиеНового);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНаборЗаписейПериодическихСведений(ИмяРегистра, ВедущийОбъект) Экспорт
	
	РедактированиеПериодическихСведений.ПрочитатьНаборЗаписей(ЭтотОбъект, ИмяРегистра, ВедущийОбъект);
	
КонецПроцедуры

&НаСервере
Функция АдресДанныхДополнительнойФормыНаСервере(ОписаниеДополнительнойФормы)
	
	Возврат СотрудникиФормы.АдресДанныхДополнительнойФормы(ОписаниеДополнительнойФормы, ЭтотОбъект);
	
КонецФункции

&НаСервере
Процедура ЗапомнитьКонтактнуюИнформацию()

	// Обработчик подсистемы "Контактная информация".
	УправлениеКонтактнойИнформацией.ПередЗаписьюНаСервере(ЭтотОбъект, ФизическоеЛицо);

КонецПроцедуры

&НаКлиенте
Функция ГражданствоФизическихЛицЗаблокироватьФизическоеЛицо()
	
	Если Не ЗаблокироватьОбъектВФормеВладельце() Тогда
		
		ЗаполнитьЗначенияСвойств(ГражданствоФизическихЛиц, ГражданствоФизическихЛицПрежняя);
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Функция ДокументыФизическихЛицЗаблокироватьФизическоеЛицо()
	
	Если Не ЗаблокироватьОбъектВФормеВладельце() Тогда
		
		ЗаполнитьЗначенияСвойств(ДокументыФизическихЛиц, ДокументыФизическихЛицПрежняя);
		Возврат Ложь;
		
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Функция ЗаблокироватьОбъектВФормеВладельце() Экспорт
	
	Возврат СотрудникиКлиент.ЗаблокироватьОбъектВФормеВладельцеДополнительнойФормы(ЭтотОбъект, Истина);
	
КонецФункции

#КонецОбласти
