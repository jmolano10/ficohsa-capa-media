xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$transactionDetail" type="ns2:transactionDetail" location="../xsd/transferenciasACHDebitosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:TransferenciaACHDebitoenLinea" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHDebitos/xq/transferenciaACHDebitoenLineaIn/";

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
declare function getReferenceNumber($REFERENCE_NUMBER as xs:string,$uuid as xs:string) as xs:string {
	if ($REFERENCE_NUMBER = "") then (
			$uuid
		)
	else (
			$REFERENCE_NUMBER
		)
};

declare function xf:transferenciaACHDebitoenLineaIn($requestHeader as element(ns0:RequestHeader),
    $transactionDetail as element(),
    $idRegistro as xs:string,
    $uuid as xs:string)
    as element(ns1:TransferenciaACHDebitoenLinea) {
        <ns1:TransferenciaACHDebitoenLinea>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>
                {
                	getReferenceNumber(fn:string($transactionDetail/ORIGINATOR_INFO/REFERENCE_NUMBER/text()),$uuid)  
                }
                </messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILDEBITACHWSType>
                <DebitAccount>{ data($transactionDetail/DESTINATION) }</DebitAccount>
                <DebitCurrency>{ data($transactionDetail/CURRENCY) }</DebitCurrency>
                <DebitAmount>{ data($transactionDetail/AMOUNT) }</DebitAmount>
                <LRFICOACHPXD>
                {
                	getReferenceNumber(fn:string($transactionDetail/ORIGINATOR_INFO/REFERENCE_NUMBER/text()),$uuid)
                }
                </LRFICOACHPXD>
                <LRCONTRACTACH>{ data($transactionDetail/CONTRACT_ID) }</LRCONTRACTACH>
                <gPAYMENTDETAILS>
                	<Paymentdetails>{ $idRegistro }</Paymentdetails>
                </gPAYMENTDETAILS>
            </FUNDSTRANSFERRETAILDEBITACHWSType>
        </ns1:TransferenciaACHDebitoenLinea>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transactionDetail as element() external;
declare variable $idRegistro as xs:string external;
declare variable $uuid as xs:string external;

xf:transferenciaACHDebitoenLineaIn($requestHeader,
    $transactionDetail,
    $idRegistro,
    $uuid)