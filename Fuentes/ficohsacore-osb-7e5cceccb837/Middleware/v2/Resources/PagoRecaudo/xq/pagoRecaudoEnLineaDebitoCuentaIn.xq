(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../Business_Resources/recaudos/Resources/ConsultarRelacionOperacionRecaudo/xsd/FLINK_OSB_CONSULTAR_OPER_RECAUDO.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudolocalylineadbcta" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_OPER_RECAUDO/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoEnLineaDebitoCuentaIn/";

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
 
(:: Equivalente a un NVL en Oracle:)
declare function if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;
 
(:: Realiza un replcae multiple :)
declare function replace-multi 
  ( $arg as xs:string? ,
    $changeFrom as xs:string* ,
    $changeTo as xs:string* )  as xs:string? {
       
   if (count($changeFrom) > 0)
   then replace-multi(
          replace($arg, $changeFrom[1],
                     if-absent($changeTo[1],'')),
          $changeFrom[position() > 1],
          $changeTo[position() > 1])
   else $arg
 } ;
 
declare function xf:pagoRecaudoEnLineaDebitoCuentaIn($requestHeader as element(ns3:RequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $outputParameters as element(ns2:OutputParameters),
    $uuid as xs:string)
    as element(ns0:Pagoderecaudolocalylineadbcta) {
        <ns0:Pagoderecaudolocalylineadbcta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FUNDSTRANSFERLATAMACCTTRFWSType>
                {
                    for $DEBIT_ACCOUNT in $pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                    return
                        <DEBITACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBITACCOUNT>
                }
                <PAYEECCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYEECCY>
                <LRPAYCODE>
                     {
                     if (data($pagoRecaudo/CONTRACT_ID) = "96652.001" ) then
                        ( replace-multi(fn:upper-case(data($pagoRecaudo/DEBTOR_CODE)),"Ñ","#") )
                     else
                        ( fn:upper-case(data($pagoRecaudo/DEBTOR_CODE)) )
                     }
                     </LRPAYCODE>
                (:: <LRPAYCODE>{ data($pagoRecaudo/DEBTOR_CODE) }</LRPAYCODE> ::)
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
                    	let $montoPago := $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    	let $monedaPago := $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY
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
                <LRAGCLIENTID>{ data($pagoRecaudo/CONTRACT_ID) }</LRAGCLIENTID>
                {
                    for $DEALSLIP_PICKUP_BRANCH in $pagoRecaudo/DEALSLIP_PICKUP_BRANCH
                    return
                        <LRBENID>{ data($DEALSLIP_PICKUP_BRANCH) }</LRBENID>
                }                
                <gLRTAXPAYNAME>
                {
                    for $ITEM in $outputParameters/ns2:NOMBRE_DEUDOR/ns2:ITEM
                    return
                        <LRTAXPAYNAME>{ data($ITEM) }</LRTAXPAYNAME>
                }
            	</gLRTAXPAYNAME>
            </FUNDSTRANSFERLATAMACCTTRFWSType>
        </ns0:Pagoderecaudolocalylineadbcta>
};

declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $uuid as xs:string external;

xf:pagoRecaudoEnLineaDebitoCuentaIn($requestHeader,
    $pagoRecaudo,
    $outputParameters,
    $uuid)
