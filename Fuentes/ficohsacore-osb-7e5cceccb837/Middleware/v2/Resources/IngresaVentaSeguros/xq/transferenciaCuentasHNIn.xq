(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ingresaVentaSeguros" element="ns2:ingresaVentaSeguros" location="../xsd/ingresaVentaSegurosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ingresaVentaSegurosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguro/xq/transferenciaCuentasHNIn/";

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

declare function xf:transferenciaCuentasHNIn($requestHeader as element(ns0:RequestHeader),
    $ingresaVentaSeguros as element(ns2:ingresaVentaSeguros),
    $transactionType as xs:string,
    $debitAccount as xs:string,
    $creditAccount as xs:string,
    $description as xs:string,
    $uuid as xs:string,
    $auth as xs:string)
    as element(ns1:Transfmodelbankentrecuentas) {
        <ns1:Transfmodelbankentrecuentas>
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
                <messageId>{ $uuid }</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCTNO>{ $debitAccount }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_CURRENCY) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($ingresaVentaSeguros/PAYMENT_INFORMATION/PAYMENT_DETAIL/PAYMENT_AMOUNT) }</DEBITAMOUNT>
                <CREDITACCTNO>{ $creditAccount }</CREDITACCTNO>
                <gPAYMENTDETAILS g = "1">
                    <PAYMENTDETAILS>{ concat($description, ".") }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $ingresaVentaSeguros as element(ns2:ingresaVentaSeguros) external;
declare variable $transactionType as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $creditAccount as xs:string external;
declare variable $description as xs:string external;
declare variable $uuid as xs:string external;
declare variable $auth as xs:string external;

xf:transferenciaCuentasHNIn($requestHeader,
    $ingresaVentaSeguros,
    $transactionType,
    $debitAccount,
    $creditAccount,
    $description,
    $uuid,
    $auth)