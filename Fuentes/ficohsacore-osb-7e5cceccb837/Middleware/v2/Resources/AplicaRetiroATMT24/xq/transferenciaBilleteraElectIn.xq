(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$aplicaRetiroATMT241" element="ns1:aplicaRetiroATMT24" location="../xsd/aplicaRetiroATMT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:TransferenciaBilleteraElect" location="../../../BusinessServices/T24/svcBilleteraElectronica/xsd/XMLSchema_959556777.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aplicaRetiroATMT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AplicaRetiroATMT24/xq/transferenciaBilleteraElectIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:transferenciaBilleteraElectIn($requestHeader as element(ns2:RequestHeader),
    $aplicaRetiroATMT241 as element(ns1:aplicaRetiroATMT24))
    as element(ns0:TransferenciaBilleteraElect) {
        <ns0:TransferenciaBilleteraElect>
            <WebRequestCommon>
                 <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
                                                data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                                                data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERATMBILLECUPONWSType>
                {
                    for $TRANSACTION_CODE in $aplicaRetiroATMT241/TRANSACTION_CODE
                    return
                        <Transaccioncode>{ data($TRANSACTION_CODE) }</Transaccioncode>
                }
                {
                    for $DEBIT_ACCOUNT in $aplicaRetiroATMT241/DEBIT_ACCOUNT
                    return
                        <CuentaDebito>{ data($DEBIT_ACCOUNT) }</CuentaDebito>
                }
                {
                    for $CURRENCY in $aplicaRetiroATMT241/CURRENCY
                    return
                        <Monedadebito>{ data($CURRENCY) }</Monedadebito>
                }
                {
                    for $AMOUNT in $aplicaRetiroATMT241/AMOUNT
                    return
                        <Monto>{ data($AMOUNT) }</Monto>
                }
                <gPAYMENTDETAILS>
                    {
                        for $atmReference in $aplicaRetiroATMT241/ATM_REFERENCE 
                        return
                            <Referencia>{ concat(data($atmReference), '/ATM') }</Referencia>
                    }
                    {
                        for $tengoReference in $aplicaRetiroATMT241/TENGO_REFERENCE 
                        return
                            <Referencia>{ concat(data($tengoReference), '/TENGO') }</Referencia>
                    }
                    {
                        for $osbReference in $aplicaRetiroATMT241/OSB_REFERENCE 
                        return
                            <Referencia>{ concat(data($osbReference), '/OSB') }</Referencia>
                    }
                </gPAYMENTDETAILS>
                {
                    for $ATM_DATE in $aplicaRetiroATMT241/ATM_DATE
                    return
                        <LRBENNAME>{ fn-bea:dateTime-to-string-with-format('MMddHmmss', xs:dateTime($ATM_DATE)) }</LRBENNAME>
                }
                {
                    for $PAY_CODE in $aplicaRetiroATMT241/PAY_CODE
                    return
                        <LREMPNAME>{ data($PAY_CODE) }</LREMPNAME>
                }
                {
                    for $ATM_ID in $aplicaRetiroATMT241/ATM_ID
                    return
                        <LRVERNAME>{ data($ATM_ID) }</LRVERNAME>
                }
                {
                    for $WITHDRAWAL_TYPE in $aplicaRetiroATMT241/WITHDRAWAL_TYPE
                    return
                        <LRBENLASNAME>{ data($WITHDRAWAL_TYPE) }</LRBENLASNAME>
                }
            </FUNDSTRANSFERATMBILLECUPONWSType>
        </ns0:TransferenciaBilleteraElect>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $aplicaRetiroATMT241 as element(ns1:aplicaRetiroATMT24) external;

xf:transferenciaBilleteraElectIn($requestHeader,
    $aplicaRetiroATMT241)
