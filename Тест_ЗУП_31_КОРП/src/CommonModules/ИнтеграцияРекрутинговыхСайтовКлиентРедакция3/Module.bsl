
#Область СлужебныеПроцедурыИФункции

Процедура ПолучитьОтклики(Сайт, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ПолучитьОткликиАвторизацияЗавершение", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	Авторизация(Сайт, Оповещение);

КонецПроцедуры

Процедура ОткрытьФормуКандидата(ПараметрыФормы, СтруктураДанныхКандидатаССайта, Сайт, Вакансия) Экспорт
	
	ПараметрыФормы.Вставить("СтруктураРезюме", СтруктураДанныхКандидатаССайта);
	ПараметрыФормы.Вставить("Сайт", Сайт);
	ПараметрыФормы.Вставить("Вакансия", Вакансия);

	ОткрытьФорму("Справочник.Кандидаты.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

Процедура ЗагрузитьВакансииССайта(Сайт, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьВакансииССайтаАвторизацияЗавершение", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	Авторизация(Сайт, Оповещение);    
	
КонецПроцедуры

Процедура ОпубликоватьНаСайте(Сайт, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ОпубликоватьНаСайтеАвторизацияЗавершение", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	Авторизация(Сайт, Оповещение);
	
КонецПроцедуры

Процедура АвторизацияНаСайте(Сайт, ИмяПользователя, Пароль, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("АвторизацияЗавершение", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	Авторизация(Сайт, Оповещение, ИмяПользователя, Пароль);
	
КонецПроцедуры

Процедура ОткрытьФормуАвторизации(Форма, Сайт) Экспорт
	
	ДополнительныеПараметры = Новый Структура("Сайт", Сайт);
	Оповещение = Новый ОписаниеОповещения("АвторизацияЗавершение", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	
	Если Сайт = ИнтеграцияРекрутинговыхСайтовКлиентСервер.HeadHunter() Тогда
		ОткрытьФормуАвторизацииHeadHunter(Форма, Оповещение);
	Иначе
		ВыполнитьОбработкуОповещения(Оповещение, Ложь);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОтобразитьПредупреждение(ТекстПредупреждения) Экспорт
	
	ПоказатьПредупреждение(, ТекстПредупреждения);
	
КонецПроцедуры

Процедура АвторизацияИЗагрузкаКлассификаторовССайта(Сайт, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузкаКлассификаторовАвторизацияЗавершение", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	Авторизация(Сайт, Оповещение);
	
КонецПроцедуры

Процедура СоздатьКандидатаПоСсылкеЗавершениеВводаСтроки(Сайт, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("СоздатьКандидатаПоСсылкеАвторизацияЗавершение", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	Авторизация(Сайт, Оповещение);
	
КонецПроцедуры

Процедура СоздатьКандидатаПоСсылке(СтрокаИзБуфера, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("СоздатьКандидатаПоСсылкеЗавершениеВводаСтроки", ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияРекрутинговыхСайтовКлиент"), ДополнительныеПараметры);
	ПоказатьВводСтроки(Оповещение, СтрокаИзБуфера, НСтр("ru = 'Введите веб-адрес резюме кандидата'"));
	
КонецПроцедуры

Функция ОткрытьФормуОбработки(ИмяФормы, ПараметрыФормы, Владелец, Оповещение = Неопределено, Модально = Ложь) Экспорт
	
	ОткрытьФорму(ИмяФормы, ПараметрыФормы, Владелец, Истина, , , Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Возврат Неопределено;
	
КонецФункции

Процедура Авторизация(Сайт, Оповещение, ИмяПользователя = Неопределено, Пароль = Неопределено) 
	
	Если Сайт = ИнтеграцияРекрутинговыхСайтовКлиентСервер.RabotaMail() Тогда
		СайтДляПроверкиДоступа = ИнтеграцияРекрутинговыхСайтовКлиентСервер.HeadHunter() 
	Иначе
		СайтДляПроверкиДоступа = Сайт;
	КонецЕсли;
	
	МаркерДоступаАктивен = ИнтеграцияРекрутинговыхСайтовКлиент.МаркерДоступаАктивен(СайтДляПроверкиДоступа, ИмяПользователя);
	
	Если МаркерДоступаАктивен Тогда
		ВыполнитьОбработкуОповещения(Оповещение, Истина);
	Иначе
		ВыполнитьАвторизацию(ЭтотОбъект, СайтДляПроверкиДоступа, Оповещение, ИмяПользователя, Пароль);
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьАвторизацию(Форма, Сайт, Оповещение, ИмяПользователя = Неопределено, Пароль = Неопределено) 
	
	Если Сайт = ИнтеграцияРекрутинговыхСайтовКлиентСервер.HeadHunter() Тогда
		
		ОткрытьФормуАвторизацииHeadHunter(Форма, Оповещение);
		
	ИначеЕсли Сайт = ИнтеграцияРекрутинговыхСайтовКлиентСервер.Rabota() Тогда
		
		Результат = ИнтеграцияРекрутинговыхСайтовВызовСервера.АвторизацияRabota(Сайт, ИмяПользователя, Пароль);
		ВыполнитьОбработкуОповещения(Оповещение, Результат <> Неопределено);
	
	ИначеЕсли Сайт = ИнтеграцияРекрутинговыхСайтовКлиентСервер.SuperJob() Тогда
		
		Результат = ИнтеграцияРекрутинговыхСайтовВызовСервера.АвторизацияSuperJob(Сайт, ИмяПользователя, Пароль);
		ВыполнитьОбработкуОповещения(Оповещение, Результат <> Неопределено);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОткрытьФормуАвторизацииHeadHunter(Форма, Оповещение)
	
	ОткрытьФорму("Обработка.АвторизацияНаРекрутинговыхСайтах.Форма.ФормаАвторизацииHeadHunter", , Форма, ,  , , Оповещение, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	
КонецПроцедуры

Процедура РегионНажатие(Форма, СтруктураПараметров) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("РегионНачалоВыбораЗавершение", Форма);
	ОткрытьФорму("Обработка.ПубликацияВакансийНаРекрутинговыхСайтах.Форма.ВыборИзДереваЗначений", СтруктураПараметров, Форма,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);  	
	
КонецПроцедуры

Процедура НачалоОдиночногоВыбораИзСписка(Форма, СписокВыбора, ДополнительныеПараметры) Экспорт
	
	Оповещение  = Новый ОписаниеОповещения("ВыборИзСпискаЗавершение", Форма, ДополнительныеПараметры);
	Форма.ПоказатьВыборИзСписка(Оповещение, СписокВыбора);
	
КонецПроцедуры

Процедура НайтиВДлительнойОперации(Форма, ФормаДлительнойОперации, Результат, АдресХранилища, ПараметрыОбработчикаОжидания, ИдентификаторЗадания) Экспорт
	
	Если Не Результат.Статус = "Выполнено" Тогда
		
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		АдресХранилища		 = Результат.АдресРезультата;
		
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		Форма.ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ФормаДлительнойОперации = ДлительныеОперацииКлиент.ОткрытьФормуДлительнойОперации(Форма, ИдентификаторЗадания);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура КомандаПоискРезюмеВИнтернете(ПараметрКоманды, ПараметрыВыполненияКоманды) Экспорт
	
	ОткрытьФорму("Обработка.ПоискРезюмеВИнтернете.Форма", , ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры

Процедура КомандаПоискРезюмеВИнтернетеПоВакансии(ПараметрКоманды, ПараметрыВыполненияКоманды) Экспорт
	
	ПараметрыФормы = Новый Структура;
	
	НаименованиеВакансии = Строка(ПараметрКоманды);
	ПозицияСимвола = 0;
	ПозицияСимвола = СтрНайти(НаименованиеВакансии, "/");
	НаименованиеВакансии = Лев(НаименованиеВакансии, ?(ПозицияСимвола = 0, СтрДлина(НаименованиеВакансии), ПозицияСимвола - 1)); 
	
	ПараметрыФормы.Вставить("КлючевоеСлово",  НаименованиеВакансии);
	ПараметрыФормы.Вставить("Вакансия", ПараметрКоманды);
		
	ОткрытьФорму("Обработка.ПоискРезюмеВИнтернете.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры

Процедура КомандаОбновитьПубликацию(Форма) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ПредупреждениеОбУспешнойПубликацииЗавершение", Форма);
	ПоказатьПредупреждение(Оповещение, НСтр("ru = 'Обновление вакансии прошло успешно.'"));
	
КонецПроцедуры

Процедура КомандаОпубликовать(Форма) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ПредупреждениеОбУспешнойПубликацииЗавершение", Форма);
	ПоказатьПредупреждение(Оповещение, НСтр("ru = 'Публикация вакансии прошла успешно.'"));
	
КонецПроцедуры

Процедура ВыборИзДереваЗначений(Форма, СтруктураПараметров, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ВыборИзДереваЗначенийЗавершение", Форма, ДополнительныеПараметры);
	ОткрытьФорму("Обработка.ПубликацияВакансийНаРекрутинговыхСайтах.Форма.ВыборИзДереваЗначений", СтруктураПараметров, Форма,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОдиночныйВыборИзСписка(Форма, ДополнительныеПараметры) Экспорт
	
	Оповещение  = Новый ОписаниеОповещения("ПоказатьВыборЭлементаЗавершение", Форма, ДополнительныеПараметры);
	Форма.ПоказатьВыборИзСписка(Оповещение, ДополнительныеПараметры.СписокВыбора, , ?(ТипЗнч(ДополнительныеПараметры.ТекущиеДанные.ПубликацияВакансии) = Тип("СписокЗначений") И ДополнительныеПараметры.ТекущиеДанные.ПубликацияВакансии.Количество() > 0, ДополнительныеПараметры.СписокВыбора.НайтиПоЗначению(ДополнительныеПараметры.ТекущиеДанные.ПубликацияВакансии[0].Значение), Неопределено));
		
КонецПроцедуры

Процедура МножественныйВыборИзСписка(Форма, ДополнительныеПараметры) Экспорт
	
	Оповещение  = Новый ОписаниеОповещения("ПоказатьОтметкуЭлементовЗавершение", Форма, ДополнительныеПараметры);
	ДополнительныеПараметры.СписокВыбора.ПоказатьОтметкуЭлементов(Оповещение, НСтр("ru = 'Выберите'") + " " + ДополнительныеПараметры.ТекущиеДанные.Показатель);
	
КонецПроцедуры

Процедура РедактированиеМногострочногоТекста(Форма, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("РедактированиеМногострочногоТекстаЗавершение", Форма, ДополнительныеПараметры);
	ПоказатьВводСтроки(Оповещение, ДополнительныеПараметры.ТекущиеДанные.ПубликацияВакансииТекст, НСтр("ru = 'Введите'") + " " + ДополнительныеПараметры.ТекущиеДанные.Показатель, 10000, Истина);
	
КонецПроцедуры

Процедура РедактированиеУровняВладенияЯзыками(Форма, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ОткрытьСпециальнуюФормуРедактированияУровняВладенияЯзыкамиЗавершение", Форма, ДополнительныеПараметры);
	ИнтеграцияРекрутинговыхСайтовКлиент.ОткрытьСпециальнуюФормуРедактированияСписка(Форма, ДополнительныеПараметры.ТекущиеДанные.Путь, ДополнительныеПараметры.СписокЯзыков, Оповещение, ДополнительныеПараметры.Сайт);
	
КонецПроцедуры

Процедура РедактированияСпискаТелефонов(Форма, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("ОткрытьСпециальнуюФормуРедактированияСпискаТелефоновЗавершение", Форма, ДополнительныеПараметры);
	ИнтеграцияРекрутинговыхСайтовКлиент.ОткрытьСпециальнуюФормуРедактированияСписка(Форма, ДополнительныеПараметры.ТекущиеДанные.Путь, ДополнительныеПараметры.СписокТелефонов, Оповещение);
	
КонецПроцедуры

Процедура РедактированиеТекстаВHTML(Форма, ДополнительныеПараметры) Экспорт
	
	Оповещение = Новый ОписаниеОповещения("РедактированиеТекстаВHTMLЗавершение", Форма, ДополнительныеПараметры);
	ИнтеграцияРекрутинговыхСайтовКлиент.ОткрытьФормуРедактированияТекстаВHTML(Форма, ДополнительныеПараметры.ТекущиеДанные.Показатель, ДополнительныеПараметры.ТекущиеДанные.ПубликацияВакансииТекст, Оповещение);
	
КонецПроцедуры

Процедура НачалоВыбораЗначения(Форма, ДополнительныеПараметры) Экспорт
	
	Оповещение  = Новый ОписаниеОповещения("ПоказатьВыборЭлементаЗавершение", Форма, ДополнительныеПараметры);
	ДополнительныеПараметры.СписокВыбора.ПоказатьВыборЭлемента(Оповещение, НСтр("ru = 'Выберите'") + " " + ДополнительныеПараметры.ИмяЭлемента, ?(ТипЗнч(ДополнительныеПараметры.ТекущиеДанные[ДополнительныеПараметры.ИмяЭлемента]) = Тип("СписокЗначений") И ДополнительныеПараметры.ТекущиеДанные[ДополнительныеПараметры.ИмяЭлемента].Количество() > 0, ДополнительныеПараметры.СписокВыбора.НайтиПоЗначению(ДополнительныеПараметры.ТекущиеДанные[ДополнительныеПараметры.ИмяЭлемента][0].Значение), Неопределено));
	
КонецПроцедуры

#КонецОбласти
