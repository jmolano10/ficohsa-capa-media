<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTarjetaAnteriorTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataGT/xq/conTarjetaAnteriorTCIn/";

declare function xf:conTarjetaAnteriorTCIn($org as xs:string,
    $numeroTarjeta as xs:string,
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            {
            	if($org != '')then(
            		<ns0:Org>{ $org }</ns0:Org>
            	)else()
            }
            <ns0:NumCard>{ data($numeroTarjeta) }</ns0:NumCard>
        </ns0:InputParameters>
};

declare variable $org as xs:string external;
declare variable $numeroTarjeta as xs:string external;
declare variable $codigoPais as xs:string external;

xf:conTarjetaAnteriorTCIn($org,
    $numeroTarjeta,
    $codigoPais)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MasterDataGT/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataGT/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp"/>
    </con:dependency>
</con:xqueryEntry>