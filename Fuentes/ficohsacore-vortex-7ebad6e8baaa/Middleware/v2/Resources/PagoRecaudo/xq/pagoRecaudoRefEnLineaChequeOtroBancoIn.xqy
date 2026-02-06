xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../Business_Resources/recaudos/Resources/ConsultarRelacionOperacionRecaudo/xsd/FLINK_OSB_CONSULTAR_OPER_RECAUDO.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagorecaudoreferenciadochqotrbco" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoRefEnLineaChequeOtroBancoIn/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_OPER_RECAUDO/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:PagoRecaudoReferenciadoEnLineaChequeOtroBancoIn($requestHeader as element(ns3:RequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $outputParameters as element(ns2:OutputParameters),
    $uuid as xs:string)
    as element(ns0:Pagorecaudoreferenciadochqotrbco) {
        <ns0:Pagorecaudoreferenciadochqotrbco>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
                <messageId>{ $uuid }</messageId>
				<noOfAuth>1</noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <TELLERLATAMREFOBCHQRESWSCOPYType>
                <CURRENCY1>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</CURRENCY1>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        <CHEQUENUMBER>{ data($pagoRecaudo/PAYMENT_INFORMATION/CHEQUE_NUMBER) }</CHEQUENUMBER>
                        <CHEQUEBANKCDE>{ data($pagoRecaudo/PAYMENT_INFORMATION/BANK_CODE) }</CHEQUEBANKCDE>
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
                <LRPAYCODE>{ data($pagoRecaudo/DEBTOR_CODE) }</LRPAYCODE>
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
                                <LRDUEDATE>{ data($FECHA_VENCIMIENTO[$i]) }</LRDUEDATE>
                                <LRAMT>{ concat($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY , $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</LRAMT>
                                <LRPAYYN>Y</LRPAYYN>
                            </mLRINVOICENO>
                    }
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>{ data($pagoRecaudo/DEBTOR_CODE) }</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($pagoRecaudo/CONTRACT_ID) }</LRAGCLIENTID>
            </TELLERLATAMREFOBCHQRESWSCOPYType>
        </ns0:Pagorecaudoreferenciadochqotrbco>
};

declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $uuid as xs:string external;

xf:PagoRecaudoReferenciadoEnLineaChequeOtroBancoIn($requestHeader,
    $pagoRecaudo,
    $outputParameters,
    $uuid)