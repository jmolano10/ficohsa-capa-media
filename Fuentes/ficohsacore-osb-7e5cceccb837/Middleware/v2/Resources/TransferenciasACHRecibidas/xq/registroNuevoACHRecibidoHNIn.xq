(:: pragma bea:global-element-parameter parameter="$transferenciasACHRecibidas" element="ns0:transferenciasACHRecibidas" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ACH/Recibido/RegistroNuevoACHRecibido/xsd/registroNuevoACHRecibido_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroNuevoACHRecibido";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/registroNuevoACHRecibidoHNIn/";

declare function xf:registroNuevoACHRecibidoHNIn($transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas),
    $targetAccount as xs:string)
    as element(ns1:InputParameters) {
        let $transactionDetail := $transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]
        return
            <ns1:InputParameters>
                {
                    for $REFERENCE_NUMBER in $transactionDetail/ORIGINATOR_INFO/REFERENCE_NUMBER
                    return
                        <ns1:PV_PXPIDREF>{ data($REFERENCE_NUMBER) }</ns1:PV_PXPIDREF>
                }
                <ns1:PV_PXPLOTEREF>{ data($transferenciasACHRecibidas/GLOBAL_REFERENCE) }</ns1:PV_PXPLOTEREF>
                <ns1:PV_RUTATRANSITO>{ data($transactionDetail/ORIGINATOR_INFO/BANK_ID) }</ns1:PV_RUTATRANSITO>
                <ns1:PV_TIPOTRANSACCION>{ data($transactionDetail/TRANSACTION_TYPE) }</ns1:PV_TIPOTRANSACCION>
                <ns1:PV_CUENTADESTINO>{ $targetAccount }</ns1:PV_CUENTADESTINO>
                <ns1:PV_IDENTBENEFICIARIO>{ data($transactionDetail/BENEFICIARY_ID) }</ns1:PV_IDENTBENEFICIARIO>
                <ns1:PV_NOMBREBENEFICIARIO>{ data($transactionDetail/BENEFICIARY_NAME) }</ns1:PV_NOMBREBENEFICIARIO>
                <ns1:PV_MONEDA>{ data($transactionDetail/CURRENCY) }</ns1:PV_MONEDA>
                <ns1:PN_MONTO>{ fn-bea:decimal-truncate(xs:decimal(data($transactionDetail/AMOUNT)), 2) }</ns1:PN_MONTO>
                {
                    for $ACCOUNT in $transactionDetail/ORIGINATOR_INFO/ACCOUNT
                    return
                        <ns1:PV_CUENTAORIGEN>{ data($ACCOUNT) }</ns1:PV_CUENTAORIGEN>
                }
                {
                    for $CUSTOMER_NAME in $transactionDetail/ORIGINATOR_INFO/CUSTOMER_NAME
                    return
                        <ns1:PV_NOMBREORDENANTE>{ data($CUSTOMER_NAME) }</ns1:PV_NOMBREORDENANTE>
                }
                {
                    for $DESCRIPTION in $transactionDetail/ORIGINATOR_INFO/DESCRIPTION
                    return
                        <ns1:PV_DESCRIPCION>{ data($DESCRIPTION) }</ns1:PV_DESCRIPCION>
                }
            </ns1:InputParameters>
};

declare variable $transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas) external;
declare variable $targetAccount as xs:string external;

xf:registroNuevoACHRecibidoHNIn($transferenciasACHRecibidas,
    $targetAccount)