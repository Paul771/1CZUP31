////////////////////////////////////////////////////////////////////////////////
// Подсистема "Электронный документооборот с контролирующими органами".
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

Функция ЕстьЗащитаОтОпасныхДействий() Экспорт
	
	Свойства = Новый Структура("ЗащитаОтОпасныхДействий");
	ЗаполнитьЗначенияСвойств(Свойства, ПользователиИнформационнойБазы.ТекущийПользователь());
	
	Возврат Свойства.ЗащитаОтОпасныхДействий <> Неопределено;
	
КонецФункции

#Область СеансСвязиСКонтролирующимиОрганами

Процедура УстановитьПараметрСеансаТекущийСеансДокументооборотаСКО(ИмяПараметра = Неопределено, УстановленныеПараметры = Неопределено) Экспорт
	
	ПараметрыСеанса.ТекущийСеансДокументооборотаСКО = Справочники.СеансыСвязиСКонтролирующимиОрганами.ПустаяСсылка();
	
КонецПроцедуры

Процедура НачатьСеансДокументооборотаСКО(ИнициаторСеанса, УчетнаяЗапись = Неопределено) Экспорт
	
	НовыйСеанс = Справочники.СеансыСвязиСКонтролирующимиОрганами.СоздатьЭлемент();
	НовыйСеанс.Начало = ТекущаяУниверсальнаяДата();
	НовыйСеанс.ИнициаторСеанса = ИнициаторСеанса;
	Если ТипЗнч(УчетнаяЗапись) = Тип("СправочникСсылка.УчетныеЗаписиДокументооборота") Тогда
		НовыйСеанс.УчетнаяЗапись = УчетнаяЗапись;
	КонецЕсли;
	
	НовыйСеанс.Записать();
	
	ПараметрыСеанса.ТекущийСеансДокументооборотаСКО = НовыйСеанс.Ссылка;
	
КонецПроцедуры

Процедура ЗакончитьСеансДокументооборотаСКО(УчетнаяЗапись = Неопределено, Успешно = Истина) Экспорт
	
	ТекущийСеанс = ТекущийСеансДокументооборотаСКО();
	Если ЗначениеЗаполнено(ТекущийСеанс) Тогда
		СеансОбъект = ТекущийСеанс.ПолучитьОбъект();
		
		СеансОбъект.Окончание = ТекущаяУниверсальнаяДата();
		СеансОбъект.Успешно = Успешно;
		СеансОбъект.Записать();
		
		ПараметрыСеанса.ТекущийСеансДокументооборотаСКО = Справочники.СеансыСвязиСКонтролирующимиОрганами.ПустаяСсылка();
		
	КонецЕсли;
	
КонецПроцедуры

Функция ТекущийСеансДокументооборотаСКО() Экспорт
	
	Возврат ПараметрыСеанса.ТекущийСеансДокументооборотаСКО;
	
КонецФункции

#КонецОбласти

Функция УстановитьСоединениеССерверомИнтернета(URLСервера, ОписаниеОшибки = "") Экспорт

	СтруктураURI = ОбщегоНазначенияКлиентСервер.СтруктураURI(URLСервера);
	Схема = ?(ЗначениеЗаполнено(СтруктураURI.Схема), СтруктураURI.Схема, "http");
	Прокси = ПолучениеФайловИзИнтернетаКлиентСервер.ПолучитьПрокси(Схема);
	
	Попытка
		Соединение = Новый HTTPСоединение(
			СтруктураURI.Хост,
			СтруктураURI.Порт,
			СтруктураURI.Логин,
			СтруктураURI.Пароль, 
			Прокси,
			60,
			?(НРег(Схема) = "http", Неопределено, Новый ЗащищенноеСоединениеOpenSSL));
	Исключение
			
		ИнформацияОбОшибке = ОбщегоНазначенияЭДКОКлиентСервер.ПолучитьИнформациюОбОшибке(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(
			НСтр("ru = 'Электронный документооборот с контролирующими органами. Установление соединения с сервером интернета'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка,,,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
			
		ОписаниеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
		
		Возврат Неопределено;
	КонецПопытки;
	
	Возврат Соединение;
	
КонецФункции

#Область ОбменСКонтролирующимиОрганами

Процедура ВыполнитьОбмен(УчетнаяЗапись) Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(Метаданные.РегламентныеЗадания.ОбменСКонтролирующимиОрганами);
	
	ОтключитьПриНеобходимостиАвтоматическийОбмен(УчетнаяЗапись);
	
	ПолучитьСообщения(УчетнаяЗапись);	
	ОтправитьСообщения(УчетнаяЗапись);
	
КонецПроцедуры

Функция ПолучитьСообщения(УчетнаяЗапись) Экспорт
	
	ОбработкаЭДО = ДокументооборотСКОВызовСервера.ПолучитьОбработкуЭДО();	
	Возврат ОбработкаЭДО.ПолучитьСообщения(УчетнаяЗапись);
	
КонецФункции

Процедура ОтправитьСообщения(УчетнаяЗапись) Экспорт
	
	ОбработкаЭДО = ДокументооборотСКОВызовСервера.ПолучитьОбработкуЭДО();	
	ОбработкаЭДО.ОтправитьСообщения(УчетнаяЗапись);
	
КонецПроцедуры

#КонецОбласти

#Область УправлениеСтатусомАвтообмена

Процедура НастроитьОбменПоУчетнойЗаписи(УчетнаяЗапись) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если УчетнаяЗапись.ОтключитьАвтообмен Тогда
		ОтключитьОбменПоУчетнойЗаписи(УчетнаяЗапись);
	Иначе
		ВключитьОбменПоУчетнойЗаписи(УчетнаяЗапись);
	КонецЕсли;
	
КонецПроцедуры

Процедура ВключитьОбменПоУчетнойЗаписи(УчетнаяЗапись) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОтключитьОбменПоУчетнойЗаписи(УчетнаяЗапись);
	
	Расписание = Новый РасписаниеРегламентногоЗадания;
	Расписание.ПериодПовтораВТечениеДня = ПолучитьИнтервалВыполненияОбмена(УчетнаяЗапись);
	Расписание.ПериодПовтораДней 		= 1;

	Параметры = Новый Массив;
	Параметры.Добавить(УчетнаяЗапись);
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Метаданные", Метаданные.РегламентныеЗадания.ОбменСКонтролирующимиОрганами);
	ПараметрыЗадания.Вставить("Ключ", Строка(УчетнаяЗапись.УникальныйИдентификатор()));
	ПараметрыЗадания.Вставить("Параметры", Параметры);
	ПараметрыЗадания.Вставить("Расписание", Расписание);
	ПараметрыЗадания.Вставить("Использование", Истина);
	ПараметрыЗадания.Вставить("ИнтервалПовтораПриАварийномЗавершении", 10);
	ПараметрыЗадания.Вставить("КоличествоПовторовПриАварийномЗавершении", 3);
	ПараметрыЗадания.Вставить("Наименование", СтрШаблон(НСтр("ru = 'Обмен с контролирующими органами (%1)'"), УчетнаяЗапись));
	
	РегламентныеЗаданияСервер.ДобавитьЗадание(ПараметрыЗадания);
	
КонецПроцедуры

Процедура ОтключитьОбменПоУчетнойЗаписи(УчетнаяЗапись) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Отбор = Новый Структура("Ключ", Строка(УчетнаяЗапись.УникальныйИдентификатор()));
	НайденныеЗадания = РегламентныеЗаданияСервер.НайтиЗадания(Отбор);
	
	Для Каждого Задание Из НайденныеЗадания Цикл
		РегламентныеЗаданияСервер.УдалитьЗадание(Задание.УникальныйИдентификатор);
	КонецЦикла;	
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСИнтернетПочтой

Функция ПолучитьПочтовоеСоединение(ПочтовыйПрофиль) Экспорт
	
	ПочтовоеСоединение = Неопределено;
	Попытка
		ПочтовоеСоединение = Новый ИнтернетПочта;
		ПочтовоеСоединение.Подключиться(ПочтовыйПрофиль, ПротоколИнтернетПочты.POP3);
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		ЗаписьЖурналаРегистрации(
			НСтр("ru = 'Электронный документооборот с контролирующими органами. Почтовое соединение'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ВызватьИсключение;
	КонецПопытки;
	
	Возврат ПочтовоеСоединение;

КонецФункции

Функция ОткрытьСоединениеДляПолученияПочты(ПараметрыПодключения) Экспорт
	
	ПочтовыйПрофиль = Новый ИнтернетПочтовыйПрофиль;
	
	ПочтовыйПрофиль.АдресСервераPOP3   = ПараметрыПодключения.POP3.Сервер;
	ПочтовыйПрофиль.ПортPOP3           = ПараметрыПодключения.POP3.Порт;
	ПочтовыйПрофиль.АутентификацияPOP3 = ПараметрыПодключения.POP3.СпособАутентификации;
	ПочтовыйПрофиль.Пользователь       = ПараметрыПодключения.POP3.Пользователь;	
	ПочтовыйПрофиль.Пароль             = ПараметрыПодключения.POP3.Пароль;
	
	ПочтовыйПрофиль.Таймаут = ПараметрыПодключения.Таймаут;
	
	Соединение = ПолучитьПочтовоеСоединение(ПочтовыйПрофиль);
	
	Возврат Соединение;
	
КонецФункции

Функция ОткрытьСоединениеДляОтправкиПочты(ПараметрыПодключения) Экспорт
	
	ПочтовыйПрофиль = Новый ИнтернетПочтовыйПрофиль;

	ПочтовыйПрофиль.АдресСервераSMTP   = ПараметрыПодключения.SMTP.Сервер;
	ПочтовыйПрофиль.ПортSMTP           = ПараметрыПодключения.SMTP.Порт;
	ПочтовыйПрофиль.АутентификацияSMTP = ПараметрыПодключения.SMTP.СпособАутентификации;
	ПочтовыйПрофиль.ПользовательSMTP   = ПараметрыПодключения.SMTP.Пользователь;	
	ПочтовыйПрофиль.ПарольSMTP         = ПараметрыПодключения.SMTP.Пароль;
	
	ПочтовыйПрофиль.Таймаут = ПараметрыПодключения.Таймаут;
	
	Соединение = ПолучитьПочтовоеСоединение(ПочтовыйПрофиль);
	
	Возврат Соединение;
	
КонецФункции

Процедура ЗакрытьПочтовоеСоединение(ПочтовоеСоединение) Экспорт
	
	ПочтовоеСоединение.Отключиться();
	
КонецПроцедуры

#КонецОбласти

#Область ПереносТранспортныхСообщенийВПрисоединенныеФайлы

Процедура ПеренестиТранспортныеСообщенияВПрисоединенныеФайлы() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(Метаданные.РегламентныеЗадания.ПереносСообщений1СОтчетностиВПрисоединенныеФайлы);
	
	ОбработкаЭДО = ДокументооборотСКОВызовСервера.ПолучитьОбработкуЭДО();
	Если ОбработкаЭДО.ПеренестиТранспортныеСообщенияВПрисоединенныеФайлы() Тогда
		УстановитьПривилегированныйРежим(Истина);
		РегламентныеЗаданияСервер.УдалитьЗадание(Метаданные.РегламентныеЗадания.ПереносСообщений1СОтчетностиВПрисоединенныеФайлы);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область СлужебныеОбработчики

// Процедура, необходимая срабатывания рег задания по отслеживанию заявлений
// в модели сервиса как элемента очереди заданий.
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.ОбработкаЗаявленийАбонента.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.ОбменСКонтролирующимиОрганами.ИмяМетода);
	СоответствиеИменПсевдонимам.Вставить(Метаданные.РегламентныеЗадания.ПереносСообщений1СОтчетностиВПрисоединенныеФайлы.ИмяМетода);
	
КонецПроцедуры

// Определяет следующие свойств регламентных заданий:
//  - зависимость от функциональных опций.
//  - возможность выполнения в различных режимах работы программы.
//  - прочие параметры.
//
// Параметры:
//  Настройки - ТаблицаЗначений - таблица значений с колонками:
//    * РегламентноеЗадание - ОбъектМетаданных:РегламентноеЗадание - регламентное задание.
//    * ФункциональнаяОпция - ОбъектМетаданных:ФункциональнаяОпция - функциональная опция,
//        от которой зависит регламентное задание.
//    * ЗависимостьПоИ      - Булево - если регламентное задание зависит более, чем
//        от одной функциональной опции и его необходимо включать только тогда,
//        когда все функциональные опции включены, то следует указывать Истина
//        для каждой зависимости.
//        По умолчанию Ложь - если хотя бы одна функциональная опция включена,
//        то регламентное задание тоже включено.
//    * ВключатьПриВключенииФункциональнойОпции - Булево, Неопределено - если Ложь, то при
//        включении функциональной опции регламентное задание не будет включаться. Значение
//        Неопределено соответствует значению Истина.
//        По умолчанию - неопределено.
//    * ДоступноВПодчиненномУзлеРИБ - Булево, Неопределено - Истина или Неопределено, если регламентное
//        задание доступно в РИБ.
//        По умолчанию - неопределено.
//    * ДоступноВАвтономномРабочемМесте - Булево, Неопределено - Истина или Неопределено, если регламентное
//        задание доступно в автономном рабочем месте.
//        По умолчанию - неопределено.
//    * ДоступноВМоделиСервиса      - Булево, Неопределено - Истина или Неопределено, если регламентное
//        задание доступно в модели сервиса.
//        По умолчанию - неопределено.
//    * РаботаетСВнешнимиРесурсами  - Булево - Истина, если регламентное задание модифицирует данные
//        во внешних источниках (получение почты, синхронизация данных и т.п.).
//        По умолчанию - Ложь.
//    * Параметризуется             - Булево - Истина, если регламентное задание параметризованное.
//        По умолчанию - Ложь.
//
// Например:
//	Настройка = Настройки.Добавить();
//	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.ОбновлениеСтатусовДоставкиSMS;
//	Настройка.ФункциональнаяОпция = Метаданные.ФункциональныеОпции.ИспользоватьПочтовыйКлиент;
//	Настройка.ДоступноВМоделиСервиса = Ложь;
//
Процедура ПриОпределенииНастроекРегламентныхЗаданий(Настройки) Экспорт
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.ОбменСКонтролирующимиОрганами;
	Настройка.РаботаетСВнешнимиРесурсами = Истина;
	Настройка.Параметризуется = Истина;
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.ОбработкаЗаявленийАбонента;
	Настройка.РаботаетСВнешнимиРесурсами = Истина;
	Настройка.Параметризуется = Истина;
	
КонецПроцедуры

#КонецОбласти

Процедура ОтключитьПриНеобходимостиАвтоматическийОбмен(УчетнаяЗапись)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Организации.Ссылка
	|ИЗ
	|	Справочник.Организации КАК Организации
	|ГДЕ
	|	Организации.УчетнаяЗаписьОбмена = &УчетнаяЗапись
	|	И НЕ Организации.ПометкаУдаления
	|	И Организации.ВидОбменаСКонтролирующимиОрганами = ЗНАЧЕНИЕ(Перечисление.ВидыОбменаСКонтролирующимиОрганами.ОбменВУниверсальномФормате)";
		
	Запрос.УстановитьПараметр("УчетнаяЗапись", УчетнаяЗапись);
	
	Если Запрос.Выполнить().Пустой() ИЛИ УчетнаяЗапись.ПометкаУдаления Тогда
		ОтключитьОбменПоУчетнойЗаписи(УчетнаяЗапись);
	КонецЕсли;	
	
КонецПроцедуры

Функция ПолучитьИнтервалВыполненияОбмена(УчетнаяЗапись)
	
	Если ДокументооборотСКОВызовСервера.ИспользуетсяРежимТестирования() Тогда
		Интервал = 90;
	Иначе
		Интервал = 3600;
	КонецЕсли;
	
	Возврат Интервал;
	
КонецФункции

#КонецОбласти