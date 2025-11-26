(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns3:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../recaudos/Resources/ConsultarRelacionOperacionRecaudo/xsd/FLINK_OSB_CONSULTAR_OPER_RECAUDO.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudolocalylineatc" location="../Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_OPER_RECAUDO/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoLocalTCIn2/";

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

declare function xf:pagoRecaudoLocalTCIn2($autenticacionRequestHeader1 as element(ns3:AutenticacionRequestHeader),
    $pagoRecaudo1 as element(ns1:pagoRecaudo),
    $outputParameters1 as element(ns2:OutputParameters),
    $uuid as xs:string,
    $debitAccount as xs:string)
    as element(ns0:Pagoderecaudolocalylineatc) {
        <ns0:Pagoderecaudolocalylineatc>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FUNDSTRANSFERLATAMCCARDOLWSType>
                <DEBITACCTNO>{ $debitAccount }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</DEBITCURRENCY>
                <LRPAYCODE>{ data($pagoRecaudo1/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                	{
                		let $CODIGO_FACTURA := $outputParameters1/ns2:CODIGO_FACTURA/ns2:ITEM
                    	let $FECHA_FACTURA := $outputParameters1/ns2:FECHA_FACTURA/ns2:ITEM
                    	let $FECHA_VENCIMIENTO := $outputParameters1/ns2:FECHA_VENCIMIENTO/ns2:ITEM
                    	let $MONEDA_FACTURA := $outputParameters1/ns2:MONEDA_FACTURA/ns2:ITEM
                    	let $MONTO_FACTURA := $outputParameters1/ns2:MONTO_FACTURA/ns2:ITEM
                    	let $MONEDAS_SOLICITUD := $outputParameters1/ns2:MONEDAS_SOLICITUD/ns2:ITEM
                    	let $MORA := $outputParameters1/ns2:MORA/ns2:ITEM
                    	let $MONTO_TOTAL := $outputParameters1/ns2:MONTO_TOTAL/ns2:ITEM
                    	let $montoPago := $pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    	let $monedaPago := $pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY
                        for $i in 1 to count($CODIGO_FACTURA)
                        return
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($CODIGO_FACTURA[$i]) }</LRINVOICENO>
                        <LRINVOICEDT>{ data($FECHA_FACTURA[$i]) }</LRINVOICEDT>
                        <LRDUEDATE>{ data($FECHA_VENCIMIENTO[$i]) }</LRDUEDATE>
                        <LRAMT>{ concat($MONEDA_FACTURA[$i] , fn-bea:fail-over(fn-bea:format-number(round-half-to-even($MONTO_FACTURA[$i],2),"######0.00"),'0.00')) }</LRAMT>
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
                <LRAGCLIENTID>{ data($pagoRecaudo1/CONTRACT_ID) }</LRAGCLIENTID>
                {
                    for $CREDIT_CARD_NUMBER in $pagoRecaudo1/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                    return
                        <LRCCARDNO>{ data($CREDIT_CARD_NUMBER) }</LRCCARDNO>
                }
                {
                    for $EXPIRATION_DATE in $pagoRecaudo1/PAYMENT_INFORMATION/EXPIRATION_DATE
                    return
                        <LREXPIRYDATE>{ data($EXPIRATION_DATE) }</LREXPIRYDATE>
                }
                {
                    for $DEALSLIP_PICKUP_BRANCH in $pagoRecaudo1/DEALSLIP_PICKUP_BRANCH
                    return
                        <LRBENID>{ data($DEALSLIP_PICKUP_BRANCH) }</LRBENID>
                }
                
            </FUNDSTRANSFERLATAMCCARDOLWSType>
        </ns0:Pagoderecaudolocalylineatc>
};

declare variable $autenticacionRequestHeader1 as element(ns3:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $outputParameters1 as element(ns2:OutputParameters) external;
declare variable $uuid as xs:string external;
declare variable $debitAccount as xs:string external;

xf:pagoRecaudoLocalTCIn2($autenticacionRequestHeader1,
    $pagoRecaudo1,
    $outputParameters1,
    $uuid,
    $debitAccount)