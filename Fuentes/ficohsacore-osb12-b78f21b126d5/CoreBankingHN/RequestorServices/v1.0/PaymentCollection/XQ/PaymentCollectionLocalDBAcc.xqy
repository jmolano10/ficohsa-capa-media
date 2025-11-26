xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollection/XMLSchema_-263071553.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRelationOperationCollection";
(:: import schema at "../../../../ProviderServices/XSD/GetRelationOperationCollection/GetRelationOperationCollection_sp.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $PaymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $GetRelationOperationCollectionResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $uuid as xs:string external;
declare variable $debidAccount as xs:string external;

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
                            $PaymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $GetRelationOperationCollectionResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $uuid as xs:string, 
                            $debidAccount as xs:string) 
                            as element() (:: schema-element(ns3:Pagoderecaudolocalylineadbcta) ::) {
    <ns3:Pagoderecaudolocalylineadbcta>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <gtsControl></gtsControl>
            <messageId>{fn:data($uuid)}</messageId>
            <noOfAuth></noOfAuth>
            <replace></replace>
        </OfsFunction>
        <FUNDSTRANSFERLATAMACCTTRFWSType>
            <DEBITACCOUNT>{fn:data($debidAccount)}</DEBITACCOUNT>
            <PAYEECCY>{fn:data($PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency)}</PAYEECCY>
            <LRPAYCODE>{fn:data($PaymentCollectionRequest/ns1:DebtorCode)}</LRPAYCODE>
            <gLRINVOICENO>
            {
                  let $CODIGO_FACTURA := $GetRelationOperationCollectionResponse/ns2:CODIGO_FACTURA/ns2:CODIGO_FACTURA_ITEM
                  let $FECHA_FACTURA := $GetRelationOperationCollectionResponse/ns2:FECHA_FACTURA/ns2:CODIGO_FACTURA_ITEM
                  let $FECHA_VENCIMIENTO := $GetRelationOperationCollectionResponse/ns2:FECHA_VENCIMIENTO/ns2:CODIGO_FACTURA_ITEM
                  let $MONEDA_FACTURA := $GetRelationOperationCollectionResponse/ns2:MONEDA_FACTURA/ns2:CODIGO_FACTURA_ITEM
                  let $MONTO_FACTURA := $GetRelationOperationCollectionResponse/ns2:MONTO_FACTURA/ns2:CODIGO_FACTURA_ITEM
                  let $MONEDAS_SOLICITUD := $GetRelationOperationCollectionResponse/ns2:MONEDAS_SOLICITUD/ns2:CODIGO_FACTURA_ITEM
                  let $MORA := $GetRelationOperationCollectionResponse/ns2:MORA/ns2:CODIGO_FACTURA_ITEM
                  let $MONTO_TOTAL := $GetRelationOperationCollectionResponse/ns2:MONTO_TOTAL/ns2:CODIGO_FACTURA_ITEM
                  let $montoPago := $PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount
                  let $monedaPago := $PaymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency
                    for $i in 1 to count($CODIGO_FACTURA)
                    return
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($CODIGO_FACTURA[$i]) }</LRINVOICENO>
                        <LRINVOICEDT>{ data($FECHA_FACTURA[$i]) }</LRINVOICEDT>
                        <LRDUEDATE>{ data($FECHA_VENCIMIENTO[$i]) }</LRDUEDATE>
                        <LRAMT>{ concat($MONEDA_FACTURA[$i] , fn-bea:fail-over(fn-bea:format-number(round-half-to-even(xs:decimal($MONTO_FACTURA[$i]),2),"######0.00"),'0.00')) }</LRAMT>
                        {
                            if(number($MORA[$i]) != 0 and string(number($MORA[$i])) != 'NaN')then(
                              <LRPENALITYAMT>{ concat($MONEDA_FACTURA[$i] , $MORA[$i]) }</LRPENALITYAMT>
                            )else()
                        }
                        <LRTOTALAMT>{ concat($MONEDAS_SOLICITUD[$i] , fn-bea:fail-over(fn-bea:format-number(round-half-to-even(xs:decimal($MONTO_TOTAL[$i]),2),"######0.00"),'0.00')) }</LRTOTALAMT>
                        {
                            if(number($montoPago) != number($MONTO_TOTAL[$i]))then(
                              <LRPARTIALAMT>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even(xs:decimal($montoPago),2),"######0.00"),'0.00') }</LRPARTIALAMT>
                            )else()
                        }
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
            }
            </gLRINVOICENO>
            <gLRTAXPAYNAME>
                {
                    for $CODIGO_FACTURA_ITEM in $GetRelationOperationCollectionResponse/ns2:NOMBRE_DEUDOR/ns2:CODIGO_FACTURA_ITEM
                    return 
                    <LRTAXPAYNAME>{fn:data($CODIGO_FACTURA_ITEM)}</LRTAXPAYNAME>
                }
            </gLRTAXPAYNAME>
            <LRAGCLIENTID>{fn:data($PaymentCollectionRequest/ns1:ContractId)}</LRAGCLIENTID>
            {
                for $DEALSLIP_PICKUP_BRANCH in $PaymentCollectionRequest/ns1:DealshipPickupBranch
                return
                <LRBENID>{fn:data($PaymentCollectionRequest/ns1:DealshipPickupBranch)}</LRBENID>
            }
        </FUNDSTRANSFERLATAMACCTTRFWSType>
    </ns3:Pagoderecaudolocalylineadbcta>
};

local:func($username, $password, $PaymentCollectionRequest, $GetRelationOperationCollectionResponse, $uuid, $debidAccount)