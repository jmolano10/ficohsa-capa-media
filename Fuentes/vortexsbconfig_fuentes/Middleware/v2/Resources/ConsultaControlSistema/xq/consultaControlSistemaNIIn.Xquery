<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataREG/validaMasterData/xsd/consultaValidaMasterData_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaValidaMasterData";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaControlSistema/xq/consultaControlSistemaHNIn/";

declare function xf:consultaControlSistemaHNIn($pais as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PAIS>{ $pais }&lt;/ns0:PAIS>
        &lt;/ns0:InputParameters>
};

declare variable $pais as xs:string external;

xf:consultaControlSistemaHNIn($pais)</con:xquery>
    <con:dependency location="../../../BusinessServices/MasterDataREG/validaMasterData/xsd/consultaValidaMasterData_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataREG/validaMasterData/xsd/consultaValidaMasterData_sp"/>
    </con:dependency>
</con:xqueryEntry>