(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reprocesoACHRecibidasCR" element="ns0:reprocesoACHRecibidasCR" location="../xsd/reprocesoACHRecibidasCRTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ReprocesarACHRecibidos" location="../../../BusinessServices/ACH/Recibido/SvcACHRecibido/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHRecibidasCRTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHRecibidasCR/xq/reprocesarACHRecibidosIn/";

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

declare function xf:reprocesarACHRecibidosIn($requestHeader1 as element(ns2:RequestHeader),
    $reprocesoACHRecibidasCR as element(ns0:reprocesoACHRecibidasCR),
    $customerId as xs:string,
    $idProduct as xs:string,
    $tcccy as xs:string,
    $tcCurrentAmt as xs:string,
    $customerName as xs:string)
    as element(ns1:ReprocesarACHRecibidos) {
        <ns1:ReprocesarACHRecibidos>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOHNACHONLINEREPROCESSACHINWSType>
                {
                    for $ORD_ACCOUNT in $reprocesoACHRecibidasCR/ORD_ACCOUNT
                    return
                        <DEBITACCTNO>{ data($ORD_ACCOUNT) }</DEBITACCTNO>
                }
                {
                    for $BEN_ACCOUNT in $reprocesoACHRecibidasCR/BEN_ACCOUNT
                    return
                        <CREDITACCTNO>{ data($BEN_ACCOUNT) }</CREDITACCTNO>
                }
                {
                    for $BEN_CURRENCY in $reprocesoACHRecibidasCR/BEN_CURRENCY
                    return
                        <CREDITCCY>{ data($BEN_CURRENCY) }</CREDITCCY>
                }
                <CUSTOMERID>{ $customerId }</CUSTOMERID>
                <AMOUNT>{ fn-bea:decimal-truncate(xs:decimal(data($reprocesoACHRecibidasCR/BEN_AMOUNT)), 2) }</AMOUNT>
                <GLOBALREFERENCE>{ data($reprocesoACHRecibidasCR/PXP_BATCH_REF) }</GLOBALREFERENCE>
                {
                    for $TRANSIT_ROUTE in $reprocesoACHRecibidasCR/TRANSIT_ROUTE
                    return
                        <IDBANKISSUER>{ substring(data($TRANSIT_ROUTE),6,2) }</IDBANKISSUER>
                }
                <LEGENDBANKISSUER>{ data($reprocesoACHRecibidasCR/PXP_ID_TXN_REF) }</LEGENDBANKISSUER>
                <IDPRODUCT>{ $idProduct }</IDPRODUCT>
                {
                    for $TRANSACTION_TYPE in $reprocesoACHRecibidasCR/TRANSACTION_TYPE
                    return
                        <TIPOTRANS>{ fn:replace(data($TRANSACTION_TYPE),'_','.') }</TIPOTRANS>
                }
                {
                    for $STATUS in $reprocesoACHRecibidasCR/STATUS
                    return
                        <STATUS>{ data($STATUS) }</STATUS>
                }
                <CUSNAME>{ fn:replace(fn:substring($customerName, 1, 34), '(\:|\[|\]|\\|\/|\||\"|\^|\,|\$|\?|\*|\+|\{|\}|\(|\))', '.') }</CUSNAME>
                <ACHTXNTYPE>ACHIN</ACHTXNTYPE>
                <ISREPROCESS>YES</ISREPROCESS>
                <STAGE>1</STAGE>
                <TCCCY>{ $tcccy }</TCCCY>
                <TCCURRENTAMT>{ $tcCurrentAmt }</TCCURRENTAMT>
            </FICOHNACHONLINEREPROCESSACHINWSType>
        </ns1:ReprocesarACHRecibidos>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $reprocesoACHRecibidasCR as element(ns0:reprocesoACHRecibidasCR) external;
declare variable $customerId as xs:string external;
declare variable $idProduct as xs:string external;
declare variable $tcccy as xs:string external;
declare variable $tcCurrentAmt as xs:string external;
declare variable $customerName as xs:string external;

xf:reprocesarACHRecibidosIn($requestHeader1,
    $reprocesoACHRecibidasCR,
    $customerId,
    $idProduct,
    $tcccy,
    $tcCurrentAmt,
    $customerName)