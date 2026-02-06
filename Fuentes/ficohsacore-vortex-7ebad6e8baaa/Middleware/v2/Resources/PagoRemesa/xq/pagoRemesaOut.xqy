xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesas1" element="ns1:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/consultaRelConPago/xsd/consultaRelConPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRemesasResponse" location="../xsd/pagoRemesas.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelConPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRemesaOUT/";

declare function xf:pagoRemesaOUT($requestHeader1 as element(ns2:RequestHeader),
    $pagoRemesas1 as element(ns1:pagoRemesas),
    $outputParameters1 as element(ns0:OutputParameters),
    $paymentDate as xs:string)
    as element(ns1:pagoRemesasResponse) {
        <ns1:pagoRemesasResponse>
            <REMITTANCE_INFO>
                <COMPANY_NAME></COMPANY_NAME>
                <ID>{ data($pagoRemesas1/REMITTANCE_ID) }</ID>
                {
                	for $PN_MONTOLOCAL in $outputParameters1/ns0:PN_MONTOLOCAL
                	return
                		<AMOUNT>{ data($PN_MONTOLOCAL) }</AMOUNT>
                }
                {
                    for $PV_MONEDA in $outputParameters1/ns0:PV_MONEDA
                    return
                        <CURRENCY>{ data($PV_MONEDA) }</CURRENCY>
                }
                {
                    for $PV_FECHAREMESA in $outputParameters1/ns0:PD_FECHAREMESA
                    return
                        <VALUE_DATE>{ fn-bea:fail-over(fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($PV_FECHAREMESA)),"") }</VALUE_DATE>
                }
                {
                    for $PV_REMITENTE in $outputParameters1/ns0:PV_REMITENTE
                    return
                        <ORD_PARTY_NAME>{ data($PV_REMITENTE) }</ORD_PARTY_NAME>
                }
                {
                    for $PN_MONTO in $outputParameters1/ns0:PN_MONTO
                    return
                        <PRICE>{ data($PN_MONTO) }</PRICE>
                }
                <COUNTRY_OF_ORIGIN>{ data($outputParameters1/ns0:PV_PAISORIGEN) }</COUNTRY_OF_ORIGIN>
            </REMITTANCE_INFO>
            <BENEFICIARY_INFO>
                {
                    for $PV_BENEFICIARIO in $outputParameters1/ns0:PV_BENEFICIARIO
                    return
                        <NAME>{ data($PV_BENEFICIARIO) }</NAME>
                }
                <ID>{ data($pagoRemesas1/BENEFICIARY_INFO/ID) }</ID>
                <ADDRESS>{ data($pagoRemesas1/BENEFICIARY_INFO/ADDRESS) }</ADDRESS>
                <COUNTRY>{ data($pagoRemesas1/BENEFICIARY_INFO/COUNTRY) }</COUNTRY>
                <CITY>{ data($pagoRemesas1/BENEFICIARY_INFO/CITY) }</CITY>
                <PHONE_NUMBER>{ data($pagoRemesas1/BENEFICIARY_INFO/PHONE_NUMBER) }</PHONE_NUMBER>
            </BENEFICIARY_INFO>
            <INPUTTER>{ data($requestHeader1/Authentication/UserName) }</INPUTTER>
            <DATE_TIME>{ $paymentDate }</DATE_TIME>
            <EXCHANGE_RATE>{ data($outputParameters1/ns0:PN_TASACAMBIO) }</EXCHANGE_RATE>
        </ns1:pagoRemesasResponse>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $pagoRemesas1 as element(ns1:pagoRemesas) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $paymentDate as xs:string external;

xf:pagoRemesaOUT($requestHeader1,
    $pagoRemesas1,
    $outputParameters1,
    $paymentDate)