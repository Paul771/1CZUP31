
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаДокумента.
Функция ОписаниеСоставаДокумента() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.ПачкаДокументовСПВ_1;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаДокументаПоМетаданнымФизическиеЛицаВТабличныхЧастях(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВыгрузитьФайлыВоВременноеХранилище(Ссылка, УникальныйИдентификатор = Неопределено) Экспорт 
	
	ДанныеФайла = ЗарплатаКадры.ПолучитьДанныеФайла(Ссылка, УникальныйИдентификатор);
	
	ОписаниеВыгруженногоФайла = ПерсонифицированныйУчет.ОписаниеВыгруженногоФайлаОтчетности();
	
	ОписаниеВыгруженногоФайла.Владелец = Ссылка;
	ОписаниеВыгруженногоФайла.АдресВоВременномХранилище = ДанныеФайла.СсылкаНаДвоичныеДанныеФайла;
	ОписаниеВыгруженногоФайла.ИмяФайла = ДанныеФайла.ИмяФайла;
	ОписаниеВыгруженногоФайла.ПроверятьCheckXML = Истина;
	ОписаниеВыгруженногоФайла.ПроверятьCheckUFA = Истина;
	
	ВыгруженныеФайлы = Новый Массив;
	ВыгруженныеФайлы.Добавить(ОписаниеВыгруженногоФайла);
	
	Возврат ВыгруженныеФайлы;
	
КонецФункции

Функция ПолучитьСтруктуруПроверяемыхДанных() Экспорт
	Возврат ПерсонифицированныйУчет.ПолучитьСтруктуруПроверяемыхДанных();
КонецФункции

Функция ПолучитьПредставленияПроверяемыхРеквизитов() Экспорт
	Возврат ПерсонифицированныйУчет.ПолучитьПредставленияПроверяемыхРеквизитов();
КонецФункции

Функция ПолучитьСоответствиеРеквизитовФормеОбъекта(ДанныеДляПроверки) Экспорт
	Возврат ПерсонифицированныйУчет.ПолучитьСоответствиеРеквизитовФормеОбъекта();
КонецФункции

Функция ПолучитьСоответствиеРеквизитовПутиВФормеОбъекта() Экспорт
	
	СоответствиеРеквизитовПутиВФормеОбъекта = ПерсонифицированныйУчет.ПолучитьСоответствиеРеквизитовПутиВФормеОбъекта();
	
	Возврат СоответствиеРеквизитовПутиВФормеОбъекта;
	
КонецФункции

Функция ПолучитьСоответствиеПроверяемыхРеквизитовОткрываемымОбъектам(ДокументСсылка, ДанныеДляПроверки) Экспорт
	Возврат Новый Структура;
КонецФункции

#Область ПроцедурыПолученияДанныхДляЗаполненияИПроведенияДокумента

Функция СформироватьЗапросПоЗаписямСтажаДляПечати(МассивСсылок) Экспорт 
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПачкаДокументовСПВ_1Сотрудники.НомерСтроки КАК НомерСтроки,
	|	ПачкаДокументовСПВ_1Сотрудники.Сотрудник,
	|	ПачкаДокументовСПВ_1Сотрудники.СтраховойНомерПФР,
	|	ПачкаДокументовСПВ_1Сотрудники.Фамилия,
	|	ПачкаДокументовСПВ_1Сотрудники.Имя,
	|	ПачкаДокументовСПВ_1Сотрудники.Отчество,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.Ссылка КАК Ссылка,
	|	ПачкаДокументовСПВ_1Сотрудники.ДатаСоставления
	|ПОМЕСТИТЬ ВТСотрудникДокумента
	|ИЗ
	|	Документ.ПачкаДокументовСПВ_1.Сотрудники КАК ПачкаДокументовСПВ_1Сотрудники
	|ГДЕ
	|	ПачкаДокументовСПВ_1Сотрудники.Ссылка В(&МассивСсылок)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗаписиОСтаже.НомерОсновнойЗаписи КАК НомерОсновнойЗаписи,
	|	ЗаписиОСтаже.НомерДополнительнойЗаписи КАК НомерДополнительнойЗаписи,
	|	ЗаписиОСтаже.ДатаНачалаПериода,
	|	ЗаписиОСтаже.ДатаОкончанияПериода,
	|	ЗаписиОСтаже.ТерриториальныеУсловия,
	|	ЗаписиОСтаже.ТерриториальныеУсловия.Код КАК ТерриториальныеУсловияКод,
	|	ЗаписиОСтаже.ПараметрТерриториальныхУсловий КАК ПараметрТерриториальныхУсловий,
	|	ЗаписиОСтаже.ОсобыеУсловияТруда,
	|	ЗаписиОСтаже.ОсобыеУсловияТруда.КодДляОтчетности2010 КАК ОсобыеУсловияТрудаКод,
	|	ЗаписиОСтаже.КодПозицииСписка.Код КАК КодПозицииСпискаКод,
	|	ЗаписиОСтаже.ОснованиеИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ОснованиеИсчисляемогоСтажа.Код КАК ОснованиеИсчисляемогоСтажаКод,
	|	ЗаписиОСтаже.ПервыйПараметрИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ВторойПараметрИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ТретийПараметрИсчисляемогоСтажа.Код КАК ТретийПараметрИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ОснованиеВыслугиЛет,
	|	ЗаписиОСтаже.ОснованиеВыслугиЛет.КодДляОтчетности2010 КАК ОснованиеВыслугиЛетКод,
	|	ЗаписиОСтаже.ПервыйПараметрВыслугиЛет,
	|	ЗаписиОСтаже.ВторойПараметрВыслугиЛет,
	|	ЗаписиОСтаже.ТретийПараметрВыслугиЛет,
	|	ПачкаДокументовСПВ_1Сотрудники.НомерСтроки КАК НомерСтроки,
	|	ПачкаДокументовСПВ_1Сотрудники.Сотрудник,
	|	ПачкаДокументовСПВ_1Сотрудники.СтраховойНомерПФР,
	|	ПачкаДокументовСПВ_1Сотрудники.Фамилия,
	|	ПачкаДокументовСПВ_1Сотрудники.Имя,
	|	ПачкаДокументовСПВ_1Сотрудники.Отчество,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.Ссылка КАК Ссылка,
	|	ПачкаДокументовСПВ_1Сотрудники.ДатаСоставления
	|ИЗ
	|	ВТСотрудникДокумента КАК ПачкаДокументовСПВ_1Сотрудники
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПачкаДокументовСПВ_1.ЗаписиОСтаже КАК ЗаписиОСтаже
	|		ПО ПачкаДокументовСПВ_1Сотрудники.Сотрудник = ЗаписиОСтаже.Сотрудник
	|			И ПачкаДокументовСПВ_1Сотрудники.Ссылка = ЗаписиОСтаже.Ссылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка,
	|	НомерСтроки,
	|	НомерОсновнойЗаписи,
	|	НомерДополнительнойЗаписи";
	
	Возврат Запрос.Выполнить();
	
КонецФункции

Функция СформироватьЗапросПоШапкеДляПечати(МассивСсылок)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	
	ОписаниеИсточникаДанных = ПерсонифицированныйУчет.ОписаниеИсточникаДанныхДляСоздатьВТСведенияОбОрганизациях();
	ОписаниеИсточникаДанных.ИмяТаблицы = "Документ.ПачкаДокументовСПВ_1";
	ОписаниеИсточникаДанных.ИмяПоляОрганизация = "Организация";
	ОписаниеИсточникаДанных.ИмяПоляПериод = "ОкончаниеОтчетногоПериода";
	ОписаниеИсточникаДанных.СписокСсылок = МассивСсылок;

	ПерсонифицированныйУчет.СоздатьВТСведенияОбОрганизацияхПоОписаниюДокументаИсточникаДанных(Запрос.МенеджерВременныхТаблиц, ОписаниеИсточникаДанных);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПачкаДокументовСПВ_1.Ссылка КАК Ссылка,
	|	ПачкаДокументовСПВ_1.Организация КАК Организация,
	|	СведенияОбОрганизациях.НаименованиеСокращенное КАК НаименованиеОрганизации,
	|	СведенияОбОрганизациях.РегистрационныйНомерПФР КАК РегистрационныйНомерПФР,
	|	СведенияОбОрганизациях.ИНН КАК ИНН,
	|	СведенияОбОрганизациях.КПП КАК КПП,
	|	ПачкаДокументовСПВ_1.КатегорияЗастрахованныхЛиц КАК КатегорияЗастрахованныхЛиц,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод,
	|	ПачкаДокументовСПВ_1.ОкончаниеОтчетногоПериода,
	|	ПачкаДокументовСПВ_1.ТипСведенийСЗВ,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод КАК КорректируемыйПериод,
	|	ПачкаДокументовСПВ_1.Руководитель КАК Руководитель,
	|	ПачкаДокументовСПВ_1.ДолжностьРуководителя.Наименование КАК ДолжностьРуководителя,
	|	ПачкаДокументовСПВ_1.Дата,
	|	ПачкаДокументовСПВ_1.НомерПачки,
	|	СведенияОбОрганизациях.КодПоОКПО КАК КодПоОКПО
	|ПОМЕСТИТЬ ВТДанныеДокументов
	|ИЗ
	|	Документ.ПачкаДокументовСПВ_1 КАК ПачкаДокументовСПВ_1
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТСведенияОбОрганизациях КАК СведенияОбОрганизациях
	|		ПО ПачкаДокументовСПВ_1.Организация = СведенияОбОрганизациях.Организация
	|			И ПачкаДокументовСПВ_1.ОкончаниеОтчетногоПериода = СведенияОбОрганизациях.Период
	|ГДЕ
	|	ПачкаДокументовСПВ_1.Ссылка В(&МассивСсылок)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка,
	|	Руководитель";
	Запрос.Выполнить();
	
	ИменаПолейОтветственныхЛиц = Новый Массив;
	ИменаПолейОтветственныхЛиц.Добавить("Руководитель");
	
	ЗарплатаКадры.СоздатьВТФИООтветственныхЛиц(Запрос.МенеджерВременныхТаблиц, Ложь, ИменаПолейОтветственныхЛиц, "ВТДанныеДокументов");
		
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПачкаДокументовСПВ_1.Ссылка КАК Ссылка,
	|	ПачкаДокументовСПВ_1.РегистрационныйНомерПФР КАК РегНомерПФР,
	|	ПачкаДокументовСПВ_1.НаименованиеОрганизации КАК НаименованиеОрганизации,
	|	ПачкаДокументовСПВ_1.ИНН КАК ИНН,
	|	ПачкаДокументовСПВ_1.КПП КАК КПП,
	|	ПачкаДокументовСПВ_1.КатегорияЗастрахованныхЛиц КАК КатегорияЗастрахованныхЛиц,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод,
	|	ПачкаДокументовСПВ_1.ТипСведенийСЗВ,
	|	ПачкаДокументовСПВ_1.КорректируемыйПериод,
	|	ЕСТЬNULL(ВТФИОПоследние.РасшифровкаПодписи, """") КАК Руководитель,
	|	ПачкаДокументовСПВ_1.ДолжностьРуководителя КАК ДолжностьРуководителя,
	|	ПачкаДокументовСПВ_1.Дата,
	|	ПачкаДокументовСПВ_1.НомерПачки,
	|	ПачкаДокументовСПВ_1.КодПоОКПО КАК ОКПО
	|ИЗ
	|	ВТДанныеДокументов КАК ПачкаДокументовСПВ_1
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТФИООтветственныхЛиц КАК ВТФИОПоследние
	|		ПО ПачкаДокументовСПВ_1.Ссылка = ВТФИОПоследние.Ссылка
	|			И ПачкаДокументовСПВ_1.Руководитель = ВТФИОПоследние.ФизическоеЛицо
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка";
	
	Возврат Запрос.Выполнить();
	
КонецФункции

Функция СформироватьЗапросПоШапкеДляАДВ_3(МассивОбъектов) Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("МассивСсылок", МассивОбъектов);
	
	ОписаниеИсточникаДанных = ПерсонифицированныйУчет.ОписаниеИсточникаДанныхДляСоздатьВТСведенияОбОрганизациях();
	ОписаниеИсточникаДанных.ИмяТаблицы = "Документ.ПачкаДокументовСПВ_1";
	ОписаниеИсточникаДанных.ИмяПоляОрганизация = "Организация";
	ОписаниеИсточникаДанных.ИмяПоляПериод = "ОкончаниеОтчетногоПериода";
	ОписаниеИсточникаДанных.СписокСсылок = МассивОбъектов;

	ПерсонифицированныйУчет.СоздатьВТСведенияОбОрганизацияхПоОписаниюДокументаИсточникаДанных(Запрос.МенеджерВременныхТаблиц, ОписаниеИсточникаДанных);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СУММА(Застрахованные.НачисленоСтраховая) КАК НачисленоСтраховая,
	|	СУММА(Застрахованные.УплаченоСтраховая) КАК УплаченоСтраховая,
	|	СУММА(Застрахованные.НачисленоНакопительная) КАК НачисленоНакопительная,
	|	СУММА(Застрахованные.УплаченоНакопительная) КАК УплаченоНакопительная,
	|	КОЛИЧЕСТВО(Застрахованные.НомерСтроки) КАК Количество,
	|	Застрахованные.Ссылка КАК Ссылка
	|ПОМЕСТИТЬ ВТИтоги
	|ИЗ
	|	Документ.ПачкаДокументовСПВ_1.Сотрудники КАК Застрахованные
	|ГДЕ
	|	Застрахованные.Ссылка В(&МассивСсылок)
	|
	|СГРУППИРОВАТЬ ПО
	|	Застрахованные.Ссылка
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПачкаДокументовСПВ_1.Ссылка КАК Ссылка,
	|	ПачкаДокументовСПВ_1.Номер,
	|	ПачкаДокументовСПВ_1.Дата КАК Дата,
	|	ПачкаДокументовСПВ_1.КатегорияЗастрахованныхЛиц,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод,
	|	ПачкаДокументовСПВ_1.ТипСведенийСЗВ,
	|	ПачкаДокументовСПВ_1.НомерПачки,
	|	ПачкаДокументовСПВ_1.ДолжностьРуководителя.Наименование КАК РуководительДолжность,
	|	СведенияОбОрганизациях.НаименованиеСокращенное КАК НаименованиеОрганизации,
	|	ПачкаДокументовСПВ_1.Организация КАК Организация,
	|	СведенияОбОрганизациях.РегистрационныйНомерПФР КАК РегистрационныйНомерПФР,
	|	СведенияОбОрганизациях.ИНН КАК ИНН,
	|	СведенияОбОрганизациях.КПП КАК КПП,
	|	ГОД(ПачкаДокументовСПВ_1.ОтчетныйПериод) КАК Год,
	|	ПачкаДокументовСПВ_1.ОкончаниеОтчетногоПериода КАК ОкончаниеОтчетногоПериода,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод КАК КорректируемыйПериод,
	|	ПачкаДокументовСПВ_1.Руководитель КАК Руководитель,
	|	СведенияОбОрганизациях.КодПоОКПО КАК КодПоОКПО
	|ПОМЕСТИТЬ ВТДанныеДокументов
	|ИЗ
	|	Документ.ПачкаДокументовСПВ_1 КАК ПачкаДокументовСПВ_1
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТСведенияОбОрганизациях КАК СведенияОбОрганизациях
	|		ПО ПачкаДокументовСПВ_1.Организация = СведенияОбОрганизациях.Организация
	|			И ПачкаДокументовСПВ_1.ОкончаниеОтчетногоПериода = СведенияОбОрганизациях.Период
	|ГДЕ
	|	ПачкаДокументовСПВ_1.Ссылка В(&МассивСсылок)
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Ссылка,
	|	Руководитель";
	
	Запрос.Выполнить();
	
	ИменаПолейОтветственныхЛиц = Новый Массив;
	ИменаПолейОтветственныхЛиц.Добавить("Руководитель");
	
	ЗарплатаКадры.СоздатьВТФИООтветственныхЛиц(Запрос.МенеджерВременныхТаблиц, Ложь, ИменаПолейОтветственныхЛиц, "ВТДанныеДокументов");
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПачкаДокументовСПВ_1.Ссылка КАК Ссылка,
	|	ПачкаДокументовСПВ_1.Номер,
	|	ПачкаДокументовСПВ_1.Дата КАК Дата,
	|	ПачкаДокументовСПВ_1.КатегорияЗастрахованныхЛиц,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод,
	|	ПачкаДокументовСПВ_1.ТипСведенийСЗВ,
	|	ПачкаДокументовСПВ_1.НомерПачки,
	|	ПачкаДокументовСПВ_1.РуководительДолжность КАК РуководительДолжность,
	|	ПачкаДокументовСПВ_1.НаименованиеОрганизации КАК НаименованиеОрганизации,
	|	ПачкаДокументовСПВ_1.РегистрационныйНомерПФР КАК РегНомерПФР,
	|	ПачкаДокументовСПВ_1.ИНН КАК ИНН,
	|	ПачкаДокументовСПВ_1.КПП КАК КПП,
	|	ПачкаДокументовСПВ_1.КодПоОКПО КАК КодПоОКПО,
	|	ПачкаДокументовСПВ_1.Год КАК Год,
	|	""СПВ-1"" КАК ТипФормДокументов,
	|	ЕСТЬNULL(ИтогиПоВзносам.НачисленоСтраховая, 0) КАК НачисленоСтраховая,
	|	ЕСТЬNULL(ИтогиПоВзносам.УплаченоСтраховая, 0) КАК УплаченоСтраховая,
	|	ЕСТЬNULL(ИтогиПоВзносам.НачисленоНакопительная, 0) КАК НачисленоНакопительная,
	|	ЕСТЬNULL(ИтогиПоВзносам.УплаченоНакопительная, 0) КАК УплаченоНакопительная,
	|	ЕСТЬNULL(ИтогиПоВзносам.Количество, 0) КАК Количество,
	|	ПачкаДокументовСПВ_1.КорректируемыйПериод КАК КорректируемыйПериод,
	|	ЕСТЬNULL(ВТФИОПоследние.РасшифровкаПодписи, """") КАК Руководитель
	|ИЗ
	|	ВТДанныеДокументов КАК ПачкаДокументовСПВ_1
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТИтоги КАК ИтогиПоВзносам
	|		ПО ПачкаДокументовСПВ_1.Ссылка = ИтогиПоВзносам.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТФИООтветственныхЛиц КАК ВТФИОПоследние
	|		ПО ПачкаДокументовСПВ_1.Ссылка = ВТФИОПоследние.Ссылка
	|			И ПачкаДокументовСПВ_1.Руководитель = ВТФИОПоследние.ФизическоеЛицо
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка";
	
	Возврат Запрос.Выполнить();
	
КонецФункции

#КонецОбласти

#Область ДляОбеспеченияФормированияВыходногоФайла

// Формирует запрос по шапке документа.
//
// Параметры: 
//  Режим - режим проведения
//
// Возвращаемое значение:
//  Результат запроса
//
Функция СформироватьЗапросПоШапке(Ссылка) Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	// Установим параметры запроса.
	Запрос.УстановитьПараметр("ДокументСсылка", Ссылка);
	
	ОписаниеИсточникаДанных = ПерсонифицированныйУчет.ОписаниеИсточникаДанныхДляСоздатьВТСведенияОбОрганизациях();
	ОписаниеИсточникаДанных.ИмяТаблицы = "Документ.ПачкаДокументовСПВ_1";
	ОписаниеИсточникаДанных.ИмяПоляОрганизация = "Организация";
	ОписаниеИсточникаДанных.ИмяПоляПериод = "ОкончаниеОтчетногоПериода";
	ОписаниеИсточникаДанных.СписокСсылок = Ссылка;

	ПерсонифицированныйУчет.СоздатьВТСведенияОбОрганизацияхПоОписаниюДокументаИсточникаДанных(Запрос.МенеджерВременныхТаблиц, ОписаниеИсточникаДанных);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СУММА(Застрахованные.НачисленоСтраховая) КАК НачисленоСтраховая,
	|	СУММА(Застрахованные.УплаченоСтраховая) КАК УплаченоСтраховая,
	|	СУММА(Застрахованные.НачисленоНакопительная) КАК НачисленоНакопительная,
	|	СУММА(Застрахованные.УплаченоНакопительная) КАК УплаченоНакопительная,
	|	КОЛИЧЕСТВО(Застрахованные.НомерСтроки) КАК Количество
	|ПОМЕСТИТЬ ВТИтоги
	|ИЗ
	|	Документ.ПачкаДокументовСПВ_1.Сотрудники КАК Застрахованные
	|ГДЕ
	|	Застрахованные.Ссылка = &ДокументСсылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПачкаДокументовСПВ_1.Ссылка,
	|	ПачкаДокументовСПВ_1.Номер,
	|	ПачкаДокументовСПВ_1.Дата,
	|	ПачкаДокументовСПВ_1.Проведен,
	|	ПачкаДокументовСПВ_1.Организация,
	|	ПачкаДокументовСПВ_1.КатегорияЗастрахованныхЛиц,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод,
	|	ПачкаДокументовСПВ_1.ТипСведенийСЗВ,
	|	ПачкаДокументовСПВ_1.НомерПачки,
	|	ПачкаДокументовСПВ_1.ДокументПринятВПФР,
	|	ПачкаДокументовСПВ_1.Ответственный,
	|	ПачкаДокументовСПВ_1.ДолжностьРуководителя.Наименование КАК РуководительДолжность,
	|	СведенияОбОрганизациях.Наименование,
	|	СведенияОбОрганизациях.ЮридическоеФизическоеЛицо КАК ЮридическоеФизическоеЛицо,
	|	СведенияОбОрганизациях.ОГРН,
	|	СведенияОбОрганизациях.КодПоОКПО,
	|	СведенияОбОрганизациях.НаименованиеПолное,
	|	СведенияОбОрганизациях.НаименованиеСокращенное,
	|	СведенияОбОрганизациях.РегистрационныйНомерПФР КАК РегистрационныйНомерПФР,
	|	СведенияОбОрганизациях.РайонныйКоэффициент,
	|	СведенияОбОрганизациях.ИНН,
	|	СведенияОбОрганизациях.КПП,
	|	СведенияОбОрганизациях.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
	|	ГОД(ПачкаДокументовСПВ_1.ОтчетныйПериод) КАК Год,
	|	СведенияОбОрганизациях.КодПоОКПО КАК ОКПО,
	|	""СПВ-1"" КАК ТипФормДокументов,
	|	ЕСТЬNULL(ИтогиПоВзносам.НачисленоСтраховая, 0) КАК НачисленоСтраховая,
	|	ЕСТЬNULL(ИтогиПоВзносам.УплаченоСтраховая, 0) КАК УплаченоСтраховая,
	|	ЕСТЬNULL(ИтогиПоВзносам.НачисленоНакопительная, 0) КАК НачисленоНакопительная,
	|	ЕСТЬNULL(ИтогиПоВзносам.УплаченоНакопительная, 0) КАК УплаченоНакопительная,
	|	ЕСТЬNULL(ИтогиПоВзносам.Количество, 0) КАК Количество,
	|	ПачкаДокументовСПВ_1.ОтчетныйПериод КАК КорректируемыйПериод,
	|	ПачкаДокументовСПВ_1.ИмяФайлаДляПФР
	|ИЗ
	|	Документ.ПачкаДокументовСПВ_1 КАК ПачкаДокументовСПВ_1
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТСведенияОбОрганизациях КАК СведенияОбОрганизациях
	|		ПО ПачкаДокументовСПВ_1.Организация = СведенияОбОрганизациях.Организация
	|			И ПачкаДокументовСПВ_1.ОкончаниеОтчетногоПериода = СведенияОбОрганизациях.Период
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТИтоги КАК ИтогиПоВзносам
	|		ПО (ИСТИНА)
	|ГДЕ
	|	ПачкаДокументовСПВ_1.Ссылка = &ДокументСсылка";
	
	Возврат Запрос.Выполнить();
	
КонецФункции

Функция СформироватьЗапросПоЗаписямСтажа(Ссылка) Экспорт 
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПачкаДокументовСПВ_1Сотрудники.НомерСтроки КАК НомерСтроки,
	|	ПачкаДокументовСПВ_1Сотрудники.Сотрудник,
	|	ПачкаДокументовСПВ_1Сотрудники.СтраховойНомерПФР,
	|	ПачкаДокументовСПВ_1Сотрудники.Фамилия,
	|	ПачкаДокументовСПВ_1Сотрудники.Имя,
	|	ПачкаДокументовСПВ_1Сотрудники.Отчество,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.ДатаСоставления
	|ПОМЕСТИТЬ ВТСотрудникиДокумента
	|ИЗ
	|	Документ.ПачкаДокументовСПВ_1.Сотрудники КАК ПачкаДокументовСПВ_1Сотрудники
	|ГДЕ
	|	ПачкаДокументовСПВ_1Сотрудники.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЗаписиОСтаже.НомерОсновнойЗаписи КАК НомерОсновнойЗаписи,
	|	ЗаписиОСтаже.НомерДополнительнойЗаписи КАК НомерДополнительнойЗаписи,
	|	ЗаписиОСтаже.ДатаНачалаПериода,
	|	ЗаписиОСтаже.ДатаОкончанияПериода,
	|	ЗаписиОСтаже.ТерриториальныеУсловия,
	|	ЗаписиОСтаже.ТерриториальныеУсловия.Код КАК ТерриториальныеУсловияКод,
	|	ЗаписиОСтаже.ПараметрТерриториальныхУсловий КАК ТерриториальныеУсловияСтавка,
	|	ЗаписиОСтаже.ОсобыеУсловияТруда,
	|	ЗаписиОСтаже.ОсобыеУсловияТруда.КодДляОтчетности2010 КАК ОсобыеУсловияТрудаКод,
	|	ЗаписиОСтаже.КодПозицииСписка,
	|	ЗаписиОСтаже.КодПозицииСписка.Код КАК КодПозицииСпискаКод,
	|	ЗаписиОСтаже.ОснованиеИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ОснованиеИсчисляемогоСтажа.Код КАК ОснованиеИсчисляемогоСтажаКод,
	|	ЗаписиОСтаже.ПервыйПараметрИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ВторойПараметрИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ТретийПараметрИсчисляемогоСтажа.Код КАК ТретийПараметрИсчисляемогоСтажа,
	|	ЗаписиОСтаже.ОснованиеВыслугиЛет,
	|	ЗаписиОСтаже.ОснованиеВыслугиЛет.КодДляОтчетности2010 КАК ОснованиеВыслугиЛетКод,
	|	ЗаписиОСтаже.ПервыйПараметрВыслугиЛет,
	|	ЗаписиОСтаже.ВторойПараметрВыслугиЛет,
	|	ЗаписиОСтаже.ТретийПараметрВыслугиЛет,
	|	ПачкаДокументовСПВ_1Сотрудники.НомерСтроки КАК НомерСтроки,
	|	ПачкаДокументовСПВ_1Сотрудники.Сотрудник,
	|	ПачкаДокументовСПВ_1Сотрудники.СтраховойНомерПФР,
	|	ПачкаДокументовСПВ_1Сотрудники.Фамилия,
	|	ПачкаДокументовСПВ_1Сотрудники.Имя,
	|	ПачкаДокументовСПВ_1Сотрудники.Отчество,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоСтраховая,
	|	ПачкаДокументовСПВ_1Сотрудники.НачисленоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.УплаченоНакопительная,
	|	ПачкаДокументовСПВ_1Сотрудники.ДатаСоставления
	|ИЗ
	|	ВТСотрудникиДокумента КАК ПачкаДокументовСПВ_1Сотрудники
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПачкаДокументовСПВ_1.ЗаписиОСтаже КАК ЗаписиОСтаже
	|		ПО ПачкаДокументовСПВ_1Сотрудники.Сотрудник = ЗаписиОСтаже.Сотрудник
	|			И (ЗаписиОСтаже.Ссылка = &Ссылка)
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки,
	|	НомерОсновнойЗаписи,
	|	НомерДополнительнойЗаписи";
	
	Возврат Запрос.Выполнить();
	
КонецФункции

Процедура ОбработкаФормированияФайла(Объект) Экспорт
	
	ВыборкаПоШапкеДокумента = СформироватьЗапросПоШапке(Объект.Ссылка).Выбрать();
	РезультатЗапросаПоЗаписямСтажа = СформироватьЗапросПоЗаписямСтажа(Объект.Ссылка);
	
	ВыборкаПоШапкеДокумента.Следующий();
	
	ТекстФайла = ПерсонифицированныйУчет.ФайлСведенийОВзносахИСтаже(ВыборкаПоШапкеДокумента, РезультатЗапросаПоЗаписямСтажа, ВыборкаПоШапкеДокумента.Количество);
	
	ЗарплатаКадры.ЗаписатьФайлВАрхив(Объект.Ссылка, ВыборкаПоШапкеДокумента.ИмяФайлаДляПФР, ТекстФайла);
	
КонецПроцедуры

#КонецОбласти

#Область ПроцедурыИФункцииПечати

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	// СПВ-1
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Обработчик = "ЗарплатаКадрыКлиент.ВыполнитьКомандуПечати";
	КомандаПечати.Идентификатор = "ФормаСПВ_1";
	КомандаПечати.Представление = НСтр("ru = 'СПВ-1'");
	КомандаПечати.Порядок = 10;
	КомандаПечати.ПроверкаПроведенияПередПечатью = Ложь;
	
	// АДВ-6-3
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Обработчик = "ЗарплатаКадрыКлиент.ВыполнитьКомандуПечати";
	КомандаПечати.Идентификатор = "ФормаАДВ_6_3";
	КомандаПечати.Представление = НСтр("ru = 'АДВ-6-3'");
	КомандаПечати.Порядок = 20;
	КомандаПечати.ПроверкаПроведенияПередПечатью = Ложь;
	
	// Все формы
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Обработчик = "ЗарплатаКадрыКлиент.ВыполнитьКомандуПечати";
	КомандаПечати.Идентификатор = "ФормаСПВ_1,ФормаАДВ_6_3";
	КомандаПечати.Представление = НСтр("ru = 'Все формы'");
	КомандаПечати.Порядок = 30;
	КомандаПечати.ПроверкаПроведенияПередПечатью = Ложь;
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт	
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ФормаСПВ_1") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ФормаСПВ_1", "Форма СПВ-1", СформироватьПечатнуюФормуСПВ_1(МассивОбъектов, ОбъектыПечати));
	КонецЕсли;
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ФормаАДВ_6_3") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ФормаАДВ_6_3", "Форма АДВ-6-3", СформироватьПечатнуюФормуАДВ_6_3(МассивОбъектов, ОбъектыПечати));
	КонецЕсли;
	
КонецПроцедуры

Функция СформироватьПечатнуюФормуСПВ_1(МассивОбъектов, ОбъектыПечати)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	
	ТабличныйДокумент.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_ПачкаДокументовСПВ_1_Форма_СПВ_1";
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.ПачкаДокументовСПВ_1.ПФ_MXL_ФормаСПВ_1");
	
	ВыборкаДокументов = СформироватьЗапросПоШапкеДляПечати(МассивОбъектов).Выбрать();
	
	ВыборкаЗаписейСтажа = СформироватьЗапросПоЗаписямСтажаДляПечати(МассивОбъектов).Выбрать();
	
	ОбластьСтрока = Макет.ПолучитьОбласть("Строка");	
	ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
	ОбластьШапка  = Макет.ПолучитьОбласть("Шапка");
	ОбластьСтаж   = Макет.ПолучитьОбласть("Стаж");
	
	Пока ВыборкаДокументов.СледующийПоЗначениюПоля("Ссылка") Цикл
		ВыборкаЗаписейСтажа.Сбросить();
		
		СтруктураПоиска = Новый Структура("Ссылка", ВыборкаДокументов.Ссылка);
		
		Если ВыборкаЗаписейСтажа.НайтиСледующий(СтруктураПоиска) Тогда
			ЗаполнитьЗначенияСвойств(ОбластьШапка.Параметры, ВыборкаДокументов, "РегНомерПФР, ИНН, КПП, ОКПО");
			
			ОбластьШапка.Параметры.НаименованиеОрганизации = ПерсонифицированныйУчет.СтрокаВОтчет(ВыборкаДокументов.НаименованиеОрганизации);
			
			ОбластьШапка.Параметры.КодКатегории = ПерсонифицированныйУчет.ПолучитьИмяЭлементаПеречисленияПоЗначению(ВыборкаДокументов.КатегорияЗастрахованныхЛиц);
			
			ОтчетныйПериод = ВыборкаДокументов.ОтчетныйПериод;
			КорректируемыйПериод = ВыборкаДокументов.КорректируемыйПериод;
			
			Если Год(ОтчетныйПериод) >= 2011 Тогда
				ОбластьШапка.Параметры.ЭтоКварталОтчетногоГода   = Месяц(ОтчетныйПериод) = 1;
				ОбластьШапка.Параметры.ЭтоПолугодиеОтчетногоГода = Месяц(ОтчетныйПериод) = 4;
				ОбластьШапка.Параметры.Это9МесяцевОтчетногоГода  = Месяц(ОтчетныйПериод) = 7;
				ОбластьШапка.Параметры.ЭтоВесьОтчетныйГод        = Месяц(ОтчетныйПериод) = 10;
			Иначе
				ОбластьШапка.Параметры.ЭтоПолугодие2010 = Месяц(ОтчетныйПериод) = 1;
				ОбластьШапка.Параметры.Это2010год = Месяц(ОтчетныйПериод) = 10;
			КонецЕсли;
			
			ОбластьШапка.Параметры.ДатаСоставления = ПерсонифицированныйУчет.ДатаВОтчет(ВыборкаЗаписейСтажа.ДатаСоставления);
			
			ОбластьШапка.Параметры.ОтчетныйГод = Формат(Год(ОтчетныйПериод), "ЧГ=");
			
			ОбластьШапка.Параметры.ЭтоИсходныйДокумент = ВыборкаДокументов.ТипСведенийСЗВ = Перечисления.ТипыСведенийСЗВ.ИСХОДНАЯ;
			ОбластьШапка.Параметры.ЭтоКорректирующийДокумент = ВыборкаДокументов.ТипСведенийСЗВ = Перечисления.ТипыСведенийСЗВ.КОРРЕКТИРУЮЩАЯ;
			ОбластьШапка.Параметры.ЭтоОтменяющийДокумент     = ВыборкаДокументов.ТипСведенийСЗВ = Перечисления.ТипыСведенийСЗВ.ОТМЕНЯЮЩАЯ;
			
			Если ВыборкаЗаписейСтажа.СледующийПоЗначениюПоля("Ссылка") Тогда 
				
				Пока ВыборкаЗаписейСтажа.СледующийПоЗначениюПоля("НомерСтроки") Цикл
					НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
					
					ТабличныйДокумент.Вывести(ОбластьШапка);
					
					ОбластьСтрока.Параметры.ФИО = ПерсонифицированныйУчет.СтрокаВОтчет(ВыборкаЗаписейСтажа.Фамилия + " " + ВыборкаЗаписейСтажа.Имя + " " + ВыборкаЗаписейСтажа.Отчество);					
					ОбластьСтрока.Параметры.СтраховойНомерПФР = ВыборкаЗаписейСтажа.СтраховойНомерПФР;
					
					ОбластьСтрока.Параметры.НачисленоНакопительная = ВыборкаЗаписейСтажа.НачисленоНакопительная;
					ОбластьСтрока.Параметры.УплаченоНакопительная  = ВыборкаЗаписейСтажа.УплаченоНакопительная;
					ОбластьСтрока.Параметры.НачисленоСтраховая     = ВыборкаЗаписейСтажа.НачисленоСтраховая;
					ОбластьСтрока.Параметры.УплаченоСтраховая      = ВыборкаЗаписейСтажа.УплаченоСтраховая;
					
					ТабличныйДокумент.Вывести(ОбластьСтрока);
					
					Если ЗначениеЗаполнено(ВыборкаЗаписейСтажа.НомерОсновнойЗаписи) Тогда
						
						НомерСтроки = 0;
						Пока ВыборкаЗаписейСтажа.СледующийПоЗначениюПоля("НомерОсновнойЗаписи") Цикл
							НомерСтроки = НомерСтроки + 1;
							
							ЗаполнитьОбластьСтаж(ВыборкаЗаписейСтажа, ОбластьСтаж, НомерСтроки);
							ТабличныйДокумент.Вывести(ОбластьСтаж);
							
							Пока ВыборкаЗаписейСтажа.СледующийПоЗначениюПоля("НомерДополнительнойЗаписи") Цикл
								Если ВыборкаЗаписейСтажа.НомерДополнительнойЗаписи = 0 Тогда
									Продолжить;
								КонецЕсли;
								
								НомерСтроки = НомерСтроки + 1;
								
								ЗаполнитьОбластьСтаж(ВыборкаЗаписейСтажа, ОбластьСтаж, НомерСтроки);
								ТабличныйДокумент.Вывести(ОбластьСтаж);
								
							КонецЦикла;
							
						КонецЦикла;
					КонецЕсли;
					
					ОбластьПодвал.Параметры.Руководитель = ВыборкаДокументов.Руководитель;
					ОбластьПодвал.Параметры.РуководительДолжность = ВыборкаДокументов.ДолжностьРуководителя;
					ОбластьПодвал.Параметры.ДатаСоставленияОписи  = ПерсонифицированныйУчет.ДатаВОтчет(ВыборкаДокументов.Дата);
					
					ТабличныйДокумент.Вывести(ОбластьПодвал);
					
					ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
					
					УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, НомерСтрокиНачало, ОбъектыПечати, ВыборкаДокументов.Ссылка);
					
				КонецЦикла;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	ТабличныйДокумент.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	
	Возврат ТабличныйДокумент;
	
КонецФункции

Процедура ЗаполнитьОбластьСтаж(ВыборкаЗаписейСтажа, ОбластьСтаж, НомерСтроки)
	
	ОбластьСтаж.Параметры.НомерСтроки = НомерСтроки;
	ОбластьСтаж.Параметры.ДатаНачалаПериода = ВыборкаЗаписейСтажа.ДатаНачалаПериода;
	ОбластьСтаж.Параметры.ДатаОкончанияПериода = ВыборкаЗаписейСтажа.ДатаОкончанияПериода;
	
	ОбластьСтаж.Параметры.ТерриториальныеУсловияКод = ВыборкаЗаписейСтажа.ТерриториальныеУсловияКод;
	ОбластьСтаж.Параметры.ДопТУ = ПерсонифицированныйУчет.ПредставлениеПараметровТерриториальныхУсловий(ВыборкаЗаписейСтажа);
	ОбластьСтаж.Параметры.ОсобыеУсловияТрудаКод = ВыборкаЗаписейСтажа.ОсобыеУсловияТрудаКод;
	ОбластьСтаж.Параметры.КодПозицииСписка = ВыборкаЗаписейСтажа.КодПозицииСпискаКод;
	ОбластьСтаж.Параметры.ОснованиеИТС = ВыборкаЗаписейСтажа.ОснованиеИсчисляемогоСтажаКод;
	ОбластьСтаж.Параметры.ОснованиеВыслуги = ВыборкаЗаписейСтажа.ОснованиеВыслугиЛетКод;
	ОбластьСтаж.Параметры.ДопИТС = ПерсонифицированныйУчет.ПредставлениеПараметровИсчисляемогоТрудовогоСтажа(ВыборкаЗаписейСтажа);
	
	ПерсонифицированныйУчет.ПредставлениеПараметровПенсииЗаВыслугуЛет(ВыборкаЗаписейСтажа, ОбластьСтаж.Параметры.ДопВЛ, ОбластьСтаж.Параметры.ДопВЛСтавка);
	
КонецПроцедуры

Функция СформироватьПечатнуюФормуАДВ_6_3(МассивОбъектов, ОбъектыПечати)
	
	ВыборкаПоШапкеДокумента = СформироватьЗапросПоШапкеДляАДВ_3(МассивОбъектов).Выбрать();
	
	Возврат ПерсонифицированныйУчет.ВывестиОписьАДВ6_3(ОбъектыПечати, ВыборкаПоШапкеДокумента, "СПВ_1");
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли