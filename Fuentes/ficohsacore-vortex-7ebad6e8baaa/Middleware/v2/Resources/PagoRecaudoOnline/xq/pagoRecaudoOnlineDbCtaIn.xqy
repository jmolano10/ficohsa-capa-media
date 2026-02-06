xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoInterno" element="ns1:pagoRecaudoInterno" location="../../PagoRecaudoInterno/xsd/pagoRecaudoInternoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../Business_Resources/recaudos/Resources/ConsultarRelacionOperacionRecaudo/xsd/FLINK_OSB_CONSULTAR_OPER_RECAUDO.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudoreferenciadodbcta" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoOnline/xq/pagoRecaudoOnlineDbCtaIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoInternoTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_OPER_RECAUDO/";


(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:pagoRecaudoOnlineDbCtaIn($requestHeader as element(ns3:RequestHeader),
    $pagoRecaudoInterno as element(ns1:pagoRecaudoInterno),
    $outputParameters as element(ns2:OutputParameters),
    $uuid as xs:string,
    $debitAcount as xs:string)
    as element(ns0:Pagoderecaudolocalylineadbcta) {
        <ns0:Pagoderecaudolocalylineadbcta>
        	<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
				<gtsControl></gtsControl>
                <messageId>{ $uuid }</messageId>
	            <noOfAuth></noOfAuth>
	            <replace></replace>
	        </OfsFunction> 
            <FUNDSTRANSFERLATAMACCTTRFWSType>
            	<DEBITACCOUNT>{ data($debitAcount) }</DEBITACCOUNT>
                <PAYEECCY>{ data($pagoRecaudoInterno/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYEECCY>
                <LRPAYCODE>{ data($pagoRecaudoInterno/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                    {
                    	let $CODIGO_FACTURA := $outputParameters/ns2:CODIGO_FACTURA/ns2:ITEM
                    	let $FECHA_FACTURA := $outputParameters/ns2:FECHA_FACTURA/ns2:ITEM
                    	let $FECHA_VENCIMIENTO := $outputParameters/ns2:FECHA_VENCIMIENTO/ns2:ITEM
                    	let $MONEDA_FACTURA := $outputParameters/ns2:MONEDA_FACTURA/ns2:ITEM
                    	let $MONTO_FACTURA := $outputParameters/ns2:MONTO_FACTURA/ns2:ITEM
                    	let $MONEDAS_SOLICITUD := $outputParameters/ns2:MONEDAS_SOLICITUD/ns2:ITEM
                    	let $MORA := $outputParameters/ns2:MORA/ns2:ITEM
                    	let $MONTO_TOTAL := $outputParameters/ns2:MONTO_TOTAL/ns2:ITEM
                    	let $montoPago := $pagoRecaudoInterno/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    	let $monedaPago := $pagoRecaudoInterno/PAYMENT_INFORMATION/PAYMENT_CURRENCY
                        for $i in 1 to count($CODIGO_FACTURA)
                        return
                            <mLRINVOICENO>
                                <LRINVOICENO>{ data($CODIGO_FACTURA[$i]) }</LRINVOICENO>
                                <LRINVOICEDT>{ data($FECHA_FACTURA[$i]) }</LRINVOICEDT>
                                <LRDUEDATE>{ data($FECHA_VENCIMIENTO[$i]) }</LRDUEDATE>
                                <LRAMT>{ concat($MONEDA_FACTURA[$i] , fn-bea:fail-over(fn-bea:format-number(round-half-to-even($MONTO_FACTURA[$i],2),"######0.00"),'0.00')) }</LRAMT>
                                {
                                	if( number($MORA[$i]) != 0 and string(number($MORA[$i])) != 'NaN') then (
                                		<LRPENALITYAMT>{ concat($MONEDA_FACTURA[$i] , $MORA[$i]) }</LRPENALITYAMT>
                                	) else ()
                                }
                                <LRTOTALAMT>{ concat($MONEDAS_SOLICITUD[$i] , fn-bea:fail-over(fn-bea:format-number(round-half-to-even($MONTO_TOTAL[$i],2),"######0.00"),'0.00')) }</LRTOTALAMT>
                                {
                                	if( number($montoPago) != number($MONTO_TOTAL[$i]) ) then (
										<LRPARTIALAMT>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even($montoPago,2),"######0.00"),'0.00') }</LRPARTIALAMT>
                                						
                                	) else ()
                                }
                                <LRPAYYN>Y</LRPAYYN>
                            </mLRINVOICENO>
                    }
                </gLRINVOICENO>
                 <LRAGCLIENTID>{ data($pagoRecaudoInterno/CONTRACT_INFORMATION/CONTRACT_ID) }</LRAGCLIENTID>
                {
                    for $DEALSLIP_PICKUP_BRANCH in $pagoRecaudoInterno/DEALSLIP_PICKUP_BRANCH
                    return
                        <LRBENID>{ data($DEALSLIP_PICKUP_BRANCH) }</LRBENID>
                }                 
            </FUNDSTRANSFERLATAMACCTTRFWSType>
        </ns0:Pagoderecaudolocalylineadbcta>
};

declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $pagoRecaudoInterno as element(ns1:pagoRecaudoInterno) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $uuid as xs:string external;
declare variable $debitAcount as xs:string external;

xf:pagoRecaudoOnlineDbCtaIn($requestHeader,
    $pagoRecaudoInterno,
    $outputParameters,
    $uuid,
    $debitAcount)