<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)

declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/Generales/xq/obtenerParametrizacionIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";

declare function xf:obtenerParametrizacionIn($nombreParametros as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PARAMETRIZACIONES>
                {
                    for $nombre in fn:tokenize($nombreParametros, '\|\|')
                    return
                    	if(normalize-space(($nombre)) != "") then (
                        	<ns0:NOMBRE>{ $nombre }</ns0:NOMBRE>
                        ) else()
                }
            </ns0:PARAMETRIZACIONES>
        </ns0:InputParameters>
};

declare variable $nombreParametros as xs:string external;

xf:obtenerParametrizacionIn($nombreParametros)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MDW/obtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd">
        <con:schema ref="MWHostToHost/v1/BusinessServices/MDW/obtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG"/>
    </con:dependency>
</con:xqueryEntry>