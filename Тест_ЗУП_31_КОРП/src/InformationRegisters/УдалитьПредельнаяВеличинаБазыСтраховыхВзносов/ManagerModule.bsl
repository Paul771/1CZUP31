#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Процедура выполняет первоначальное заполнение сведений.
Процедура НачальноеЗаполнение() Экспорт
	
	ЗаполнитьПредельнуюВеличинуБазыСтраховыхВзносов();
	
КонецПроцедуры

Процедура ЗаполнитьПредельнуюВеличинуБазыСтраховыхВзносов() Экспорт
	
	НаборЗаписей = РегистрыСведений.ПредельнаяВеличинаБазыСтраховыхВзносов.СоздатьНаборЗаписей();
	НаборЗаписей.ДополнительныеСвойства.Вставить("ЗаписьОбщихДанных");
    НоваяСтрока = НаборЗаписей.Добавить();
	НоваяСтрока.Период = '20100101';
	НоваяСтрока.РазмерФСС = 415000;
	НоваяСтрока.РазмерПФР = 415000;
	НоваяСтрока.РазмерФОМС = 415000;
    НоваяСтрока = НаборЗаписей.Добавить();
	НоваяСтрока.Период = '20110101';
	НоваяСтрока.РазмерФСС = 463000;
	НоваяСтрока.РазмерПФР = 463000;
	НоваяСтрока.РазмерФОМС = 463000;
    НоваяСтрока = НаборЗаписей.Добавить();
	НоваяСтрока.Период = '20120101';
	НоваяСтрока.РазмерФСС = 512000;
	НоваяСтрока.РазмерПФР = 512000;
	НоваяСтрока.РазмерФОМС = 512000;
    НоваяСтрока = НаборЗаписей.Добавить();
	НоваяСтрока.Период = '20130101';
	НоваяСтрока.РазмерФСС = 568000;
	НоваяСтрока.РазмерПФР = 568000;
	НоваяСтрока.РазмерФОМС = 568000;
    НоваяСтрока = НаборЗаписей.Добавить();
	НоваяСтрока.Период = '20140101';
	НоваяСтрока.РазмерФСС = 624000;
	НоваяСтрока.РазмерПФР = 624000;
	НоваяСтрока.РазмерФОМС = 624000;
    НоваяСтрока = НаборЗаписей.Добавить();
	НоваяСтрока.Период = '20150101';
	НоваяСтрока.РазмерФСС = 670000;
	НоваяСтрока.РазмерПФР = 711000;
	НаборЗаписей.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли