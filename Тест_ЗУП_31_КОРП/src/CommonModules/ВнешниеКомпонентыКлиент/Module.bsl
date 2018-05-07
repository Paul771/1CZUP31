#Область ПрограммныйИнтерфейс

// Возвращает структуру параметров для см. процедуру ПодключитьКомпоненту.
//
// Возвращаемое значение:
//  Структура - коллекция параметров:
//      * Кэшировать           - Булево - (по умолчанию Истина) использовать механизм кэширования компонент на клиенте.
//      * ПредложитьУстановить - Булево - (по умолчанию Истина) предлагать устанавливать и обновлять компоненту.
//      * ТекстПояснения       - Строка - для чего нужна компонента и что не будет работать, если ее не устанавливать.
//      * ИдентификаторыСозданияОбъектов - Массив - идентификатор создания экземпляра модуля объекта,
//                 используется только для компонент, у которых есть несколько идентификаторов создания объектов,
//                 при задании параметр Идентификатор будет использоваться только для определения компоненты.
//
// Пример:
//
//  ПараметрыПодключения = ВнешниеКомпонентыКлиент.ПараметрыПодключения();
//  ПараметрыПодключения.ТекстПояснения = НСтр("ru = 'Для использования сканера штрихкодов требуется
//                                             |внешняя компонента «1С:Сканеры штрихкода (NativeApi)».'");
//
Функция ПараметрыПодключения() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Кэшировать", Истина);
	Параметры.Вставить("ПредложитьУстановить", Истина);
	Параметры.Вставить("ТекстПояснения", "");
	Параметры.Вставить("ИдентификаторыСозданияОбъектов", Новый Массив);
	
	Возврат Параметры;
	
КонецФункции

// Подключает компоненту, выполненную по технологии Native API и COM асинхронном режиме.
// Для веб-клиента предлагается диалог, подсказывающий пользователю действия по установке.
// Выполняет проверку возможности исполнения компоненты на текущем клиенте пользователя.
//
// Параметры:
//  Оповещение - ОписаниеОповещения - Описание оповещения о подключении со следующими параметрами:
//      * Результат - Структура - результат подключения компоненты:
//          ** Подключено         - Булево - признак подключения.
//          ** ПодключаемыйМодуль - AddIn  - экземпляр объекта внешней компоненты;
//                                - ФиксированноеСоответствие - экземпляры объектов внешней компоненты, 
//                                     указанные в ПараметрыПодключения.ИдентификаторыСозданияОбъектов,
//                                     Ключ - Идентификатор, Значение - экземпляр объекта.
//          ** ОписаниеОшибки     - Строка - краткое описание ошибки. При отмене пользователем пустая строка.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  Идентификатор        - Строка                  - идентификатор объекта внешней компоненты.
//  Версия               - Строка, Неопределено    - версия компоненты.
//  ПараметрыПодключения - Структура, Неопределено - см. функцию ПараметрыПодключения.
//
// Пример:
//
//  Оповещение = Новый ОписаниеОповещения("ПодключитьКомпонентуЗавершение", ЭтотОбъект);
//
//  ПараметрыПодключения = ВнешниеКомпонентыКлиент.ПараметрыПодключения();
//  ПараметрыПодключения.ТекстПояснения = НСтр("ru = 'Для использования сканера штрихкодов требуется
//                                             |внешняя компонента «1С:Сканеры штрихкода (NativeApi)».'");
//
//  ВнешниеКомпонентыКлиент.ПодключитьКомпоненту(Оповещение, "InputDevice",, ПараметрыПодключения);
//
//  &НаКлиенте
//  Процедура ПодключитьКомпонентуЗавершение(Результат, ДополнительныеПараметры) Экспорт
//
//      ПодключаемыйМодуль = Неопределено;
//
//      Если Результат.Подключено Тогда 
//          ПодключаемыйМодуль = Результат.ПодключаемыйМодуль;
//      Иначе
//          Если Не ПустаяСтрока(Результат.ОписаниеОшибки) Тогда
//              ПоказатьПредупреждение(, Результат.ОписаниеОшибки);
//          КонецЕсли;
//      КонецЕсли;
//
//      Если ПодключаемыйМодуль <> Неопределено Тогда 
//          // ПодключаемыйМодуль содержит созданный экземпляр подключенной компоненты.
//      КонецЕсли;
//
//      ПодключаемыйМодуль = Неопределено;
//
//  КонецПроцедуры
//
Процедура ПодключитьКомпоненту(Оповещение, Идентификатор, Версия = Неопределено,
	ПараметрыПодключения = Неопределено) Экспорт
	
	// Для переводчиков: должно быть названо AttachAddInEx потому что AttachAddIn зарезервировано платформой.
	
	Параметры = ПараметрыПодключения();
	Если ПараметрыПодключения <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Параметры, ПараметрыПодключения);
	КонецЕсли;
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение", Оповещение);
	Контекст.Вставить("Идентификатор", Идентификатор);
	Контекст.Вставить("Кэшировать", Параметры.Кэшировать);
	Контекст.Вставить("ПредложитьУстановить", Параметры.ПредложитьУстановить);
	Контекст.Вставить("ТекстПояснения", Параметры.ТекстПояснения);
	Контекст.Вставить("ИдентификаторыСозданияОбъектов", Параметры.ИдентификаторыСозданияОбъектов);
	
	ДлительнаяОперация = ВнешниеКомпонентыСлужебныйВызовСервера.НачатьПодготовкуКомпонентыКПодключению(
		Идентификатор, Версия);
	
	// В случае, если пользователь закроет форму адрес результата потеряется и 
	// будет невозможно освободить память, потому адрес результата помещаем в контекст.
	Контекст.Вставить("АдресРезультатаПодготовкиКомпоненты", ДлительнаяОперация.АдресРезультата);
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Неопределено);
	ПараметрыОжидания.ТекстСообщения = НСтр("ru = 'Подготовка компоненты...'");
	ПараметрыОжидания.ВыводитьОкноОжидания = Истина;
	
	Оповещение = Новый ОписаниеОповещения("ПодключитьКомпонентуПослеПодготовки",
		ВнешниеКомпонентыСлужебныйКлиент, Контекст);
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Оповещение, ПараметрыОжидания);
	
КонецПроцедуры

// Подключает компоненту, выполненную по технологии COM, из реестре Windows в асинхронном режиме.
// (не рекомендуется, для обратной совместимости с компонентами 1С 7.7). 
//
// Параметры:
//  Оповещение - ОписаниеОповещения - Описание оповещения о подключении со следующими параметрами:
//      * Результат - Структура - результат подключения компоненты:
//          ** Подключено         - Булево - признак подключения.
//          ** ПодключаемыйМодуль - AddIn  - экземпляр объекта внешней компоненты.
//          ** ОписаниеОшибки     - Строка - краткое описание ошибки.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  Идентификатор                - Строка               - идентификатор объекта внешней компоненты.
//  ИдентификаторСозданияОбъекта - Строка, Неопределено - идентификатор создания экземпляра модуля объекта
//                 (только для компонент, у которых идентификатор создания объекта отличается от ProgID).
//
// Пример:
//
//  Оповещение = Новый ОписаниеОповещения("ПодключитьКомпонентуЗавершение", ЭтотОбъект);
//
//  ВнешниеКомпонентыКлиент.ПодключитьКомпонентуИзРеестраWindows(Оповещение, "SBRFCOMObject", "SBRFCOMExtension");
//
//  &НаКлиенте
//  Процедура ПодключитьКомпонентуЗавершение(Результат, ДополнительныеПараметры) Экспорт
//
//      ПодключаемыйМодуль = Неопределено;
//
//      Если Результат.Подключено Тогда 
//          ПодключаемыйМодуль = Результат.ПодключаемыйМодуль;
//      Иначе 
//          ПоказатьПредупреждение(, Результат.ОписаниеОшибки);
//      КонецЕсли;
//
//      Если ПодключаемыйМодуль <> Неопределено Тогда 
//          // ПодключаемыйМодуль содержит созданный экземпляр подключенной компоненты.
//      КонецЕсли;
//
//      ПодключаемыйМодуль = Неопределено;
//
//  КонецПроцедуры
//
Процедура ПодключитьКомпонентуИзРеестраWindows(Оповещение, Идентификатор,
	ИдентификаторСозданияОбъекта = Неопределено) Экспорт 
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение"                  , Оповещение);
	Контекст.Вставить("Идентификатор"               , Идентификатор);
	Контекст.Вставить("ИдентификаторСозданияОбъекта", ИдентификаторСозданияОбъекта);
	
	ВнешниеКомпонентыСлужебныйКлиент.ПодключитьКомпонентуИзРеестраWindows(Контекст);
	
КонецПроцедуры

// Возвращает структуру параметров для см. процедуру УстановитьКомпоненту.
//
// Возвращаемое значение:
//  Структура - коллекция параметров:
//      * ТекстПояснения - Строка - для чего нужна компонента и что не будет работать, если ее не устанавливать.
//
// Пример:
//
//  ПараметрыУстановки = ВнешниеКомпонентыКлиент.ПараметрыУстановки();
//  ПараметрыУстановки.ТекстПояснения = НСтр("ru = 'Для использования сканера штрихкодов требуется
//                                           |внешняя компонента «1С:Сканеры штрихкода (NativeApi)».'");
//
Функция ПараметрыУстановки() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("ТекстПояснения", "");
	
	Возврат Параметры;
	
КонецФункции

// Устанавливает компоненту, выполненную по технологии Native API и COM асинхронном режиме.
// Выполняет проверку возможности исполнения компоненты на текущем клиенте пользователя.
//
// Параметры:
//  Оповещение - ОписаниеОповещения - Описание оповещения об установке внешней компоненты:
//      * Результат - Структура - результат установки компоненты:
//          ** Установлено    - Булево - признак установки.
//          ** ОписаниеОшибки - Строка - краткое описание ошибки. При отмене пользователем пустая строка.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  Идентификатор      - Строка                  - идентификатор объекта внешней компоненты.
//  Версия             - Строка, Неопределено    - версия компоненты.
//  ПараметрыУстановки - Структура, Неопределено - см. функцию ПараметрыУстановки.
//
// Пример:
//
//  Оповещение = Новый ОписаниеОповещения("УстановитьКомпонентуЗавершение", ЭтотОбъект);
//
//  ПараметрыУстановки = ВнешниеКомпонентыКлиент.ПараметрыУстановки();
//  ПараметрыУстановки.ТекстПояснения = НСтр("ru = 'Для использования сканера штрихкодов требуется
//                                           |внешняя компонента «1С:Сканеры штрихкода (NativeApi)».'");
//
//  ВнешниеКомпонентыКлиент.УстановитьКомпоненту(Оповещение, "InputDevice",, ПараметрыУстановки);
//
//  &НаКлиенте
//  Процедура УстановитьКомпонентуЗавершение(Результат, ДополнительныеПараметры) Экспорт
//
//      Если Не Результат.Установлено И Не ПустаяСтрока(Результат.ОписаниеОшибки) Тогда 
//          ПоказатьПредупреждение(, Результат.ОписаниеОшибки);
//      КонецЕсли;
//
//  КонецПроцедуры
//
Процедура УстановитьКомпоненту(Оповещение, Идентификатор, Версия = Неопределено,
	ПараметрыУстановки = Неопределено) Экспорт
	
	// Для переводчиков: должно быть названо InstallAddInEx потому что InstallAddIn зарезервировано платформой.
		
	Параметры = ПараметрыУстановки();
	Если ПараметрыУстановки <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Параметры, ПараметрыУстановки);
	КонецЕсли;
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение", Оповещение);
	Контекст.Вставить("Идентификатор", Идентификатор);
	Контекст.Вставить("ТекстПояснения", Параметры.ТекстПояснения);
	
	ДлительнаяОперация = ВнешниеКомпонентыСлужебныйВызовСервера.НачатьПодготовкуКомпонентыКПодключению(
		Идентификатор, Версия);
	
	// В случае, если пользователь закроет форму адрес результата потеряется и 
	// будет невозможно освободить память, потому адрес результата помещаем в контекст.
	Контекст.Вставить("АдресРезультатаПодготовкиКомпоненты", ДлительнаяОперация.АдресРезультата);
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Неопределено);
	ПараметрыОжидания.ТекстСообщения = НСтр("ru = 'Подготовка компоненты...'");
	ПараметрыОжидания.ВыводитьОкноОжидания = Истина;
	
	Оповещение = Новый ОписаниеОповещения("УстановитьКомпонентуПослеПодготовки",
		ВнешниеКомпонентыСлужебныйКлиент, Контекст);
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Оповещение, ПараметрыОжидания);
	
КонецПроцедуры

// Возвращает структуру параметров для см. процедуру ЗагрузитьКомпонентуИзФайла.
//
// Возвращаемое значение:
//  Структура - коллекция параметров:
//      * Идентификатор - Строка, Неопределено - идентификатор объекта внешней компоненты.
//      * Версия        - Строка, Неопределено - версия компоненты.
//
// Пример:
//
//  ПараметрыЗагрузки = ВнешниеКомпонентыКлиент.ПараметрыЗагрузки();
//  ПараметрыЗагрузки.Идентификатор = "InputDevice";
//  ПараметрыЗагрузки.Версия        = "8.1.7.10";
//
Функция ПараметрыЗагрузки() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Идентификатор", Неопределено);
	Параметры.Вставить("Версия"       , Неопределено);
	
	Возврат Параметры;
	
КонецФункции

// Загружает файл компоненты в справочник внешних компонент в асинхронном режиме. 
//
// Параметры:
//  Оповещение - ОписаниеОповещения - Описание оповещения об установке внешней компоненты:
//      * Результат - Структура - результат загрузки компоненты:
//          ** Загружена      - Булево - признак загрузки.
//          ** Идентификатор  - Строка - идентификатор объекта внешней компоненты.
//          ** Версия         - Строка - версия загруженной компоненты.
//          ** Наименование   - Строка - наименование загруженной компоненты.
//          ** ОписаниеОшибки - Строка - краткое описание ошибки. При отмене пользователем пустая строка.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  ПараметрыЗагрузки - Структура, Неопределено - см. функцию ПараметрыЗагрузки.
//
// Пример:
//
//  ПараметрыЗагрузки = ВнешниеКомпонентыКлиент.ПараметрыЗагрузки();
//  ПараметрыЗагрузки.Идентификатор = "InputDevice";
//  ПараметрыЗагрузки.Версия        = "8.1.7.10";
//
//  Оповещение = Новый ОписаниеОповещения(
//      "ЗагрузитьКомпонентуИзФайлаПослеЗагрузкиКомпоненты", ЭтотОбъект);
//
//  ВнешниеКомпонентыКлиент.ЗагрузитьКомпонентуИзФайла(Оповещение, ПараметрыЗагрузки);
//
//  &НаКлиенте
//  Процедура ЗагрузитьКомпонентуИзФайлаПослеЗагрузкиКомпоненты(Результат, ДополнительныеПараметры) Экспорт
//
//      Если Результат.Загружено Тогда 
//          Идентификатор = Результат.Идентификатор;
//          Версия        = Результат.Версия;
//      КонецЕсли;
//
//  КонецПроцедуры
//
Процедура ЗагрузитьКомпонентуИзФайла(Оповещение, ПараметрыЗагрузки = Неопределено) Экспорт
	
	Параметры = ПараметрыЗагрузки();
	Если ПараметрыЗагрузки <> Неопределено Тогда 
		ЗаполнитьЗначенияСвойств(Параметры, ПараметрыЗагрузки);
	КонецЕсли;
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение"   , Оповещение);
	Контекст.Вставить("Идентификатор", Параметры.Идентификатор);
	Контекст.Вставить("Версия"       , Параметры.Версия);
	
	ВнешниеКомпонентыСлужебныйКлиент.ЗагрузитьКомпонентуИзФайла(Контекст);
	
КонецПроцедуры

#КонецОбласти