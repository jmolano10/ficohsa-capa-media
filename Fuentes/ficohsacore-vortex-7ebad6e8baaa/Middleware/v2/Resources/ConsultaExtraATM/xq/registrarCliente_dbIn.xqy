xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaExtrafinanciamientoDisponibleResponse" element="ns1:consultaExtrafinanciamientoDisponibleResponse" location="../../ConsultaExtrafinanciamientoDisponible/xsd/consultaExtrafinanciamientoDisponibleTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$creditCards1" type="ns2:consultaTarjetasCreditoPorClienteResponse/CREDIT_CARDS" location="../../ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ATM/RegistrarCliente/xsd/registrarCliente_db_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarCliente_db";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaExtrafinanciamientoDisponibleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaExtraATM/xq/registrarCliente_dbIn/";

declare function xf:registrarCliente_dbIn($consultaExtrafinanciamientoDisponibleResponse as element(ns1:consultaExtrafinanciamientoDisponibleResponse),
    $debitCard as xs:string,
    $creditCard as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $NUMBER_ID in $consultaExtrafinanciamientoDisponibleResponse/NUMBER_ID
                return
                    <ns0:PV_DNI>{ fn-bea:trim(fn:data($NUMBER_ID)) }</ns0:PV_DNI>
            }
            {
                for $CUSTOMER_ID in $consultaExtrafinanciamientoDisponibleResponse/CUSTOMER_ID
                return
                    <ns0:PV_ID_CLIENTE>{ fn-bea:trim(fn:data($CUSTOMER_ID)) }</ns0:PV_ID_CLIENTE>
            }
            {
                for $CUSTOMER_NAME in $consultaExtrafinanciamientoDisponibleResponse/CUSTOMER_NAME
                return
                    <ns0:PV_NOMBRE_CLIENTE>{ fn-bea:trim(fn:data($CUSTOMER_NAME)) }</ns0:PV_NOMBRE_CLIENTE>
            }
            <ns0:PV_TARJETA_DEBITO>{ fn-bea:trim($debitCard) }</ns0:PV_TARJETA_DEBITO>
            <ns0:PV_TARJETA_CREDITO>{ fn-bea:trim($creditCard) }</ns0:PV_TARJETA_CREDITO>
            {
                for $ACCOUNT_NUMBER in $consultaExtrafinanciamientoDisponibleResponse/ACCOUNT_NUMBER
                return
                    <ns0:PV_INFO_CUENTA>{ fn-bea:trim(fn:data($ACCOUNT_NUMBER)) }</ns0:PV_INFO_CUENTA>
            }
            {
                for $AVAILABLE_AMOUNT in $consultaExtrafinanciamientoDisponibleResponse/AVAILABLE_AMOUNT
                return
                    <ns0:PN_MONTO_EXTRA>{ fn:data($AVAILABLE_AMOUNT) }</ns0:PN_MONTO_EXTRA>
            }
            {
                for $INTEREST_RATE in $consultaExtrafinanciamientoDisponibleResponse/INTEREST_RATE
                return
                    <ns0:PN_TASA>{ fn:data($INTEREST_RATE) }</ns0:PN_TASA>
            }
            <ns0:PV_MONEDA>HNL</ns0:PV_MONEDA>
        </ns0:InputParameters>
};

declare variable $consultaExtrafinanciamientoDisponibleResponse as element(ns1:consultaExtrafinanciamientoDisponibleResponse) external;
declare variable $debitCard as xs:string external;
declare variable $creditCard as xs:string external;

xf:registrarCliente_dbIn($consultaExtrafinanciamientoDisponibleResponse,
    $debitCard,
    $creditCard)