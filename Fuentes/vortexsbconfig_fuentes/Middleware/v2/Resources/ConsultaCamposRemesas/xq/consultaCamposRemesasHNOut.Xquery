<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/Remesas/consultaCamposRemNoEstandar/xsd/consultaCamposRemNoEstandar_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCamposRemesasResponse" location="../xsd/consultaCamposRemesasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCamposRemesasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCamposRemNoEstandar";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCamposRemesas/xq/consultaCamposRemesasHNOut/";

declare function xf:consultaCamposRemesasHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaCamposRemesasResponse) {
        <ns0:consultaCamposRemesasResponse>
            <FIELDS> {
            	for $field at $index in $outputParameters/ns1:PV_NOMBRE/ns1:PV_NOMBRE_ITEM
				return
					<FIELD>
					 	<NAME>{ data($outputParameters/ns1:PV_NOMBRE/ns1:PV_NOMBRE_ITEM[$index]) }</NAME>
					 	<TYPE>{ data($outputParameters/ns1:PV_TIPO/ns1:PV_TIPO_ITEM[$index]) }</TYPE>
					 	<LABEL_ES>{ data($outputParameters/ns1:PV_ETIQUETAES/ns1:PV_ETIQUETAES_ITEM[$index]) }</LABEL_ES>
					 	<LABEL_EN>{ data($outputParameters/ns1:PV_ETIQUETAEN/ns1:PV_ETIQUETAES_ITEM[$index]) }</LABEL_EN>
					</FIELD>
            } </FIELDS>
        </ns0:consultaCamposRemesasResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaCamposRemesasHNOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/Remesas/consultaCamposRemNoEstandar/xsd/consultaCamposRemNoEstandar_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Remesas/consultaCamposRemNoEstandar/xsd/consultaCamposRemNoEstandar_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaCamposRemesasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaCamposRemesas/xsd/consultaCamposRemesasTypes"/>
    </con:dependency>
</con:xqueryEntry>