<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns2:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$payCashPickUpOrderResponse" element="ns1:payCashPickUpOrderResponse" location="../../../BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:pagoRemesasResponse" location="../xsd/pagoRemesas.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/riaMoneyTransferTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelConPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRemesaRIANIOut/";

declare function xf:pagoRemesaRIANIOut($requestHeader as element(ns3:RequestHeader),
    $pagoRemesas as element(ns2:pagoRemesas),
    $outputParameters as element(ns0:OutputParameters),
    $payCashPickUpOrderResponse as element(ns1:payCashPickUpOrderResponse))
    as element(ns2:pagoRemesasResponse) {
        <ns2:pagoRemesasResponse>
            <REMITTANCE_INFO>
                {
                    for $PIN in $payCashPickUpOrderResponse/ns1:Response/ns1:PIN
                    return
                        <ID>{ data($PIN) }</ID>
                }
                {
                    for $PN_MONTOLOCAL in $outputParameters/ns0:PN_MONTOLOCAL
                    return
                        <AMOUNT>{ data($PN_MONTOLOCAL) }</AMOUNT>
                }
                {
                    for $PV_MONEDA in $outputParameters/ns0:PV_MONEDA
                    return
                        <CURRENCY>{ data($PV_MONEDA) }</CURRENCY>
                }
                {
                    for $PV_FECHAREMESA in $outputParameters/ns0:PD_FECHAREMESA
                    return
                        <VALUE_DATE>{ fn-bea:fail-over(fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($PV_FECHAREMESA)),"") }</VALUE_DATE>
                }
                {
                    for $PV_REMITENTE in $outputParameters/ns0:PV_REMITENTE
                    return
                        <ORD_PARTY_NAME>{ data($PV_REMITENTE) }</ORD_PARTY_NAME>
                }
                {
                    for $PN_MONTO in $outputParameters/ns0:PN_MONTO
                    return
                        <PRICE>{ data($PN_MONTO) }</PRICE>
                }
                <COUNTRY_OF_ORIGIN>{ data($outputParameters/ns0:PV_PAISORIGEN) }</COUNTRY_OF_ORIGIN>
            </REMITTANCE_INFO>
            <BENEFICIARY_INFO>
                {
                    for $PV_BENEFICIARIO in $outputParameters/ns0:PV_BENEFICIARIO
                    return
                        <NAME>{ data($PV_BENEFICIARIO) }</NAME>
                }
                <ID>{ data($pagoRemesas/BENEFICIARY_INFO/ID) }</ID>
                <ADDRESS>{ data($pagoRemesas/BENEFICIARY_INFO/ADDRESS) }</ADDRESS>
                <COUNTRY>{ data($pagoRemesas/BENEFICIARY_INFO/COUNTRY) }</COUNTRY>
                <CITY>{ data($pagoRemesas/BENEFICIARY_INFO/CITY) }</CITY>
                <PHONE_NUMBER>{ data($pagoRemesas/BENEFICIARY_INFO/PHONE_NUMBER) }</PHONE_NUMBER>
            </BENEFICIARY_INFO>
            <INPUTTER>{ data($requestHeader/Authentication/UserName) }</INPUTTER>
            <DATE_TIME>{ fn:substring(fn:string(fn:current-date()),1,10) }</DATE_TIME>
            <ns2:ADDITIONAL_INFO>
             <ns2:INFO>
                 <ns2:NAME>TRANSACTION_CODE</ns2:NAME>
                 {
                     if ($payCashPickUpOrderResponse/ns1:Response/ns1:TransRefID)
                     then <ns2:VALUE>{fn:data($payCashPickUpOrderResponse/ns1:Response/ns1:TransRefID)}</ns2:VALUE>
                     else ()
                 }
             </ns2:INFO>
             <ns2:INFO>
                 <ns2:NAME>ORDER_CODE</ns2:NAME>
                 {
                     if ($payCashPickUpOrderResponse/ns1:Response/ns1:OrderNo)
                     then <ns2:VALUE>{fn:data($payCashPickUpOrderResponse/ns1:Response/ns1:OrderNo)}</ns2:VALUE>
                     else ()
                 }
             </ns2:INFO>
         </ns2:ADDITIONAL_INFO>
        </ns2:pagoRemesasResponse>
};

declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $pagoRemesas as element(ns2:pagoRemesas) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $payCashPickUpOrderResponse as element(ns1:payCashPickUpOrderResponse) external;

xf:pagoRemesaRIANIOut($requestHeader,
    $pagoRemesas,
    $outputParameters,
    $payCashPickUpOrderResponse)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../xsd/pagoRemesas.xsd">
        <con:schema ref="Middleware/v2/Resources/PagoRemesa/xsd/pagoRemesas"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder"/>
    </con:dependency>
</con:xqueryEntry>