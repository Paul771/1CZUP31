////////////////////////////////////////////////////////////////////////////////
// Подсистема "Базовая функциональность 
//             электронного документооборота с контролирующими органами". 
////////////////////////////////////////////////////////////////////////////////


#Область ПрограммныйИнтерфейс

Функция ТекстовоеПредставлениеРазмераФайла(РазмерВБайтах, Разрядность = 0) Экспорт
	
	Размер = 0;
	РазмерВКилобайтах = Окр(РазмерВБайтах / 1024, Разрядность);
	Если РазмерВБайтах = 0 Тогда
		Шаблон = НСтр("ru = '%1 Б'");
	ИначеЕсли РазмерВКилобайтах < 1000 Тогда
		Размер = РазмерВКилобайтах;
		Шаблон = НСтр("ru = '%1 КБ'");
	Иначе
		Размер = Окр(РазмерВКилобайтах / 1024, Разрядность);
		Шаблон = НСтр("ru = '%1 МБ'");
	КонецЕсли;
	
	Возврат СтрШаблон(Шаблон, Размер);
	
КонецФункции

Функция ЗаменитьНечитаемыеСимволы(ИсходнаяСтрока, ЗаменятьНа = "_") Экспорт
	
	СтрокаПослеЗамены = ИсходнаяСтрока;
	
	ДлинаСтроки = СтрДлина(ИсходнаяСтрока);
	Для Индекс = 1 По ДлинаСтроки Цикл
		ТекущийСимвол = Сред(ИсходнаяСтрока, Индекс, 1);
		Если КодСимвола(ТекущийСимвол) < 32 Тогда
			СтрокаПослеЗамены = СтрЗаменить(СтрокаПослеЗамены, ТекущийСимвол, ЗаменятьНа);
		КонецЕсли;	
	КонецЦикла;
	
	Возврат СтрокаПослеЗамены;
	
КонецФункции

Функция ЗаменитьЗапрещенныеСимволыВИмениФайла(ИсходнаяСтрока, ЗаменятьНа = "_") Экспорт
	
	ЗапрещенныеСимволы = СтрРазделить("\,/,:,*,?,"",<,>,|,+", ",");
	
	СтрокаПослеЗамены = СокрЛП(ИсходнаяСтрока);
	
	Для Каждого ЗапрещенныйСимвол Из ЗапрещенныеСимволы Цикл
		СтрокаПослеЗамены = СтрЗаменить(СтрокаПослеЗамены, ЗапрещенныйСимвол, ЗаменятьНа);
	КонецЦикла;
	
	Если СтрЗаканчиваетсяНа(СтрокаПослеЗамены, ".") Тогда
		СтрокаПослеЗамены = Лев(СтрокаПослеЗамены, СтрДлина(СтрокаПослеЗамены) - 1) + ЗаменятьНа;
	КонецЕсли;
	
	Возврат СтрокаПослеЗамены;
	
КонецФункции

Функция НовыйИдентификатор() Экспорт
	
	Возврат НРег(СтрЗаменить(Новый УникальныйИдентификатор, "-", ""));
	
КонецФункции

Функция УникальнаяСтрока(ИсходнаяУникальнаяСтрока, МаксимальнаяДлина) Экспорт
	
	Если СтрДлина(ИсходнаяУникальнаяСтрока) > МаксимальнаяДлина Тогда
		ЗавершающийИдентификатор = НовыйИдентификатор();
		ДлинаИдентификатора = СтрДлина(ЗавершающийИдентификатор);
		Возврат Лев(ИсходнаяУникальнаяСтрока, МаксимальнаяДлина - ДлинаИдентификатора) + ЗавершающийИдентификатор;
	Иначе
		Возврат ИсходнаяУникальнаяСтрока;
	КонецЕсли;
	
КонецФункции

Функция ПолучитьИнформациюОбОшибке(ИнформацияОбОшибке) Экспорт
	
	Результат = ИнформацияОбОшибке;
	Если ИнформацияОбОшибке <> Неопределено Тогда
		Если ИнформацияОбОшибке.Причина <> Неопределено Тогда
			Результат = ПолучитьИнформациюОбОшибке(ИнформацияОбОшибке.Причина);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти