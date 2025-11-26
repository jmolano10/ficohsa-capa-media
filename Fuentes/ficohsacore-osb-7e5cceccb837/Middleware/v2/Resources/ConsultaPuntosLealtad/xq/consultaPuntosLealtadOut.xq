(:: pragma bea:global-element-parameter parameter="$canjearPuntosEfectivo" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPuntosLealtadResponse" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace ns2 = "http://customer.ws.mcrewards.mastercard.com/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/canjearPuntosEfectivo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadOut/";

declare function xf:consultaPuntosLealtadOut($legalId as xs:string,
    $customerName as xs:string,
    $availablePoints as xs:string,
    $canjearPuntosEfectivo as element(ns1:OutputParameters)?)
    as element(ns0:consultaPuntosLealtadResponse) {
        <ns0:consultaPuntosLealtadResponse>
            <LEGAL_ID>{ $legalId }</LEGAL_ID>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
           
             <BALANCE>{ concat($availablePoints) }</BALANCE>
            {
                for $PN_VALORSALIDA in $canjearPuntosEfectivo/ns1:PN_VALORSALIDA
                return
                if($PN_VALORSALIDA != "") then (
                    <CASH_EQUIVALENT>{ fn-bea:format-number(data($PN_VALORSALIDA),'###0.00') }</CASH_EQUIVALENT>
                )else(
            		<CASH_EQUIVALENT>0</CASH_EQUIVALENT>
            	)
            }
            {
                for $OutputParameters in $canjearPuntosEfectivo
                return
                    <CASH_CURRENCY>HNL</CASH_CURRENCY>
            }
        </ns0:consultaPuntosLealtadResponse>
};

declare variable $legalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $availablePoints as xs:string external;
declare variable $canjearPuntosEfectivo as element(ns1:OutputParameters)? external;

xf:consultaPuntosLealtadOut($legalId,
    $customerName,
    $availablePoints,
    $canjearPuntosEfectivo)
