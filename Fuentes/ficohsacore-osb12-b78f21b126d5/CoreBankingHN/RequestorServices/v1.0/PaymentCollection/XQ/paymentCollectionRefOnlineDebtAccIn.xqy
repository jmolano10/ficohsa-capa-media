xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PaymentCollection/XMLSchema_-263071553.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRelationOperationCollection";
(:: import schema at "../../../../ProviderServices/XSD/GetRelationOperationCollection/GetRelationOperationCollection_sp.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $uuid as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;
declare variable $getRelationOperationCollectionResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;

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

declare function local:func($uuid as xs:string, 
                            $username as xs:string, 
                            $password as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::), 
                            $getRelationOperationCollectionResponse as element() (:: schema-element(ns2:OutputParameters) ::)) 
                            as element() (:: schema-element(ns3:Pagoderecaudoreferenciadodbcta) ::) {
    <ns3:Pagoderecaudoreferenciadodbcta>
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
            <FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
                <DEBITACCTNO>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:DebitAccount) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency) }</DEBITCURRENCY>
                <LRPAYCODE>{ data($paymentCollectionRequest/ns1:DebtorCode) }</LRPAYCODE>
                <gLRINVOICENO>
                    {
                    	let $CODIGO_FACTURA := $getRelationOperationCollectionResponse/ns2:CODIGO_FACTURA
                    	let $FECHA_FACTURA := $getRelationOperationCollectionResponse/ns2:FECHA_FACTURA
                    	let $FECHA_VENCIMIENTO := $getRelationOperationCollectionResponse/ns2:FECHA_VENCIMIENTO
                    	let $MONEDA_FACTURA := $getRelationOperationCollectionResponse/ns2:MONEDA_FACTURA
                    	let $MONTO_FACTURA := $getRelationOperationCollectionResponse/ns2:MONTO_FACTURA
                    	let $MONEDAS_SOLICITUD := $getRelationOperationCollectionResponse/ns2:MONEDAS_SOLICITUD
                    	let $MORA := $getRelationOperationCollectionResponse/ns2:MORA
                    	let $MONTO_TOTAL := $getRelationOperationCollectionResponse/ns2:MONTO_TOTAL
                    	let $montoPago := $paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount
                    	let $monedaPago := $paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency
                        for $i in 1 to count($CODIGO_FACTURA)
                        return
                            <mLRINVOICENO>
                                <LRINVOICENO>{ data($CODIGO_FACTURA[$i]) }</LRINVOICENO>
                                <LRDUEDATE>{ data($FECHA_VENCIMIENTO[$i]) }</LRDUEDATE>
                                <LRAMT>{ concat($paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentCurrency, $paymentCollectionRequest/ns1:PaymentInformation/ns1:PaymentAmount) }</LRAMT>
                                <LRPAYYN>Y</LRPAYYN>
                            </mLRINVOICENO>
                    }
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>{ data($paymentCollectionRequest/ns1:DebtorName) }</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($paymentCollectionRequest/ns1:ContractId) }</LRAGCLIENTID>
            </FUNDSTRANSFERREFCOLLACTRFWSCOPYType>
    </ns3:Pagoderecaudoreferenciadodbcta>
};

local:func($uuid, $username, $password, $paymentCollectionRequest, $getRelationOperationCollectionResponse)