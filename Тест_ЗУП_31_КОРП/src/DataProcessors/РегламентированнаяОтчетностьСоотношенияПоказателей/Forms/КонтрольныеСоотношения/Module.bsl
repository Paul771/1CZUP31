&НаКлиенте
Перем ТекущееПолеТабличногоДокументаКС;

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.РезультатПроверки = Неопределено Тогда
		ВызватьИсключение НСтр("ru='Обработка не предназначена для непосредственного использования.'");
	КонецЕсли;
	
	РезультатПроверки = Параметры.РезультатПроверки;
	ТекстДляЗаголовочнойЧасти = Параметры.ТекстДляЗаголовочнойЧасти;
	
	АдресСпискаРасшифровкиПоказателей = Неопределено;
	АдресСпискаРасшифровкиформулы = Неопределено;
	Если РезультатПроверки.Свойство("СписокРасшифровкиПоказателей") Тогда 
		АдресСпискаРасшифровкиПоказателей = РезультатПроверки.СписокРасшифровкиПоказателей;
	КонецЕсли;
	Если РезультатПроверки.Свойство("СписокРасшифровкиформулы") Тогда 
		АдресСпискаРасшифровкиформулы = РезультатПроверки.СписокРасшифровкиформулы;
	КонецЕсли;
	
	ПолеТабличногоДокументаКС.АвтоМасштаб = Истина;
	ПолеТабличногоДокументаКС.ОтображатьСетку = Ложь;
	ПолеТабличногоДокументаКС.ОтображатьЗаголовки = Ложь;
	ПолеТабличногоДокументаКС.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	
	Если НЕ РезультатПроверки = Неопределено
	   И РезультатПроверки.КоличествоНайденныхОшибок > 0 Тогда
		ОтобразитьТолькоОшибочныеКС = Истина;
	Иначе
		ОтобразитьТолькоОшибочныеКС = Ложь;
	КонецЕсли;
	
	ЭтоАвтопроверкаСтатистики = Параметры.Свойство("ЭтоАвтопроверкаСтатистики");
	
	ВывестиКонтрольныеСоотношения();
		
КонецПроцедуры

&НаКлиенте
Процедура ВывестиКонтрольныеСоотношенияКлиент()
	
	СкрытьРасшифровку();
	ВывестиКонтрольныеСоотношения();
	
КонецПроцедуры

&НаСервере
Процедура ВывестиКонтрольныеСоотношения()
	
	ПолеТабличногоДокументаКС.Очистить();
	ОбластьЗаголовок = Обработки.РегламентированнаяОтчетностьСоотношенияПоказателей.ПолучитьМакет("Настройки").ПолучитьОбласть("Заголовок");
	ПолеТабличногоДокументаКС.Вывести(ОбластьЗаголовок);
	ПолеТабличногоДокументаКС.Области.Заг.Текст = ТекстДляЗаголовочнойЧасти;

	СтрокаДанных1 = Обработки.РегламентированнаяОтчетностьСоотношенияПоказателей.ПолучитьМакет("Настройки").ПолучитьОбласть("СтрокаДанных1");
	
	Если НЕ РезультатПроверки = Неопределено
	   И (РезультатПроверки.КоличествоНайденныхОшибок + РезультатПроверки.КоличествоНайденныхБезОшибок > 0) Тогда

		ВывестиОшибки(ПолеТабличногоДокументаКС, СтрокаДанных1, РезультатПроверки);

	КонецЕсли;
	
	Попытка
		Если ЭтоАвтопроверкаСтатистики Тогда 
			Обл1 = ПолеТабличногоДокументаКС.Область(,4,,4);
			Обл3 = ПолеТабличногоДокументаКС.Область(,7,,7);
			
			ШиринаСкрываемых = Обл1.ШиринаКолонки+Обл3.ШиринаКолонки;
			ПолеТабличногоДокументаКС.Область(,3,,3).ШиринаКолонки = ПолеТабличногоДокументаКС.Область(,3,,3).ШиринаКолонки + (ШиринаСкрываемых/2);
			ПолеТабличногоДокументаКС.Область(,5,,5).ШиринаКолонки = ПолеТабличногоДокументаКС.Область(,5,,5).ШиринаКолонки + (ШиринаСкрываемых/6);
			ПолеТабличногоДокументаКС.Область(,6,,6).ШиринаКолонки = ПолеТабличногоДокументаКС.Область(,5,,5).ШиринаКолонки + (ШиринаСкрываемых/6);
			ПолеТабличногоДокументаКС.Область(,8,,8).ШиринаКолонки = ПолеТабличногоДокументаКС.Область(,8,,8).ШиринаКолонки + (ШиринаСкрываемых/6);
			Обл1.ШиринаКолонки = 0;
			Обл3.ШиринаКолонки = 0;
		КонецЕсли;
	Исключение
	КонецПопытки;

КонецПроцедуры

&НаСервере
Процедура ВывестиОшибки(Таб, СтрокаДанных, СтруктураОшибок)

	КолвоОшибок = СтруктураОшибок.КоличествоНайденныхОшибок + СтруктураОшибок.КоличествоНайденныхБезОшибок;
	НомерОшибки = 0;

	ПорядковыйНомерФормулы = 0;
	Для Инд = 1 По КолвоОшибок Цикл
		
		Счетчик = Формат(Инд, "ЧГ=0");
		Описание = СтруктураОшибок.СтруктураОшибок["Описание" + Счетчик];
		Расшифровка = СтруктураОшибок.СтруктураОшибок["Расшифровка" + Счетчик];

		Если СтруктураОшибок.СтруктураОшибок.Свойство("ТекстовоеПредставлениеФормулы" + Счетчик) Тогда
			ФормулаПредставл = СтруктураОшибок.СтруктураОшибок["ТекстовоеПредставлениеФормулы" + Счетчик];
		КонецЕсли;
		
		НомерФормулыДляРасшифровки = Неопределено;
		СтруктураОшибок.СтруктураОшибок.Свойство("НомерФормулыРасшифровки" + Счетчик, НомерФормулыДляРасшифровки);
		
		ЭтоОшибка = СтруктураОшибок.СтруктураОшибок["ЭтоОшибка" + Счетчик];
		КомментКОшибки = "";
		Если СтруктураОшибок.СтруктураОшибок.Свойство("Комментарий" + Счетчик) Тогда
			КомментКОшибки = СтруктураОшибок.СтруктураОшибок["Комментарий" + Счетчик];
		КонецЕсли;

		Если ОтобразитьТолькоОшибочныеКС Тогда
			Если НЕ ЭтоОшибка Тогда
				Продолжить;
			КонецЕсли;
		КонецЕсли;

		Если СтруктураОшибок.СтруктураОшибок.Свойство("Нарушение" + Счетчик) Тогда
			НарушениеДоп = СтруктураОшибок.СтруктураОшибок["Нарушение" + Счетчик];
		КонецЕсли;

		ПорядковыйНомерФормулы = ПорядковыйНомерФормулы + 1;
		НомФ = Формат(ПорядковыйНомерФормулы, "ЧГ=0");
		
		СоотношениеВыполнено = "Соотношение выполнено.";
		СоотношениеНеВыполнено = "Соотношение не выполнено.";

		ТекстРезультат = ?(ЭтоОшибка, СоотношениеНеВыполнено, СоотношениеВыполнено);

		ВывестиСекцию(Таб, СтрокаДанных, НомФ, ФормулаПредставл, Расшифровка, ТекстРезультат, НарушениеДоп, Описание,
			КомментКОшибки, ЭтоОшибка, ?(НомерФормулыДляРасшифровки = Неопределено, Инд, НомерФормулыДляРасшифровки));

	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура ВывестиСекцию(Таб, СтрокаДанных, Номер, Формула, Расшифровка, Статус, Нарушение, Описание, Комментарий,
	ВыделитьКрасным = Ложь, НомерЗарегистрированнойОшибкиПоФормуле = Неопределено)

	СтрокаДанных.Области.Номер1Номер.Текст = Номер;
	СтрокаДанных.Области.Номер1Формула.Текст = Формула;
	СтрокаДанных.Области.Номер1Расшифровка.Текст = Расшифровка;
	СчетчикФормулГдеЕстьОшибка = НомерЗарегистрированнойОшибкиПоФормуле;
	
	Если АдресСпискаРасшифровкиПоказателей = Неопределено Тогда
		СтрокаДанных.Области.Номер1Расшифровка.Расшифровка = Неопределено;
		СтрокаДанных.Области.Номер1Формула.Расшифровка = Неопределено;
	Иначе
		СтрокаДанных.Области.Номер1Расшифровка.Расшифровка = СчетчикФормулГдеЕстьОшибка;
		СтрокаДанных.Области.Номер1Формула.Расшифровка = СчетчикФормулГдеЕстьОшибка;
	КонецЕсли;
	
	СтрокаДанных.Области.Номер1Статус.Текст = Статус;
	СтрокаДанных.Области.Номер1Нарушение.Текст = ?(ВыделитьКрасным, Нарушение, "");
	СтрокаДанных.Области.Номер1Описание.Текст = ?(ВыделитьКрасным, Описание, "");
	СтрокаДанных.Области.Номер1Комментарий.Текст = Комментарий;
	
	Если ВыделитьКрасным Тогда
		СтрокаДанных.Области.Номер1Статус.ЦветТекста = ЦветаСтиля.ЦветОсобогоТекста;
	Иначе
		СтрокаДанных.Области.Номер1Статус.ЦветТекста = Новый Цвет(0, 0,0);
	КонецЕсли;
	
	Таб.Вывести(СтрокаДанных);

КонецПроцедуры

&НаКлиенте
Процедура ОтобразитьТолькоОшибочныеКСПриИзменении(Элемент)
	
	ВывестиКонтрольныеСоотношенияКлиент();
	
КонецПроцедуры

&НаКлиенте
Процедура Обновить(Команда)
	
	Если ЭтаФорма.ВладелецФормы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РезультатПроверки = ЭтаФорма.ВладелецФормы.ПроверитьКонтрольныеСоотношенияВОтчете();
	Если РезультатПроверки.Свойство("СписокРасшифровкиПоказателей") Тогда 
		АдресСпискаРасшифровкиПоказателей = РезультатПроверки.СписокРасшифровкиПоказателей;
	КонецЕсли;
	Если РезультатПроверки.Свойство("СписокРасшифровкиформулы") Тогда 
		АдресСпискаРасшифровкиФормулы = РезультатПроверки.СписокРасшифровкиформулы;
	КонецЕсли;
	
	ЭтоАвтопроверкаСтатистики = РезультатПроверки.Свойство("ЭтоАвтопроверкаСтатистики");
	ТекстДляЗаголовочнойЧасти = ЭтаФорма.ВладелецФормы.СтруктураРеквизитовФормы.ТекстДляЗаголовочнойЧасти;
	ВывестиКонтрольныеСоотношения();
	
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("СохранитьПослеПодключенияРасширенияРаботыСФайлами", ЭтотОбъект);
	
	НачатьПодключениеРасширенияРаботыСФайлами(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПослеПодключенияРасширенияРаботыСФайлами(Подключено, ДополнительныеПараметры) Экспорт
			
	Если Подключено Тогда
		
		ПоказатьДиалогВыбораФайла();
		
	Иначе
		
		Оповещение = Новый ОписаниеОповещения("СохранитьПослеУстановкиРасширенияЗавершение", ЭтотОбъект);
		
		НачатьУстановкуРасширенияРаботыСФайлами(Оповещение);
		
	КонецЕсли;
	          	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПослеОтображенияДиалогаВыбораФайла(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	Попытка
		ПолеТабличногоДокументаКС.Записать(ВыбранныеФайлы[0], ТипФайлаТабличногоДокумента.MXL);
	Исключение
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = НСтр("ru='Не удалось записать файл на диск. Возможно, диск защищен от записи или недостаточно места на диске.'");
		Сообщение.Сообщить();
	КонецПопытки;
		
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПослеУстановкиРасширенияЗавершение(ДополнительныеПараметры) Экспорт
	
	ОписаниеОповещения = Новый ОписаниеОповещения("СохранитьПослеУстановкиРасширенияЗавершениеПослеПодключенияРасширенияРаботыСФайлами", ЭтотОбъект);
	
	НачатьПодключениеРасширенияРаботыСФайлами(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПослеУстановкиРасширенияЗавершениеПослеПодключенияРасширенияРаботыСФайлами(Подключено, ДополнительныеПараметры) Экспорт
	
	Если НЕ Подключено Тогда
		Возврат;
	КонецЕсли;
		
	ПоказатьДиалогВыбораФайла();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьДиалогВыбораФайла()
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	Диалог.МножественныйВыбор = Ложь;
	Диалог.ПроверятьСуществованиеФайла = Истина;
	Диалог.Расширение = "mxl";
	Диалог.Фильтр = "Табличные документы (*.mxl)|*.mxl";
	
	ОписаниеОповещения = Новый ОписаниеОповещения("СохранитьПослеОтображенияДиалогаВыбораФайла", ЭтотОбъект);
	
	Диалог.Показать(ОписаниеОповещения);
		
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновитьКС" Тогда
		
		РезультатПроверки = Параметр.РезультатПроверки;
		ТекстДляЗаголовочнойЧасти = Параметр.ТекстДляЗаголовочнойЧасти;
		АдресСпискаРасшифровкиПоказателей = Неопределено;
		АдресСпискаРасшифровкиФормулы = Неопределено;
		Если РезультатПроверки.Свойство("СписокРасшифровкиПоказателей") Тогда 
			АдресСпискаРасшифровкиПоказателей = РезультатПроверки.СписокРасшифровкиПоказателей;
		КонецЕсли;
		Если РезультатПроверки.Свойство("СписокРасшифровкиформулы") Тогда 
			АдресСпискаРасшифровкиФормулы = РезультатПроверки.СписокРасшифровкиформулы;
		КонецЕсли;
		
		Если РезультатПроверки.КоличествоНайденныхОшибок > 0 Тогда
			ОтобразитьТолькоОшибочныеКС = Истина;
		Иначе
			ОтобразитьТолькоОшибочныеКС = Ложь;
		КонецЕсли;
		
		ВывестиКонтрольныеСоотношенияКлиент();
		
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ДЛЯ ВЫВОДА РАСШИФРОВКИ ПРОВЕРКИ КОНТРОЛЬНЫХ СООТНОШЕНИЙ
//

&НаКлиенте
Процедура ПолеТабличногоДокументаКСОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущееПолеТабличногоДокументаКС = ПолеТабличногоДокументаКС.ТекущаяОбласть;
	Показать(Расшифровка);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьРасшифровку(Команда)
	СкрытьРасшифровку();
КонецПроцедуры

&НаКлиенте
Процедура СкрытьРасшифровку()
	Элементы.Группа2.Видимость = Ложь;
КонецПроцедуры

// ВывестиСекцию
//
&НаСервере
Процедура ВывестиСекциюРасшифровки(Таб, ИмяОбласти, Наименование, ПоказательНаименование = Неопределено, ПоказательСумма = Неопределено, Расшифровка = Неопределено)
	
	Область = Обработки.РегламентированнаяОтчетностьСоотношенияПоказателей.ПолучитьМакет("Макет").ПолучитьОбласть(ИмяОбласти);
	
	Если ИмяОбласти = "Заголовок" Тогда
		Область.Области.НаименованиеЗаголовок.Значение = Наименование;
	ИначеЕсли ИмяОбласти = "Показатель" Тогда
		Область.Области.ПоказательНаименование.Значение = ПоказательНаименование;
		Если ТипЗнч(ПоказательСумма) = Тип("Число") Тогда
			// Если есть дробная часть, анализируем, чтобы после зпт. не было более 2 чисел,
			// иначе переводим значение в строку и отображаем как строка. ЕНВД.
			Если ПоказательСумма - Цел(ПоказательСумма) <> 0 Тогда
				// Для случае, когда необходимо в расшифровке отобразить показатели коэффициенты
				// со значениями после запятой. Например в декларации по ЕНВД.
				СтрокаПоказателя = Формат(ПоказательСумма - Цел(ПоказательСумма));
				// Если 0.123 - т.е. длина 5, тогда конвертируем в строку, иначе оставим как есть.
				Если СтрДлина(СтрокаПоказателя) > 4 Тогда
					// Переведем значение в строку и ее будем отображать в расшифровке.
					ПоказательСумма = Формат(ПоказательСумма);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Область.Области.ПоказательСумма.Значение = ПоказательСумма;
		
	КонецЕсли;
		
	Если Расшифровка <> Неопределено Тогда
		Если ИмяОбласти = "Заголовок" Тогда
			Область.Область(1,1,Область.ВысотаТаблицы,Область.ШиринаТаблицы).Расшифровка = Расшифровка;
		Иначе
			Область.Область(1,1,Область.ВысотаТаблицы,Область.ШиринаТаблицы).Расшифровка = Расшифровка;
		КонецЕсли;
	КонецЕсли;
	
	Таб.Вывести(Область);
	
КонецПроцедуры

// Процедура формирует и выводит в поле табличного документа на форме расшифровку значения показателя,
// соответствующего текущей ячейке активного поля табличного документа вызывающей формы (задана в переменной модуля "Форма").
// В случае, если для показателя, соответсвующего текущей активной ячейки расшифровка неопределена, то расшифровка 
// выводится для всех показателей, для которых расшифровка определена.
// Процедура вызывается из модуля формы отчета.
//
// Параметры:
//	Нет.
//
&НаСервере
Процедура Показать(Расшифровка) Экспорт

	Если АдресСпискаРасшифровкиПоказателей = Неопределено Тогда 
		Возврат;
	Иначе
		СписокРасшифровкиПоказателей = ПолучитьИзВременногоХранилища(АдресСпискаРасшифровкиПоказателей);
	КонецЕсли;
	Если АдресСпискаРасшифровкиФормулы = Неопределено Тогда 
		Возврат;
	Иначе
		СписокРасшифровкиформулы = ПолучитьИзВременногоХранилища(АдресСпискаРасшифровкиформулы);
	КонецЕсли;
	
	Показатели = СписокРасшифровкиПоказателей.НайтиСтроки(Новый Структура("Номер", Расшифровка));
	Формула    = СписокРасшифровкиформулы.НайтиСтроки(Новый Структура("Номер", Расшифровка));

	Если Показатели.Количество() = 0 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = НСтр("ru='Расшифровка для данного соотношения отсутствует.'");
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	Таб = ПолеРасшифровки;
	Таб.Очистить();

	ВывестиСекциюРасшифровки(Таб, "Заголовок", Формула[0].ТекстовоеПредставлениеФормулы,,,"ЗаголовокАктивизироватьСоотношения");

	Для Каждого Стр Из Показатели Цикл
		СтруктураРасш = Новый Структура;
		СтруктураРасш.Вставить("ИмяПоказателя", Стр.ИмяПоказателя);
		СтруктураРасш.Вставить("СсылкаНаОтчет", Стр.СсылкаНаДокументРО);
		СтруктураРасш.Вставить("ИмяСтраницы", Стр.ИмяСтраницы);
		СтруктураРасш.Вставить("Страница", Стр.Страница);
		СтруктураРасш.Вставить("ДополнительныеВозможности", Стр.ДополнительныеВозможности);
		ВывестиСекциюРасшифровки(Таб, "Показатель", "", Стр.ПредставлениеПоказателя, Стр.ЗначениеПоказателя, СтруктураРасш);
	КонецЦикла;

	Элементы.Группа2.Видимость = Истина;

КонецПроцедуры

// ПолеРасшифровкиОбработкаРасшифровки
// Процедура - обработчик события "Обработка расшифровки" поля табличного документа "ПолеРасшифровки" формы
// Открывает стандартный отчет, соответствующий активной ячейки поля табличного документа
//
&НаКлиенте
Процедура ПолеРасшифровкиОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ТипЗнч(Расшифровка) = Тип("Строка") Тогда
		ПерейтиВРодительскийОтчет();
	Иначе
		
		Если Расшифровка.ДополнительныеВозможности <> Неопределено Тогда
			Если СтрНайти(Расшифровка.ДополнительныеВозможности, "ВывестиТекстОтчетНеОткрывать:") > 0 Тогда
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = Сред(Расшифровка.ДополнительныеВозможности, 30);
				Сообщение.Сообщить();
				Возврат;
			КонецЕсли;
		КонецЕсли;
		
		АктивизироватьЯчейкуОтчета(Расшифровка);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиВРодительскийОтчет()
	
	Если ТекущееПолеТабличногоДокументаКС = Неопределено Тогда 
		ЭтаФорма.ТекущийЭлемент = Элементы.ПолеТабличногоДокументаКС;
	Иначе
		ЭтаФорма.ТекущийЭлемент = Элементы.ПолеТабличногоДокументаКС;
		ЭтаФорма.ПолеТабличногоДокументаКС.ТекущаяОбласть = ТекущееПолеТабличногоДокументаКС;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПараметрыНаСервере(ПараметрыФормы, ТекДок)
	
	ПараметрыФормы.Вставить("мДатаНачалаПериодаОтчета",	НачалоДня(ТекДок.ДатаНачала));
	ПараметрыФормы.Вставить("мДатаКонцаПериодаОтчета",	КонецДня(ТекДок.ДатаОкончания));
	ПараметрыФормы.Вставить("мПериодичность",			ТекДок.Периодичность);
	ПараметрыФормы.Вставить("Организация",				ТекДок.Организация);
	ПараметрыФормы.Вставить("мВыбраннаяФорма",			ТекДок.ВыбраннаяФорма);
	ПараметрыФормы.Вставить("ИсточникОтчета",			ТекДок.ИсточникОтчета);
	ПараметрыФормы.Вставить("ЭтоВнешнийОтчет",			РегламентированнаяОтчетность.ЭтоВнешнийОтчет(ТекДок.ИсточникОтчета));
	
КонецПроцедуры

&НаКлиенте
Процедура АктивизироватьЯчейкуОтчета(Расшифровка)
	
	ТекДок = Расшифровка.СсылкаНаОтчет;
	
	Если ТекДок = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РасшифровкаИмяПоказателя = Расшифровка.ИмяПоказателя;
	СтруктураДопПараметровКСпецПоказателям = Неопределено; //ОпределитьСпециальныеПараметрыПоказателя(РасшифровкаИмяПоказателя);
	
	Если СтруктураДопПараметровКСпецПоказателям = Неопределено Тогда
		ИмяПоказателя = РасшифровкаИмяПоказателя;
	Иначе
		ИмяПоказателя = СтруктураДопПараметровКСпецПоказателям.КоординатаНаЛисте;
	КонецЕсли;
	
	Раздел = Расшифровка.ИмяСтраницы;
	Ячейка = Новый Структура;
	Ячейка.Вставить("Раздел", Раздел);
	Ячейка.Вставить("Страница", Расшифровка.Страница); // номер листа в многостраничном разделе, если не многостр. разд., то "".
	Ячейка.Вставить("Строка", "");
	Ячейка.Вставить("Графа", "");
	Ячейка.Вставить("СтрокаПП", "");
	Ячейка.Вставить("ИмяЯчейки", ИмяПоказателя);
	Ячейка.Вставить("Описание", "Не задано значение");
	
	Если ЭтаФорма.ВладелецФормы = Неопределено ИЛИ ТекДок <> ЭтаФорма.ВладелецФормы.КлючУникальности Тогда
		
		ПараметрыФормы = Новый Структура;
		
		ЗаполнитьПараметрыНаСервере(ПараметрыФормы, ТекДок);
		
		ПараметрыФормы.Вставить("ДоступенМеханизмПечатиРеглОтчетностиСДвухмернымШтрихкодомPDF417", РегламентированнаяОтчетностьКлиент.ДоступенМеханизмПечатиРеглОтчетностиСДвухмернымШтрихкодомPDF417());
		ПараметрыФормы.Вставить("НеОтображатьПредупреждение", Истина);
		
		Попытка
			
			ПараметрыФормы.Вставить("мСохраненныйДок", ТекДок);
			ВариантОтчета = ?(ПараметрыФормы.ЭтоВнешнийОтчет, "ВнешнийОтчет.", "Отчет.");
			ПараметрыФормы.Удалить("ЭтоВнешнийОтчет");
						
			ФормаОтчета = ОткрытьФорму(ВариантОтчета + ПараметрыФормы.ИсточникОтчета + ".Форма." + ПараметрыФормы.мВыбраннаяФорма, ПараметрыФормы, , ТекДок);
			
		Исключение
			
			СтрокаОписания = ОписаниеОшибки();
			ПоказатьПредупреждение(,НСтр("ru='Внимание! Устаревшая редакция формы отчета не поддерживается текущей версией конфигурации.'"));
			
			Возврат;
			
		КонецПопытки;
		
	Иначе 
		
		ФормаОтчета = ЭтаФорма.ВладелецФормы;
		
		ФормаОтчета.Открыть();
		
	КонецЕсли;
	
	ФормаОтчета.Активизировать();
	ФормаОтчета.АктивизироватьЯчейку(Ячейка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если СтрНачинаетсяС(ЭтаФорма.ВладелецФормы.ИмяФормы, "Отчет.РегламентированныйОтчетСтатистика") Тогда 
		Элементы.Обновить.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

//
// ПРОЦЕДУРЫ И ФУНКЦИИ ДЛЯ ВЫВОДА РАСШИФРОВКИ ПРОВЕРКИ КОНТРОЛЬНЫХ СООТНОШЕНИЙ
////////////////////////////////////////////////////////////////////////////////
