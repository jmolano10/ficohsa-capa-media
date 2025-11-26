(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ACH/Enviado/RegistroNuevoACHEnviado/xsd/registroNuevoACHEnviado_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registroNuevoACHEnviado";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/registroNuevoACHEnviadoIn/";

declare function xf:registroNuevoACHEnviadoIn($transferenciasACHRequest as element(ns0:transferenciasACHRequest),
    $username as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUENTAORIGEN>{ data($transferenciasACHRequest/DEBIT_ACCOUNT) }</ns1:PV_CUENTAORIGEN>
            <ns1:PV_BANCODESTINO>{ data($transferenciasACHRequest/DESTINATION_BANK) }</ns1:PV_BANCODESTINO>
            <ns1:PV_TIPOCUENTADEST>{ data($transferenciasACHRequest/ACCOUNT_TYPE) }</ns1:PV_TIPOCUENTADEST>
            <ns1:PV_CUENTADESTINO>{ data($transferenciasACHRequest/CREDIT_ACCOUNT) }</ns1:PV_CUENTADESTINO>
            <ns1:PV_MONEDA>{ data($transferenciasACHRequest/CREDIT_CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PN_MONTO>{ fn-bea:decimal-truncate(xs:decimal(data($transferenciasACHRequest/TRANSFER_AMOUNT)), 2) }</ns1:PN_MONTO>
            <ns1:PV_NOMBREBENEFICIARIO>{ data($transferenciasACHRequest/BENEFICIARY_NAME) }</ns1:PV_NOMBREBENEFICIARIO>
            <ns1:PV_IDENTBENEFICIARIO>{ data($transferenciasACHRequest/BENEFICIARY_ID) }</ns1:PV_IDENTBENEFICIARIO>
            <ns1:PV_DESCRIPCION>{ data($transferenciasACHRequest/TRANSACTION_DESCRIPTION) }</ns1:PV_DESCRIPCION>
            <ns1:PV_INTERFACEREFNO>{ data($transferenciasACHRequest/INTERFACE_REFERENCE_NO) }</ns1:PV_INTERFACEREFNO>
            <ns1:PV_TIPOTRANSACCION>{ data($transferenciasACHRequest/LOCAL_ACCOUNT_TYPE) }</ns1:PV_TIPOTRANSACCION>
            <ns1:PV_LOCALORGACCOUNT>{ data($transferenciasACHRequest/LOCAL_ORIGINAL_ACCOUNT) }</ns1:PV_LOCALORGACCOUNT>
            <ns1:PV_CANALINGRESO>{ $username }</ns1:PV_CANALINGRESO>
        </ns1:InputParameters>
};

declare variable $transferenciasACHRequest as element(ns0:transferenciasACHRequest) external;
declare variable $username as xs:string external;

xf:registroNuevoACHEnviadoIn($transferenciasACHRequest,
    $username)