<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetalladademovscuentaResponse" element="ns0:ConsultadetalladademovscuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaZeroHeaderOut/";

declare function xf:consultaDetalladaMovimientosCuentaZeroHeaderOut($consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	<successIndicator>NO RECORDS</successIndicator>
            {
                for $ZERORECORDS in $consultadetalladademovscuentaResponse/WSFICOSTMTBOOKDETAILType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse) external;

xf:consultaDetalladaMovimientosCuentaZeroHeaderOut($consultadetalladademovscuentaResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_378991004.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>