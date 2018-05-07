
#Область СлужебныеПроцедурыИФункции

Функция HeadHunter() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.HeadHunter();
	
КонецФункции

Функция SuperJob() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.SuperJob();
	
КонецФункции

Функция Rabota() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.Rabota();
	
КонецФункции

Функция RabotaMail() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.RabotaMail();
	
КонецФункции

Функция СоответствиеПоФиксированномуСоответствию(ФиксСоответствие) Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.СоответствиеПоФиксированномуСоответствию(ФиксСоответствие);
	
КонецФункции

Функция НайтиВСтроке(СтрокаДляПоиска, ИскомаяСтрока, НаправлениеПоискаЧисло = 1) Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.НайтиВСтроке(СтрокаДляПоиска, ИскомаяСтрока, НаправлениеПоискаЧисло);
	
КонецФункции

Функция ВидОбразованияПоИдентификаторуHeadHunter(Идентификатор) Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.ВидОбразованияПоИдентификаторуHeadHunter(Идентификатор);
	
КонецФункции

Функция ВидОбразованияПоИдентификаторуRabota(Идентификатор) Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.ВидОбразованияПоИдентификаторуRabota(Идентификатор);
	
КонецФункции

Функция ВидОбразованияПоИдентификаторуSuperJob(Идентификатор) Экспорт 
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.ВидОбразованияПоИдентификаторуSuperJob(Идентификатор);
	
КонецФункции

Функция СреднееПолноеОбщееОбразование() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.СреднееПолноеОбщееОбразование();
	
КонецФункции

Функция МужскойПол() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.МужскойПол();
	
КонецФункции

Функция ЖенскийПол() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.ЖенскийПол();
	
КонецФункции

Функция ИмяСправочникаКандидатов() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.ИмяСправочникаКандидатов();
	
КонецФункции

Функция УникальноеИмяРеквизита() Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.УникальноеИмяРеквизита();
	
КонецФункции

Функция ГруппаКнопокДляЗагрузкиССайта(Форма) Экспорт
	
	Возврат ИнтеграцияРекрутинговыхСайтовВнутреннийКлиентСервер.ГруппаКнопокДляЗагрузкиССайта(Форма);
	
КонецФункции

Функция ПоляВакансииСМножественнымВыборомИзДереваHeadHunter() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("specializations.id");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСОдиночнымВыборомИзДереваHeadHunter() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("area.id");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСоСпискомБезКлассификатораHeadHunter() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("key_skills.name");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСОдиночнымВыборомИзСпискаHeadHunter() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("type.id");
	Поля.Добавить("billing_type.id");
	Поля.Добавить("site.id");
	Поля.Добавить("salary.currency");
	Поля.Добавить("experience.id");
	Поля.Добавить("schedule.id");
	Поля.Добавить("address.id");
	Поля.Добавить("manager.id");
	Поля.Добавить("department.id");
	Поля.Добавить("employment.id");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииНедоступныеДляРедактированияHeadHunter() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("salary");
	Поля.Добавить("address");
	Поля.Добавить("contacts"); 
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСТекстомВHTMLHeadHunter() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("description");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция СоответствиеПутиИКлассификатораHeadHunter()
	
	СоответствиеПутиИКлассификатора = Новый Соответствие;
	
	СоответствиеПутиИКлассификатора.Вставить("specializations.id", "specializations");	
	СоответствиеПутиИКлассификатора.Вставить("area.id", "areas");	
	СоответствиеПутиИКлассификатора.Вставить("type.id", "vacancy_type");	
	СоответствиеПутиИКлассификатора.Вставить("billing_type.id", "vacancy_billing_type");
	СоответствиеПутиИКлассификатора.Вставить("site.id", "vacancy_site");
	СоответствиеПутиИКлассификатора.Вставить("salary.currency", "currency");
	СоответствиеПутиИКлассификатора.Вставить("experience.id", "experience");
	СоответствиеПутиИКлассификатора.Вставить("schedule.id", "schedule");
	СоответствиеПутиИКлассификатора.Вставить("address.id", "addresses");
	СоответствиеПутиИКлассификатора.Вставить("manager.id", "managers");
	СоответствиеПутиИКлассификатора.Вставить("department.id", "departments");
	СоответствиеПутиИКлассификатора.Вставить("employment.id", "employment");
	
	Возврат СоответствиеПутиИКлассификатора;
	
КонецФункции

Функция ПоляВакансииСОдиночнымВыборомИзСпискаRabota() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("currency");
	Поля.Добавить("operatingSchedule");
	Поля.Добавить("experienceYearCount");
	Поля.Добавить("education");
	Поля.Добавить("gender");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСМножественнымВыборомИзДереваRabota() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("offerTrades");
	Поля.Добавить("region");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция СоответствиеПутиИКлассификатораRabota()
	
	СоответствиеПутиИКлассификатора = Новый Соответствие;
	
	СоответствиеПутиИКлассификатора.Вставить("offerTrades", "offer_trades");
	СоответствиеПутиИКлассификатора.Вставить("currency", "currencies");
	СоответствиеПутиИКлассификатора.Вставить("region", "regions");
	СоответствиеПутиИКлассификатора.Вставить("operatingSchedule", "operating_schedules");
	СоответствиеПутиИКлассификатора.Вставить("experienceYearCount", "experience");
	СоответствиеПутиИКлассификатора.Вставить("education", "offer_educations");
	СоответствиеПутиИКлассификатора.Вставить("gender", "gender");
	СоответствиеПутиИКлассификатора.Вставить("address", "representations");
	СоответствиеПутиИКлассификатора.Вставить("offerLanguage", "offer_languages");
	СоответствиеПутиИКлассификатора.Вставить("offerLanguageLevel", "offer_language_levels");
	СоответствиеПутиИКлассификатора.Вставить("additionalInformation.drivingLicense", "driving_licence");
	
	Возврат СоответствиеПутиИКлассификатора;
	
КонецФункции

Функция ПоляВакансииСоСпециальнойФормойРедактированияСпискаRabota() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("phones");
	Поля.Добавить("language");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСМножественнымВыборомИзСпискаRabota() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("address");
	Поля.Добавить("additionalInformation.drivingLicense");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииНедоступныеДляРедактированияRabota(ПервичнаяПубликация) Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("additionalInformation");
	
	Если Не ПервичнаяПубликация Тогда
		Поля.Добавить("name");
		Поля.Добавить("region");
	КонецЕсли;
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСТекстомВHTMLRabota() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("description");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция СоответствиеПутиИКлассификатораSuperJob()
	
	СоответствиеПутиИКлассификатора = Новый Соответствие;
	
	СоответствиеПутиИКлассификатора.Вставить("type_of_work", "type_of_work");	
	СоответствиеПутиИКлассификатора.Вставить("place_of_work", "place_of_work");	
	СоответствиеПутиИКлассификатора.Вставить("education", "education");	
	СоответствиеПутиИКлассификатора.Вставить("experience", "experience");
	СоответствиеПутиИКлассификатора.Вставить("maritalstatus", "maritalstatus");
	СоответствиеПутиИКлассификатора.Вставить("children", "children");
	СоответствиеПутиИКлассификатора.Вставить("id_language", "language");
	СоответствиеПутиИКлассификатора.Вставить("level", "lang_level");
	СоответствиеПутиИКлассификатора.Вставить("gender", "gender");
	СоответствиеПутиИКлассификатора.Вставить("id_user", "users");
	СоответствиеПутиИКлассификатора.Вставить("town", "towns");
	СоответствиеПутиИКлассификатора.Вставить("catalogues", "catalogues");
	СоответствиеПутиИКлассификатора.Вставить("driving_licence", "driving_licence");
	СоответствиеПутиИКлассификатора.Вставить("resumesubscription_kwc", "resumesubscription_kwc");
	СоответствиеПутиИКлассификатора.Вставить("resumesubscription_rws", "resumesubscription_rws");
	СоответствиеПутиИКлассификатора.Вставить("published", "published");	   	
			
	Возврат СоответствиеПутиИКлассификатора;
	
КонецФункции

Функция СоответствиеПутиИКлассификатораПоСайту(Сайт) Экспорт
	
	Если Сайт = HeadHunter() 
		Или Сайт = RabotaMail() Тогда
		Возврат СоответствиеПутиИКлассификатораHeadHunter();
	ИначеЕсли Сайт = Rabota() Тогда
		Возврат СоответствиеПутиИКлассификатораRabota();
	ИначеЕсли Сайт = SuperJob() Тогда
		Возврат СоответствиеПутиИКлассификатораSuperJob();
	КонецЕсли;
	
КонецФункции

Функция ПоляВакансииСОдиночнымВыборомИзСпискаSuperJob() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("type_of_work");
	Поля.Добавить("place_of_work");
	Поля.Добавить("education");
	Поля.Добавить("experience");
	Поля.Добавить("maritalstatus");
	Поля.Добавить("children");
	Поля.Добавить("id_language");
	Поля.Добавить("level");
	Поля.Добавить("gender");
	Поля.Добавить("id_user");
	Поля.Добавить("resumesubscription_kwc");
	Поля.Добавить("resumesubscription_rws");
	Поля.Добавить("published");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСоСпециальнойФормойРедактированияСпискаHeadHunter() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("contacts.phones");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция СтруктураОтбораКандидатов() Экспорт
	
	СтруктураОтбораКандидатов = Новый Структура;
	
	СтруктураОтбораКандидатов.Вставить("КлючевоеСлово");
	СтруктураОтбораКандидатов.Вставить("ВозрастОт");
	СтруктураОтбораКандидатов.Вставить("ВозрастДо");
	СтруктураОтбораКандидатов.Вставить("Регион");
	СтруктураОтбораКандидатов.Вставить("УровеньЗарплатыОт");
	СтруктураОтбораКандидатов.Вставить("УровеньЗарплатыДо");
	СтруктураОтбораКандидатов.Вставить("Пол");
	СтруктураОтбораКандидатов.Вставить("УровеньОбразования");
	СтруктураОтбораКандидатов.Вставить("ПериодРазмещения");
	СтруктураОтбораКандидатов.Вставить("ТолькоВНазвании");
	СтруктураОтбораКандидатов.Вставить("СкрыватьРезюмеБезЗарплаты");
			
	Возврат СтруктураОтбораКандидатов;
	
КонецФункции

Функция СоответствиеПолейПоискаКандидатовПрограммыИHeadHunter() Экспорт
	
	СоответствиеПолейПоиска = Новый Соответствие;
	
	СоответствиеПолейПоиска.Вставить("КлючевоеСлово", "text");
	СоответствиеПолейПоиска.Вставить("ВозрастОт", "age_from");
	СоответствиеПолейПоиска.Вставить("ВозрастДо", "age_to");
	СоответствиеПолейПоиска.Вставить("Регион", "area");
	СоответствиеПолейПоиска.Вставить("УровеньЗарплатыОт", "salary_from");
	СоответствиеПолейПоиска.Вставить("УровеньЗарплатыДо", "salary_to");
	СоответствиеПолейПоиска.Вставить("Пол", "gender");
	СоответствиеПолейПоиска.Вставить("УровеньОбразования", "education_level");
	СоответствиеПолейПоиска.Вставить("ПериодРазмещения", "period");
	
	Возврат СоответствиеПолейПоиска;
	
КонецФункции

Функция СоответствиеПолейПоискаКандидатовПрограммыИRabota() Экспорт
	
	СоответствиеПолейПоиска = Новый Соответствие;
	
	СоответствиеПолейПоиска.Вставить("КлючевоеСлово", "qk[]");
	СоответствиеПолейПоиска.Вставить("ВозрастОт", "af");
	СоответствиеПолейПоиска.Вставить("ВозрастДо", "at");
	СоответствиеПолейПоиска.Вставить("Регион", "krl[]");
	СоответствиеПолейПоиска.Вставить("УровеньЗарплатыОт", "sf");
	СоответствиеПолейПоиска.Вставить("УровеньЗарплатыДо", "st");
	СоответствиеПолейПоиска.Вставить("Пол", "sex");
	СоответствиеПолейПоиска.Вставить("УровеньОбразования", "e[]");
	СоответствиеПолейПоиска.Вставить("ПериодРазмещения", "p");
	
	Возврат СоответствиеПолейПоиска;
	
КонецФункции

Функция СоответствиеПолейПоискаКандидатовПрограммыИSuperJob() Экспорт
	
	СоответствиеПолейПоиска = Новый Соответствие;
	
	СоответствиеПолейПоиска.Вставить("КлючевоеСлово", "keyword");
	СоответствиеПолейПоиска.Вставить("ВозрастОт", "age_from");
	СоответствиеПолейПоиска.Вставить("ВозрастДо", "age_to");
	СоответствиеПолейПоиска.Вставить("Регион", "t");
	СоответствиеПолейПоиска.Вставить("УровеньЗарплатыОт", "payment_from");
	СоответствиеПолейПоиска.Вставить("УровеньЗарплатыДо", "payment_to");
	СоответствиеПолейПоиска.Вставить("Пол", "gender");
	СоответствиеПолейПоиска.Вставить("УровеньОбразования", "education");
	СоответствиеПолейПоиска.Вставить("ПериодРазмещения", "period");
	
	Возврат СоответствиеПолейПоиска;
	
КонецФункции

Функция ПоляВакансииСМножественнымВыборомИзДереваSuperJob() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("catalogues");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСОдиночнымВыборомИзДереваSuperJob() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("town");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСоСпециальнойФормойРедактированияСпискаSuperJob() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("phones");
	Поля.Добавить("languages");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ПоляВакансииСМногострочнымВводомSuperJob() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("work");
	Поля.Добавить("compensation");
	Поля.Добавить("candidat");
	Поля.Добавить("firm_activity");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ИменаСвойствТелефонаHeadHunter()
	
	ИменаСвойств = Новый Структура;
	
	ИменаСвойств.Вставить("КодСтраны", "country");
	ИменаСвойств.Вставить("КодГорода", "city");
	ИменаСвойств.Вставить("НомерТелефона", "number");
	ИменаСвойств.Вставить("Комментарий", "comment");
	
	Возврат ИменаСвойств;
	
КонецФункции

Функция ИменаСвойствТелефонаRabota()
	
	ИменаСвойств = Новый Структура;
	
	ИменаСвойств.Вставить("КодСтраны", "countryCode");
	ИменаСвойств.Вставить("КодГорода", "code");
	ИменаСвойств.Вставить("НомерТелефона", "number");
	ИменаСвойств.Вставить("Комментарий", "comment");
	
	Возврат ИменаСвойств;
	
КонецФункции

Функция ИменаСвойствТелефонаSuperJob()
	
	ИменаСвойств = Новый Структура;
	
	ИменаСвойств.Вставить("КодСтраны", "country_code");
	ИменаСвойств.Вставить("КодГорода", "city_code");
	ИменаСвойств.Вставить("НомерТелефона", "number");
	ИменаСвойств.Вставить("Комментарий", "additional");
	
	Возврат ИменаСвойств;
	
КонецФункции

Функция ИменаСвойствТелефона(Сайт) Экспорт 
	
	ИменаСвойств = Неопределено;
	
	Если Сайт = HeadHunter() 
		Или Сайт = RabotaMail() Тогда
		ИменаСвойств = ИменаСвойствТелефонаHeadHunter();
	ИначеЕсли Сайт = Rabota() Тогда
		ИменаСвойств = ИменаСвойствТелефонаRabota();
	ИначеЕсли Сайт = SuperJob() Тогда
		ИменаСвойств = ИменаСвойствТелефонаSuperJob();
	КонецЕсли;
	
	Возврат ИменаСвойств;
	
КонецФункции

Функция ИменаСвойствЗнанияЯзыкаRabota()
	
	ИменаСвойств = Новый Структура;
	
	ИменаСвойств.Вставить("ИдЯзыка", "id");
	ИменаСвойств.Вставить("ИдУровня", "id");
	ИменаСвойств.Вставить("НазваниеЯзыка", "name");
	ИменаСвойств.Вставить("НазваниеУровня", "name");
	ИменаСвойств.Вставить("ОбъектЯзык", "offerLanguage");
	ИменаСвойств.Вставить("ОбъектУровень", "offerLanguageLevel");
	
	Возврат ИменаСвойств;
	
КонецФункции

Функция ИменаСвойствЗнанияЯзыкаSuperJob()
	
	ИменаСвойств = Новый Структура;
	
	ИменаСвойств.Вставить("ИдЯзыка", "id");
	ИменаСвойств.Вставить("ИдУровня", "id");
	ИменаСвойств.Вставить("НазваниеЯзыка", "title");
	ИменаСвойств.Вставить("НазваниеУровня", "title");
	ИменаСвойств.Вставить("ОбъектЯзык", "id_language");
	ИменаСвойств.Вставить("ОбъектУровень", "level");
	
	Возврат ИменаСвойств;
	
КонецФункции

Функция ИменаСвойствЗнанияЯзыка(Сайт) Экспорт 
	
	ИменаСвойств = Неопределено;
	
	Если Сайт = Rabota() Тогда
		ИменаСвойств = ИменаСвойствЗнанияЯзыкаRabota();
	ИначеЕсли Сайт = SuperJob() Тогда
		ИменаСвойств = ИменаСвойствЗнанияЯзыкаSuperJob();
	КонецЕсли;
	
	Возврат ИменаСвойств;
	
КонецФункции

Функция ПоляВакансииСМножественнымВыборомИзСпискаSuperJob() Экспорт
	
	Поля = Новый Массив;
	Поля.Добавить("driving_licence");
	
	Возврат Новый ФиксированныйМассив(Поля);
	
КонецФункции

Функция ИдентификаторПоАдресу(Знач АдресВакансии, Разделитель = "/") Экспорт
	
	Пока НайтиВСтроке(АдресВакансии, Разделитель) > 0 Цикл
		
		НомерВхожденияРазделителя = НайтиВСтроке(АдресВакансии, Разделитель);
		АдресВакансии = Сред(АдресВакансии, НомерВхожденияРазделителя + СтрДлина(Разделитель), СтрДлина(АдресВакансии) - НомерВхожденияРазделителя);
		
	КонецЦикла;
	
	Возврат АдресВакансии;
	
КонецФункции

Функция АдресВакансииHeadHunter(Идентификатор) Экспорт
	Возврат СтрШаблон("https://hh.ru/vacancy/%1", Идентификатор);
КонецФункции

Функция АдресВакансииRabota(Идентификатор) Экспорт
	Возврат СтрШаблон("https://www.rabota.ru/vacancy/%1/", Идентификатор);
КонецФункции

Функция АдресВакансииSuperJob(Идентификатор) Экспорт
	Возврат СтрШаблон("https://www.superjob.ru/vakansii/vacancy-%1.html", Идентификатор);
КонецФункции

Функция ИзвлечьТекстИзHTML(Знач ТекстHTML) Экспорт
	
	ТекстHTML = СтрЗаменить(ТекстHTML, "</p>", Символы.ПС);
	ТекстHTML = СтрЗаменить(ТекстHTML, "</li>", Символы.ПС);
	ТекстHTML = СтрЗаменить(ТекстHTML, "<br>", Символы.ПС);
	ТекстHTML = СтрЗаменить(ТекстHTML, "<br/>", Символы.ПС);
	ТекстHTML = СтрЗаменить(ТекстHTML, "<br />", Символы.ПС);
	
	Возврат СтроковыеФункцииКлиентСервер.ИзвлечьТекстИзHTML(ТекстHTML);
	
КонецФункции

#КонецОбласти