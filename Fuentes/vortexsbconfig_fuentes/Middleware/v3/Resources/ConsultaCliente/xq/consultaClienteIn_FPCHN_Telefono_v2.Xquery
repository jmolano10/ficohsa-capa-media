<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/FPC/consultaTelefonoPersona/xsd/consultaTelefonoPersonaFPC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTelefonoPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteIn_FPCHN_Telefono_v2/";

declare function xf:consultaClienteIn_FPCHN_Telefono($ID_TYPE as xs:string,$ID_VALUE as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
        {
        if ($ID_TYPE = ('CODE', 'CUSTOMER_ID')) then
            &lt;ns0:PC_COD_PERSONA>{ $ID_VALUE }&lt;/ns0:PC_COD_PERSONA>
        else
        	&lt;ns0:PC_COD_PERSONA/>
        }	
        &lt;/ns0:InputParameters>
};


declare variable $ID_TYPE as xs:string external;
declare variable $ID_VALUE as xs:string external;

xf:consultaClienteIn_FPCHN_Telefono($ID_TYPE, $ID_VALUE)</con:xquery>
    <con:dependency location="../../../../v2/BusinessServices/FPC/consultaTelefonoPersona/xsd/consultaTelefonoPersonaFPC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/FPC/consultaTelefonoPersona/xsd/consultaTelefonoPersonaFPC_sp"/>
    </con:dependency>
</con:xqueryEntry>