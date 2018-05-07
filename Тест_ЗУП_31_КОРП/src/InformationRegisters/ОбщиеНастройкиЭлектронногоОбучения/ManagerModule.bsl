#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Функция Значение(ИмяНастройки) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Настройки."+ИмяНастройки+" КАК ЗначениеНастройки
		|ИЗ
		|	РегистрСведений.ОбщиеНастройкиЭлектронногоОбучения КАК Настройки";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		
		РеквизитРегистра = Метаданные.РегистрыСведений.ОбщиеНастройкиЭлектронногоОбучения.Ресурсы.Найти(ИмяНастройки);
		
		Если РеквизитРегистра = Неопределено Тогда
			ВызватьИсключение НСтр("ru = 'Ошибочное имя общих настроек электронного обучения'");
		КонецЕсли;
		
		Возврат РеквизитРегистра.Тип.ПривестиЗначение(Неопределено);
		
	Иначе		
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		ВыборкаДетальныеЗаписи.Следующий();

		Возврат ВыборкаДетальныеЗаписи.ЗначениеНастройки;	
		
	КонецЕсли;
		
КонецФункции

Процедура Сохранить(ИмяНастройки, ЗначениеНастройки) Экспорт
	
	МенеджерЗаписи = РегистрыСведений.ОбщиеНастройкиЭлектронногоОбучения.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Прочитать();
	
	МенеджерЗаписи[ИмяНастройки] = ЗначениеНастройки;
	
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли