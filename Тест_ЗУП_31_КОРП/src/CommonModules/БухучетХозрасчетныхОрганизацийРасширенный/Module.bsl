
#Область СлужебныйПрограммныйИнтерфейс

// Определяет имя документа, которым выполняется отражение зарплаты в бухгалтерском учете.
//
Процедура ЗаполнитьИмяДокументаОтраженияВБухучете(ИмяДокументаОтраженияВБухучете) Экспорт
	ИмяДокументаОтраженияВБухучете = Метаданные.Документы.ОтражениеЗарплатыВБухучете.ПолноеИмя();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики обновления информационной базы.

Функция ТекстЗапросаДанныеДокументаОбработкаДокументовОтражениеЗарплатыВБухучете(Знач ТекстЗапроса) Экспорт

	ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"#НачисленнаяЗарплатаИВзносы", "Документ.ОтражениеЗарплатыВБухучете.НачисленнаяЗарплатаИВзносы");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "НачисленнаяЗарплатаИВзносы.СтатьяРасходов", "ЗНАЧЕНИЕ(Справочник.СтатьиРасходовЗарплата.ПустаяСсылка)");
	Возврат ТекстЗапроса;

КонецФункции

Процедура ОбновитьВидОперацииУдержаниеПоПрочимОперациямСРаботниками()Экспорт

	Запрос = Новый Запрос();
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ОтражениеЗарплатыВБухучетеУдержаннаяЗарплата.Ссылка
	|ПОМЕСТИТЬ ВТДокументы
	|ИЗ
	|	Документ.ОтражениеЗарплатыВБухучете.УдержаннаяЗарплата КАК ОтражениеЗарплатыВБухучетеУдержаннаяЗарплата
	|ГДЕ
	|	ОтражениеЗарплатыВБухучетеУдержаннаяЗарплата.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.ПрочиеРасчетыСПерсоналом)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	УдержаннаяЗарплата.Ссылка КАК Ссылка,
	|	УдержаннаяЗарплата.НомерСтроки КАК НомерСтроки,
	|	УдержаннаяЗарплата.ФизическоеЛицо,
	|	УдержаннаяЗарплата.Подразделение,
	|	ВЫБОР
	|		КОГДА УдержаннаяЗарплата.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.ПрочиеРасчетыСПерсоналом)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыОперацийПоЗарплате.УдержаниеПоПрочимОперациямСРаботниками)
	|		ИНАЧЕ УдержаннаяЗарплата.ВидОперации
	|	КОНЕЦ КАК ВидОперации,
	|	УдержаннаяЗарплата.СтатьяФинансирования,
	|	УдержаннаяЗарплата.Сумма,
	|	УдержаннаяЗарплата.Контрагент
	|ИЗ
	|	Документ.ОтражениеЗарплатыВБухучете.УдержаннаяЗарплата КАК УдержаннаяЗарплата
	|ГДЕ
	|	УдержаннаяЗарплата.Ссылка В
	|			(ВЫБРАТЬ
	|				ВТДокументы.Ссылка
	|			ИЗ
	|				ВТДокументы)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка,
	|	НомерСтроки
	|АВТОУПОРЯДОЧИВАНИЕ";
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Пока Выборка.СледующийПоЗначениюПоля("Ссылка") Цикл
		
		Ссылка = Выборка.Ссылка;
		ДокументОбъект = Ссылка.ПолучитьОбъект();
		ДокументОбъект.УдержаннаяЗарплата.Очистить();
		Пока Выборка.Следующий() Цикл
			ЗаполнитьЗначенияСвойств(ДокументОбъект.УдержаннаяЗарплата.Добавить(), Выборка);
		КонецЦикла;
		ДокументОбъект.Записать(РежимЗаписиДокумента.Запись);
		
	КонецЦикла;

КонецПроцедуры

#Область НастройкиВариантовОтчетов

// Содержит настройки размещения вариантов отчетов в панели отчетов.
// Описание см. ЗарплатаКадрыВариантыОтчетов.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчетов(Настройки) Экспорт
	
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.ДанныеДляОтраженияВБухучете);
	
КонецПроцедуры

#КонецОбласти	

#КонецОбласти