<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaPAHeaderOut/";

declare function xf:consultaMaestraSaldoCuentaPAHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                let $PV_ERROR_CODE := string($outputParameters/ns1:PV_ERROR_CODE/text())
                return
                	if ($PV_ERROR_CODE = 'SUCCESS')then(
                		<successIndicator>Success</successIndicator>
                	)else(
                		<successIndicator>{ $PV_ERROR_CODE }</successIndicator>,
		                <messages>{ data($outputParameters/ns1:PV_ERROR_MESSAGE) }</messages>
                	)
                    
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaMaestraSaldoCuentaPAHeaderOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>