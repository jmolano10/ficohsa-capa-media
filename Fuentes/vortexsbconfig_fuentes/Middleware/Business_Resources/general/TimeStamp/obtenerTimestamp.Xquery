<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/general/TimeStamp/obtenerTimestamp/";

declare function xf:obtenerTimestamp()
as xs:string {
	let $FechaSistema := substring(fn:string(fn:current-date()),1,10) 
	let $HoraSistema := substring(fn:string(fn:current-time()),1,12)
	return concat($FechaSistema,' ',$HoraSistema)
};


xf:obtenerTimestamp()</con:xquery>
</con:xqueryEntry>