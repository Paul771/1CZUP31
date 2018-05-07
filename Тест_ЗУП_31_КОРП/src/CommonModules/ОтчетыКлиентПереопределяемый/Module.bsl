#Область ПрограммныйИнтерфейс

// Возникает перед началом формирования отчета.
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   Отказ - Булево - Если установить в значение Истина, то процесс формирования отчета будет остановлен.
//       Для перезапуска процесса формирования
//       рекомендуется использовать процедуру ОтчетыКлиент.СформироватьОтчет().
//
Процедура ПередФормированием(ФормаОтчета, Отказ) Экспорт
	
КонецПроцедуры

// Возникает после окончания формирования отчета.
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   ОтчетСформирован - Булево - Истина если отчет был успешно сформирован.
//
Процедура ПослеФормирования(ФормаОтчета, ОтчетСформирован) Экспорт
	
КонецПроцедуры

// Обработчик расшифровки табличного документа формы отчета.
// См. "Расширение поля формы для поля табличного документа.ОбработкаРасшифровки" в синтакс-помощнике.
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   Элемент     - ПолеФормы        - Табличный документ.
//   Расшифровка - Произвольный     - Значение расшифровки точки, серии или значения диаграммы.
//   СтандартнаяОбработка - Булево  - Признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаРасшифровки(ФормаОтчета, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт
	
	// ИнтернетПоддержкаПользователей
	ИнтернетПоддержкаПользователейКлиент.ОбработкаРасшифровки(ФормаОтчета, Элемент, Расшифровка, СтандартнаяОбработка);
	// Конец ИнтернетПоддержкаПользователей
	
КонецПроцедуры

// Обработчик дополнительной расшифровки (меню табличного документа формы отчета).
// См. "Расширение поля формы для поля табличного документа.ОбработкаДополнительнойРасшифровки" в синтакс-помощнике.
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   Элемент     - ПолеФормы        - Табличный документ.
//   Расшифровка - Произвольный     - Значение расшифровки точки, серии или значения диаграммы.
//   СтандартнаяОбработка - Булево  - Признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаДополнительнойРасшифровки(ФормаОтчета, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Обработчик команд, добавленных динамически и подключенных к обработчику "Подключаемый_Команда".
// Пример добавления команды см. ОтчетыПереопределяемый.ПриСозданииНаСервере().
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   Команда     - КомандаФормы     - Команда, которая была вызвана.
//   Результат   - Булево           - Истина, если вызов команды обработан.
//
Процедура ОбработчикКоманды(ФормаОтчета, Команда, Результат) Экспорт
	
	
	
КонецПроцедуры

// Обработчик результата выбора подчиненной формы.
// См. "УправляемаяФорма.ОбработкаВыбора" в синтакс-помощнике.
//
// Параметры:
//   ФормаОтчета       - УправляемаяФорма - Форма отчета.
//   ВыбранноеЗначение - Произвольный     - Результат выбора в подчиненной форме.
//   ИсточникВыбора    - УправляемаяФорма - Форма, где осуществлен выбор.
//   Результат         - Булево           - Истина, если результат выбора обработан.
//
Процедура ОбработкаВыбора(ФормаОтчета, ВыбранноеЗначение, ИсточникВыбора, Результат) Экспорт
	
	
КонецПроцедуры

// Обработчик двойного щелчка мыши, нажатия клавиши Enter или гиперссылки в табличном документе формы отчета.
// См. "Расширение поля формы для поля табличного документа.Выбор" в синтакс-помощнике.
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   Элемент     - ПолеФормы        - Табличный документ.
//   Область     - ОбластьЯчеекТабличногоДокумента - Выбранное значение.
//   СтандартнаяОбработка - Булево - Признак выполнения стандартной обработки события.
//
Процедура ОбработкаВыбораТабличногоДокумента(ФормаОтчета, Элемент, Область, СтандартнаяОбработка) Экспорт
	
	// ИнтернетПоддержкаПользователей
	ИнтернетПоддержкаПользователейКлиент.ОбработкаВыбораТабличногоДокумента(ФормаОтчета, Элемент, Область, СтандартнаяОбработка);
	// Конец ИнтернетПоддержкаПользователей
	
КонецПроцедуры

// Обработчик широковещательного оповещения формы отчета.
// См. "УправляемаяФорма.ОбработкаОповещения" в синтакс-помощнике.
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   ИмяСобытия  - Строка           - Идентификатор события для принимающих форм.
//   Параметр    - Произвольный     - Расширенная информация о событии.
//   Источник    - УправляемаяФорма, Произвольный - Источник события.
//   ОповещениеОбработано - Булево - Признак того, что событие обработано.
//
Процедура ОбработкаОповещения(ФормаОтчета, ИмяСобытия, Параметр, Источник, ОповещениеОбработано) Экспорт
	
КонецПроцедуры

// Обработчик нажатия на кнопку выбора периода в отдельной форме.
//
// Параметры:
//   ФормаОтчета - УправляемаяФорма - Форма отчета.
//   Период - СтандартныйПериод - Значение настройки компоновщика, соответствующей выбранному периоду.
//   СтандартнаяОбработка - Булево - Если Истина, то будет использован стандартный диалог выбора периода.
//       Если установить в Ложь то стандартный диалог не откроется.
//   ОбработчикРезультата - ОписаниеОповещения - Обработчик результата выбора периода.
//       В качестве результата в ОбработчикРезультата могут быть переданы значения типов:
//       Неопределено - Пользователь отказался от ввода периода.
//       СтандартныйПериод - Выбранный период.
//
//  Если в конфигурации используется собственный диалог выбора периода,
//      тогда параметр СтандартнаяОбработка следует установить в Ложь,
//      а выбранный период следует вернуть в ОбработчикРезультата.
//
Процедура ПриНажатииКнопкиВыбораПериода(ФормаОтчета, Период, СтандартнаяОбработка, ОбработчикРезультата) Экспорт
	
КонецПроцедуры

#КонецОбласти
