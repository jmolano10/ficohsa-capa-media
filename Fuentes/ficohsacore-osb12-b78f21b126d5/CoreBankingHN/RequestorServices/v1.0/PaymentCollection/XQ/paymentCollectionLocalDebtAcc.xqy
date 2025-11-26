xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollection/XMLSchema_-263071553.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRelationOperationCollection";
(:: import schema at "../../../../ProviderServices/XSD/GetRelationOperationCollection/GetRelationOperationCollection_sp.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns2:paymentCollectionRequest) ::) external;
declare variable $uuid as xs:string external;
declare variable $getRelationOperationCollectionResponse as element() (:: schema-element(ns3:OutputParameters) ::) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($username as xs:string, 
                            $password as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns2:paymentCollectionRequest) ::), 
                            $uuid as xs:string, 
                            $getRelationOperationCollectionResponse as element() (:: schema-element(ns3:OutputParameters) ::)) 
                            as element() (:: schema-element(ns1:Pagoderecaudolocalylineadbcta) ::) {
    <ns1:Pagoderecaudolocalylineadbcta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
                <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FUNDSTRANSFERLATAMACCTTRFWSType>
                {
                    for $DEBIT_ACCOUNT in $paymentCollectionRequest/ns2:PaymentInformation/ns2:DebitAccount
                    return
                        <DEBITACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBITACCOUNT>
                }
                <PAYEECCY>{ data($paymentCollectionRequest/ns2:PaymentInformation/ns2:PaymentCurrency) }</PAYEECCY>
                <LRPAYCODE>{ data($paymentCollectionRequest/ns2:DebtorCode) }</LRPAYCODE>
                <gLRINVOICENO>
                    {
                    	let $CODIGO_FACTURA := $getRelationOperationCollectionResponse/ns3:CODIGO_FACTURA/ns3:CODIGO_FACTURA_ITEM
                    	let $FECHA_FACTURA := $getRelationOperationCollectionResponse/ns3:FECHA_FACTURA/ns3:CODIGO_FACTURA_ITEM
                    	let $FECHA_VENCIMIENTO := $getRelationOperationCollectionResponse/ns3:FECHA_VENCIMIENTO/ns3:CODIGO_FACTURA_ITEM
                    	let $MONEDA_FACTURA := $getRelationOperationCollectionResponse/ns3:MONEDA_FACTURA/ns3:CODIGO_FACTURA_ITEM
                    	let $MONTO_FACTURA := $getRelationOperationCollectionResponse/ns3:MONTO_FACTURA/ns3:CODIGO_FACTURA_ITEM
                    	let $MONEDAS_SOLICITUD := $getRelationOperationCollectionResponse/ns3:MONEDAS_SOLICITUD/ns3:CODIGO_FACTURA_ITEM
                    	let $MORA := $getRelationOperationCollectionResponse/ns3:MORA/ns3:CODIGO_FACTURA_ITEM
                    	let $MONTO_TOTAL := $getRelationOperationCollectionResponse/ns3:MONTO_TOTAL/ns3:CODIGO_FACTURA_ITEM
                    	let $montoPago := $paymentCollectionRequest/ns2:PaymentInformation/ns2:PaymentAmount
                    	let $monedaPago := $paymentCollectionRequest/ns2:PaymentInformation/ns2:PaymentCurrency
                        for $i in 1 to count($CODIGO_FACTURA)
                        return
                            <mLRINVOICENO>
                                <LRINVOICENO>{ data($CODIGO_FACTURA[$i]) }</LRINVOICENO>
                                <LRINVOICEDT>{ data($FECHA_FACTURA[$i]) }</LRINVOICEDT>
                                <LRDUEDATE>{ data($FECHA_VENCIMIENTO[$i]) }</LRDUEDATE>
                                <LRAMT>{ fn:concat($MONEDA_FACTURA[$i] , fn-bea:fail-over(fn-bea:format-number(fn:round-half-to-even(fn:number(fn:replace($MONTO_FACTURA[$i], ',', '.')),2),"######0.00"),'0.00')) }</LRAMT>
                                {
                                	if( fn:number($MORA[$i]) != 0 and fn:string(fn:number($MORA[$i])) != 'NaN') then (
                                		<LRPENALITYAMT>{ fn:concat($MONEDA_FACTURA[$i] , $MORA[$i]) }</LRPENALITYAMT>
                                	) else ()
                                }
                                <LRTOTALAMT>{ fn:concat($MONEDAS_SOLICITUD[$i] , fn-bea:fail-over(fn-bea:format-number(fn:round-half-to-even(fn:number(fn:replace($MONTO_TOTAL[$i], ',', '.')),2),"######0.00"),'0.00')) }</LRTOTALAMT>
                                {
                                    
                                            if( fn:number($montoPago) != fn:number(fn:replace($MONTO_TOTAL[$i], ',', '.')) ) then (
										<LRPARTIALAMT>{ fn-bea:fail-over(fn-bea:format-number(fn:round-half-to-even(fn:number($montoPago),2),"######0.00"),'0.00') }</LRPARTIALAMT>
                                						
                                	) else ()
                                }
                                <LRPAYYN>Y</LRPAYYN>
                            </mLRINVOICENO>
                    }
                </gLRINVOICENO>            
                <LRAGCLIENTID>{ data($paymentCollectionRequest/ns2:ContractId) }</LRAGCLIENTID>
                {
                    for $DEALSLIP_PICKUP_BRANCH in $paymentCollectionRequest/ns2:DealshipPickupBranch
                    return
                        <LRBENID>{ data($DEALSLIP_PICKUP_BRANCH) }</LRBENID>
                }
                <gLRTAXPAYNAME>
                    {
                        for $ITEM in $getRelationOperationCollectionResponse/ns3:NOMBRE_DEUDOR/ns3:CODIGO_FACTURA_ITEM
                        return
                            <LRTAXPAYNAME>{ data($ITEM) }</LRTAXPAYNAME>
                    }
                </gLRTAXPAYNAME>
            </FUNDSTRANSFERLATAMACCTTRFWSType>
    </ns1:Pagoderecaudolocalylineadbcta>
};

local:func($username, $password, $paymentCollectionRequest, $uuid, $getRelationOperationCollectionResponse)