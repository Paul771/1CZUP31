
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Начисления, "ПредставлениеТипаДоначислениеПерерасчет", Документы.НачислениеЗарплаты.ПредставлениеТипаДоначислениеПерерасчет());
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка( 
		Начисления, "ПредставлениеТипаРасчетЗарплаты", Метаданные.Документы.НачислениеЗарплаты.Синоним);
	
	НастройкаВидВсеСотрудники = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("СписокСотрудников", "ВидВсеСотрудники");
	ВидВсеСотрудники = ?(НастройкаВидВсеСотрудники = Неопределено, Истина, НастройкаВидВсеСотрудники);
	
	ПоказыватьСотрудниковПодчиненныхПодразделений = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("СписокСотрудников", "ПоказыватьСотрудниковПодчиненныхПодразделений");
	Если ПоказыватьСотрудниковПодчиненныхПодразделений <> Неопределено Тогда
		Элементы.ПодразделенияКонтекстноеМенюПоказыватьСотрудниковПодчиненныхПодразделений.Пометка = ПоказыватьСотрудниковПодчиненныхПодразделений;
	КонецЕсли;
	
	ЗначенияДляЗаполнения  = Новый Структура("Организация", "Организация");
	ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
	
	Если НЕ ЗначениеЗаполнено(Организация) Тогда
		Организация = ЗарплатаКадры.ПерваяДоступнаяОрганизация();
	КонецЕсли;
	
	УстановитьВидСпискаСотрудников(ЭтаФорма);
	УстановитьДанныеПоОрганизации(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзменениеДанныхМестаРаботы"
		Или ИмяСобытия = "ДокументДоговорРаботыУслугиПослеЗаписи"
		Или ИмяСобытия = "ДокументДоговорАвторскогоЗаказаПослеЗаписи"
		Или ИмяСобытия = "ДокументНачальнаяШтатнаяРасстановкаПослеЗаписи" Тогда
		
		ПодключитьОбработчикОжидания("ОбновитьСписокСотрудников",
			ЗарплатаКадрыРасширенныйКлиент.ПериодОжиданияЗапускаАвтоматическогоРасчета(), Истина);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ОрганизацияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПодразделенияПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("УстановитьОтборПоПодразделениюНаКлиенте", 0.1, Истина);
	
КонецПроцедуры

&НаСервере
Процедура СписокСотрудниковПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	ОбновитьНастройкиФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Начислить(Команда)
	
	Если День(ТекущаяРабочаяДата) < 10 Тогда
		ТекущийМесяц = ДобавитьМесяц(НачалоМесяца(ТекущаяРабочаяДата), -1);
	Иначе
		ТекущийМесяц = НачалоМесяца(ТекущаяРабочаяДата);
	КонецЕсли;
	
	ПараметрыФормы = ПараметрыОткрытияФорм();
	ПараметрыФормы.ЗначенияЗаполнения.Вставить("МесяцНачисления", ТекущийМесяц);
	
	ОткрытьФорму("Документ.НачислениеЗарплаты.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ВсеСотрудники(Команда)
	
	ВидВсеСотрудники = Истина;
	УстановитьВидСпискаСотрудников(ЭтаФорма);
	УстановитьОтборПоПодразделению(ЭтаФорма);
	
	ПодключитьОбработчикОжидания("ПриИзмененииСохраняемойНастройки", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиПоПодразделениям(Команда)
	
	ВидВсеСотрудники = Ложь;
	УстановитьВидСпискаСотрудников(ЭтаФорма);
	УстановитьОтборПоПодразделению(ЭтаФорма);
	
	ПодключитьОбработчикОжидания("ПриИзмененииСохраняемойНастройки", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ШтатноеРасписание(Команда)
	
	ПараметрыФормы = Новый Структура;
	Если ЗначениеЗаполнено(Организация) Тогда
		СтруктураОтбор = Новый Структура("Владелец", Организация);
		ПараметрыФормы.Вставить("Отбор", СтруктураОтбор);
	КонецЕсли;
	
	ОткрытьФорму("Справочник.ШтатноеРасписание.ФормаСписка", ПараметрыФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьСотрудниковПодчиненныхПодразделений(Команда)
	
	Элементы.ПодразделенияКонтекстноеМенюПоказыватьСотрудниковПодчиненныхПодразделений.Пометка =
		Не Элементы.ПодразделенияКонтекстноеМенюПоказыватьСотрудниковПодчиненныхПодразделений.Пометка;
	
	УстановитьОтборПоПодразделению(ЭтаФорма);
	СохранитьНастройкиПоказыватьСотрудниковПодчиненныхПодразделений();
	
КонецПроцедуры

&НаКлиенте
Процедура УпорядочитьПоВажностиЗанимаемойДолжности(Команда)
	
	УстановитьНастройкиУпорядочиванияСотрудников();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСотрудников(Команда)
	
	ОбновитьСотрудниковНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборПоДате()
	
	ТекущаяРабочаяДата = ОбщегоНазначения.ТекущаяДатаПользователя();
	
	ДатаОкончания = КонецДня(ТекущаяРабочаяДата);
	ДатаНачала = НачалоДня(ДатаОкончания);
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Сотрудники, "ДатаНачала", '00010101', Истина);
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Сотрудники, "ДатаНачалаСведений", ДатаНачала, Истина);
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Сотрудники, "ДатаОкончания", ДатаОкончания, Истина);
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(
		Подразделения, "ДатаОкончания", ДатаОкончания, Истина);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция КоллекцияЭлементовПорядкаСпискаСотрудники(Форма)
	
	Сотрудники = Форма.Сотрудники;
	
	КоллекцияЭлементовПорядка = Неопределено;
	Для Каждого КоллекцияЭлементовНастроек Из Сотрудники.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы Цикл
		
		Если ТипЗнч(КоллекцияЭлементовНастроек) = Тип("ПорядокКомпоновкиДанных") Тогда
			КоллекцияЭлементовПорядка = КоллекцияЭлементовНастроек;
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Если КоллекцияЭлементовПорядка = Неопределено Тогда
		КоллекцияЭлементовПорядка = Сотрудники.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Добавить();
	КонецЕсли;
	
	Возврат КоллекцияЭлементовПорядка;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПорядокПоВажностиУстановлен(Форма)
	
	КоллекцияЭлементовПорядка = КоллекцияЭлементовПорядкаСпискаСотрудники(Форма);
	
	ПорядокУстановлен = Ложь;
	Если КоллекцияЭлементовПорядка.Элементы.Количество() > 1 Тогда
		
		ПолеПодразделения = Новый ПолеКомпоновкиДанных("ПорядокПодразделения");
		ПолеДолжности = Новый ПолеКомпоновкиДанных("ПорядокДолжности");
		
		Если КоллекцияЭлементовПорядка.Элементы.Получить(0).Поле = ПолеПодразделения
			И КоллекцияЭлементовПорядка.Элементы.Получить(1).Поле = ПолеДолжности Тогда
			
			ПорядокУстановлен = Истина;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ПорядокУстановлен;
	
КонецФункции

&НаСервере
Процедура УстановитьНастройкиУпорядочиванияСотрудников()
	
	Элементы.СписокСотрудниковКонтекстноеМенюУпорядочитьПоВажностиЗанимаемойДолжности.Пометка
		= Не Элементы.СписокСотрудниковКонтекстноеМенюУпорядочитьПоВажностиЗанимаемойДолжности.Пометка;
	
	УстановитьСортировкуСписка();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСортировкуСписка()
	
	УстановитьСортировку = Элементы.СписокСотрудниковКонтекстноеМенюУпорядочитьПоВажностиЗанимаемойДолжности.Пометка;
	
	ПолеПодразделения = Новый ПолеКомпоновкиДанных("ПорядокПодразделения");
	ПолеДолжности = Новый ПолеКомпоновкиДанных("ПорядокДолжности");
	
	КоллекцияЭлементовПорядка = КоллекцияЭлементовПорядкаСпискаСотрудники(ЭтаФорма);
	СортировкаУстановлена = ПорядокПоВажностиУстановлен(ЭтаФорма);
	
	Если УстановитьСортировку Тогда
		
		Если СортировкаУстановлена Тогда
			
			КоллекцияЭлементовПорядка.Элементы.Получить(0).Использование = Истина;
			КоллекцияЭлементовПорядка.Элементы.Получить(1).Использование = Истина;
			
		Иначе
			
			ЭлементПорядка = КоллекцияЭлементовПорядка.Элементы.Вставить(0, Тип("ЭлементПорядкаКомпоновкиДанных"));
			ЭлементПорядка.Поле = ПолеДолжности;
			ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Обычный;
			
			ЭлементПорядка = КоллекцияЭлементовПорядка.Элементы.Вставить(0, Тип("ЭлементПорядкаКомпоновкиДанных"));
			ЭлементПорядка.Поле = ПолеПодразделения;
			ЭлементПорядка.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.БыстрыйДоступ;
			
		КонецЕсли;
		
	ИначеЕсли СортировкаУстановлена Тогда
		
		КоллекцияЭлементовПорядка.Элементы.Удалить(КоллекцияЭлементовПорядка.Элементы.Получить(0));
		КоллекцияЭлементовПорядка.Элементы.Удалить(КоллекцияЭлементовПорядка.Элементы.Получить(0));
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьНастройкиФормы()
	
	НастройкиСписка = СотрудникиФормыРасширенный.НастройкиСпискаФормы(ЭтаФорма, "Сотрудники");
	
	СотрудникиФормыРасширенный.ПрименитьНастройкиСписка(ЭтаФорма, НастройкиСписка, "Сотрудники", , Организация);
	ДополнительныеПараметры = СотрудникиФормыРасширенный.УстановитьЗапросДинамическогоСписка(ЭтаФорма, НастройкиСписка.ОтборыСписка, Истина, "Сотрудники");
	
	УстановитьОтборПоДате();
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"СписокСотрудниковКонтекстноеМенюУпорядочитьПоВажностиЗанимаемойДолжности",
		"Пометка",
		ПорядокПоВажностиУстановлен(ЭтаФорма));
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСписокСотрудников()
	
	Элементы.СписокСотрудников.Обновить();
	
КонецПроцедуры

&НаКлиенте
Функция ПараметрыОткрытияФорм()
	
	ЗначенияЗаполнения = Новый Структура;
	Если ЗначениеЗаполнено(Организация) Тогда
		ЗначенияЗаполнения.Вставить("Организация", Организация);
	КонецЕсли;
	ЗначенияЗаполнения.Вставить("ПериодРегистрации", НачалоМесяца(НачалоМесяца(ОбщегоНазначенияКлиент.ДатаСеанса()) - 1));
	
	Возврат Новый Структура("ЗначенияЗаполнения", ЗначенияЗаполнения);
	
КонецФункции

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("НастройкиПользователя", "Организация", Организация);
	УстановитьДанныеПоОрганизации();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДанныеПоОрганизации(ОбновитьНастройки = Истина)
	
	УстановитьОтборВСписках(ОбновитьНастройки);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборВСписках(ОбновитьНастройки)
	
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Сотрудники, "Подразделение");
	Если ЗначениеЗаполнено(Организация) Тогда
		
		ГоловнаяОрганизация = ЗарплатаКадрыПовтИсп.ГоловнаяОрганизация(Организация);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Сотрудники, "Организация", ГоловнаяОрганизация);
		
		УстановитьОтборПоФилиалу(ЭтаФорма, Организация);
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Начисления, "Организация", Организация);
		
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Сотрудники, "Организация");
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Сотрудники, "ОтборПоФилиалуИЛИ");
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Начисления, "Организация");
	КонецЕсли;
	
	Если ОбновитьНастройки Тогда
		ОбновитьНастройкиФормы();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборПоФилиалу(Форма, Филиал)
	
	Сотрудники = Форма.Сотрудники;
	
	УстановитьОтборПустогоФилиала = Ложь;
	ГруппаОтбораИли = ОбщегоНазначенияКлиентСервер.НайтиЭлементОтбораПоПредставлению(Сотрудники.Отбор.Элементы, "ОтборПоФилиалуИЛИ");
	Если ГруппаОтбораИли = Неопределено Тогда
		
		ГруппаОтбораИли = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(Сотрудники.Отбор.Элементы, "ОтборПоФилиалуИЛИ", ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
		УстановитьОтборПустогоФилиала = Истина;
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ГруппаОтбораИли, "Филиал", Филиал, ВидСравненияКомпоновкиДанных.Равно, "ОтборПоФилиалу");
		
	Иначе
		
		ОтборПоФилиалу = ОбщегоНазначенияКлиентСервер.НайтиЭлементОтбораПоПредставлению(ГруппаОтбораИли.Элементы, "ОтборПоФилиалу");
		ОтборПоФилиалу.ПравоеЗначение = Филиал;
		
	КонецЕсли;
	
	Если УстановитьОтборПустогоФилиала Тогда
		
		ГруппаОтбораПустогоФилиала = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(ГруппаОтбораИли, "ОтборПустогоФилиала", ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ГруппаОтбораПустогоФилиала, "Филиал", Филиал, ВидСравненияКомпоновкиДанных.НеЗаполнено, "ОтборНеПринятых");
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборПоПодразделению(Форма)
	
	Если Форма.Элементы.Подразделения.ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Форма.ВидВсеСотрудники Тогда
		
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(
			Форма.Сотрудники, "Подразделение");
		
		УстановитьОтборПоФилиалу(Форма, Форма.Организация);
		
	Иначе
		
		Если ТипЗнч(Форма.Элементы.Подразделения.ТекущаяСтрока) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			ОтборПоФилиалу = Форма.Элементы.Подразделения.ТекущаяСтрока.Ключ;
		ИначеЕсли ТипЗнч(Форма.Элементы.Подразделения.ТекущаяСтрока) = Тип("СправочникСсылка.ПодразделенияОрганизаций") Тогда
			
			#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
				ОтборПоФилиалу = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Форма.Элементы.Подразделения.ТекущаяСтрока, "Владелец");
			#Иначе
				
				Если Форма.Элементы.Подразделения.ТекущиеДанные <> Неопределено Тогда
					ОтборПоФилиалу = Форма.Элементы.Подразделения.ТекущиеДанные.Владелец;
				Иначе
					ОтборПоФилиалу = Неопределено;
				КонецЕсли;
				
			#КонецЕсли
			
		Иначе
			ОтборПоФилиалу = Неопределено;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ОтборПоФилиалу) Тогда
			УстановитьОтборПоФилиалу(Форма, ОтборПоФилиалу);
		Иначе
			УстановитьОтборПоФилиалу(Форма, Форма.Организация);
		КонецЕсли;
		
		Если ТипЗнч(Форма.Элементы.Подразделения.ТекущаяСтрока) <> Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			
			Если Форма.Элементы.ПодразделенияКонтекстноеМенюПоказыватьСотрудниковПодчиненныхПодразделений.Пометка Тогда
				ВидСравненияПоПодразделению = ВидСравненияКомпоновкиДанных.ВИерархии;
			Иначе
				ВидСравненияПоПодразделению = ВидСравненияКомпоновкиДанных.Равно;
			КонецЕсли;
			
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(
				Форма.Сотрудники.Отбор, "Подразделение", Форма.Элементы.Подразделения.ТекущаяСтрока, ВидСравненияПоПодразделению);
			
		Иначе
			ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Форма.Сотрудники.Отбор, "Подразделение");
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидСпискаСотрудников(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"Подразделения",
		"Видимость",
		Не Форма.ВидВсеСотрудники);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"СписокСотрудниковПодразделениеСписка",
		"Видимость",
		Форма.ВидВсеСотрудники);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ВсеСотрудники",
		"Пометка",
		Форма.ВидВсеСотрудники);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"СотрудникиПоПодразделениям",
		"Пометка",
		Не Форма.ВидВсеСотрудники);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииСохраняемойНастройки()
	
	Настройки = СохраняемыеНастройки();
	Настройки.ВидВсеСотрудники = ВидВсеСотрудники;
	СохранитьНастройкиНаСервере(Настройки);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция СохраняемыеНастройки()
	
	Настройки = Новый Структура("ВидВсеСотрудники");
	Возврат Настройки;
	
КонецФункции

&НаСервереБезКонтекста
Процедура СохранитьНастройкиНаСервере(Настройки)
	
	Для Каждого КлючИЗначение Из Настройки Цикл
		ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("СписокСотрудников", КлючИЗначение.Ключ, КлючИЗначение.Значение);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура СохранитьНастройкиПоказыватьСотрудниковПодчиненныхПодразделений()
	
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("СписокСотрудников", "ПоказыватьСотрудниковПодчиненныхПодразделений",
		Элементы.ПодразделенияКонтекстноеМенюПоказыватьСотрудниковПодчиненныхПодразделений.Пометка);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоПодразделениюНаКлиенте()
	
	УстановитьОтборПоПодразделениюНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоПодразделениюНаСервере()
	
	УстановитьОтборПоПодразделению(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСотрудниковНаСервере()
	
	УстановитьОтборПоДате();
	Элементы.СписокСотрудников.Обновить();
	
КонецПроцедуры

#КонецОбласти
