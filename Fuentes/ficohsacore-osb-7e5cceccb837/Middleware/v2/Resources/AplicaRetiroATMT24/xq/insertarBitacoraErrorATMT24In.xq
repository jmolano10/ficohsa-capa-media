(:: pragma bea:global-element-parameter parameter="$aplicaRetiroATMT241" element="ns1:aplicaRetiroATMT24" location="../xsd/aplicaRetiroATMT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/insertarBitacoraErrorATMT24/xsd/insertarBitacoraErrorATMT24_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarBitacoraErrorATMT24";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aplicaRetiroATMT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AplicaRetiroATMT24/xq/insertarBitacoraErrorATMT24In/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
        return
            $data/con:username/text()
 };
 
declare function xf:insertarBitacoraErrorATMT24In($aplicaRetiroATMT241 as element(ns1:aplicaRetiroATMT24),
    $errorMsj as xs:string,
    $user as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ fn-bea:fail-over( getUsername($user),$user) }</ns0:PV_USUARIO>
            {
                for $DEBIT_ACCOUNT in $aplicaRetiroATMT241/DEBIT_ACCOUNT
                return
                    <ns0:PV_NUMERO_CUENTA>{ data($DEBIT_ACCOUNT) }</ns0:PV_NUMERO_CUENTA>
            }
            {
                for $ATM_DATE in $aplicaRetiroATMT241/ATM_DATE
                return
                    <ns0:PV_FECHA_CAJERO>{ data($ATM_DATE) }</ns0:PV_FECHA_CAJERO>
            }
            {
                for $TRANSACTION_CODE in $aplicaRetiroATMT241/TRANSACTION_CODE
                return
                    <ns0:PV_COD_TRANSACCION>{ data($TRANSACTION_CODE) }</ns0:PV_COD_TRANSACCION>
            }
            {
                for $ATM_ID in $aplicaRetiroATMT241/ATM_ID
                return
                    <ns0:PV_ID_CAJERO>{ data($ATM_ID) }</ns0:PV_ID_CAJERO>
            }
            {
                for $PAY_CODE in $aplicaRetiroATMT241/PAY_CODE
                return
                    <ns0:PV_NUMERO_BILLETE>{ data($PAY_CODE) }</ns0:PV_NUMERO_BILLETE>
            }
            {
                for $CURRENCY in $aplicaRetiroATMT241/CURRENCY
                return
                    <ns0:PV_MONEDA>{ data($CURRENCY) }</ns0:PV_MONEDA>
            }
            {
                for $AMOUNT in $aplicaRetiroATMT241/AMOUNT
                return
                    <ns0:PV_MONTO>{ data($AMOUNT) }</ns0:PV_MONTO>
            }
            {
                for $ATM_REFERENCE in $aplicaRetiroATMT241/ATM_REFERENCE
                return
                    <ns0:PV_REFERENCIA_CAJERO>{ data($ATM_REFERENCE) }</ns0:PV_REFERENCIA_CAJERO>
            }
            {
                for $TENGO_REFERENCE in $aplicaRetiroATMT241/TENGO_REFERENCE
                return
                    <ns0:PV_REFERENCIA_TENGO>{ data($TENGO_REFERENCE) }</ns0:PV_REFERENCIA_TENGO>
            }
            {
                for $OSB_REFERENCE in $aplicaRetiroATMT241/OSB_REFERENCE
                return
                    <ns0:PV_REFERENCIA_OSB>{ data($OSB_REFERENCE) }</ns0:PV_REFERENCIA_OSB>
            }
            {
                for $WITHDRAWAL_TYPE in $aplicaRetiroATMT241/WITHDRAWAL_TYPE
                return
                    <ns0:PV_TIPO_BILLETE>{ data($WITHDRAWAL_TYPE) }</ns0:PV_TIPO_BILLETE>
            }
            <ns0:PV_ERROR_MSJ>{ $errorMsj }</ns0:PV_ERROR_MSJ>
        </ns0:InputParameters>
};

declare variable $aplicaRetiroATMT241 as element(ns1:aplicaRetiroATMT24) external;
declare variable $errorMsj as xs:string external;
declare variable $user as xs:string external;

xf:insertarBitacoraErrorATMT24In($aplicaRetiroATMT241,
    $errorMsj,
    $user)
