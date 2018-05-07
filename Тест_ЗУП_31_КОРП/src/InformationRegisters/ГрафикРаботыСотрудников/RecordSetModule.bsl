#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПередЗаписью(ЭтотОбъект);
	
	ДанныеДвиженийРегистратора = Новый МенеджерВременныхТаблиц;
	
	ДополнительныеСвойства.Вставить("ДанныеДвиженийРегистратора", ДанныеДвиженийРегистратора);
	
	Если ДополнительныеСвойства.Свойство("МенеджерВременныхТаблицПередЗаписью") Тогда
		МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблицПередЗаписью;
	Иначе
		МенеджерВременныхТаблиц	= Новый МенеджерВременныхТаблиц;
		ДополнительныеСвойства.Вставить("МенеджерВременныхТаблицПередЗаписью", МенеджерВременныхТаблиц);
	КонецЕсли;
	ЗарплатаКадрыПериодическиеРегистры.СоздатьВТСтарыйНаборЗаписей(ЭтотОбъект, МенеджерВременныхТаблиц);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ, Замещение)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадрыПериодическиеРегистры.КонтрольИзмененийПриЗаписи(ЭтотОбъект);
	
	Если Не ДополнительныеСвойства.Свойство("ДанныеДвиженийРегистратора") Тогда
		Возврат;
	КонецЕсли;
	
	МенеджерВременныхТаблиц = ДополнительныеСвойства.МенеджерВременныхТаблицПередЗаписью;
	ПараметрыРесурсов = ЗарплатаКадрыПериодическиеРегистры.ПараметрыНаследованияРесурсов("ГрафикРаботыСотрудников");
	
	ПараметрыПостроения = ЗарплатаКадрыПериодическиеРегистры.ПараметрыПостроенияИнтервальногоРегистра();
	ПараметрыПостроения.ОсновноеИзмерение = "Сотрудник";
	ПараметрыПостроения.ПараметрыРесурсов = ПараметрыРесурсов;
	
	ЗарплатаКадрыПериодическиеРегистры.СформироватьДвиженияИнтервальногоРегистраПоИзменениям(
		"ГрафикРаботыСотрудников", 
		ЭтотОбъект, 
		МенеджерВременныхТаблиц, 
		ПараметрыПостроения);
	
	ДанныеДвиженийРегистратора = ДополнительныеСвойства.ДанныеДвиженийРегистратора;	
	
	ИзмененияГрафиков = ЗарплатаКадрыПериодическиеРегистры.ТаблицаИзменившихсяДанныхНабора(ЭтотОбъект);
	УчетРабочегоВремениРасширенный.ПриИзмененииГрафиковСотрудников(ИзмененияГрафиков);
КонецПроцедуры

#КонецОбласти

#КонецЕсли
