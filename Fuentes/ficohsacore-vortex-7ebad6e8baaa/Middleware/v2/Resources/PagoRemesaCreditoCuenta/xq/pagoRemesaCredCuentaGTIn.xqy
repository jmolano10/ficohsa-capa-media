xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesaCreditoCuenta1" element="ns0:pagoRemesaCreditoCuenta" location="../../../../Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/PagoRemesaCreditoCuenta/xsd/pagoRemesaCreditoCuentaGT_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoRemesaCreditoCuentaGT";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCreditoCuenta/xq/pagoRemesaCredCuentaGTIn/";

declare function xf:pagoRemesaCredCuentaGTIn($pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta),
    $codigoRemesa as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_MONEDAPAGO>{ data($pagoRemesaCreditoCuenta1/CURRENCY) }</ns1:PV_MONEDAPAGO>
            <ns1:PV_NUMCTABENEFICIARIO>{ data($pagoRemesaCreditoCuenta1/ACCOUNT_NUMBER) }</ns1:PV_NUMCTABENEFICIARIO>
            <ns1:PV_NOMBREBENEFICIARIO>{ data($pagoRemesaCreditoCuenta1/BENEFICIARY_NAME) }</ns1:PV_NOMBREBENEFICIARIO>
            <ns1:PV_TELBENEFICIARIO>{ data($pagoRemesaCreditoCuenta1/BENEF_PHONE_NUMBER) }</ns1:PV_TELBENEFICIARIO>
            <ns1:PV_DIRECCIONBENEFICIARIO>{ data($pagoRemesaCreditoCuenta1/REMITTER_ADDRESS) }</ns1:PV_DIRECCIONBENEFICIARIO>
            <ns1:PV_NOMBREREMITENTE>{ data($pagoRemesaCreditoCuenta1/REMITTER_NAME) }</ns1:PV_NOMBREREMITENTE>
            <ns1:PN_TASACAMBIO>{ data($pagoRemesaCreditoCuenta1/EXCHANGE_RATE) }</ns1:PN_TASACAMBIO>
            <ns1:PV_CIUDADORDENANTE>{ data($pagoRemesaCreditoCuenta1/CITY_OF_ORIGIN) }</ns1:PV_CIUDADORDENANTE>
            <ns1:PV_ESTADOORDENANTE>{ data($pagoRemesaCreditoCuenta1/STATE_OF_ORIGIN) }</ns1:PV_ESTADOORDENANTE>
            <ns1:PV_PAISORDENANTE>{ data($pagoRemesaCreditoCuenta1/COUNTRY_OF_ORIGIN) }</ns1:PV_PAISORDENANTE>
            <ns1:PV_CLAVE>{ data($pagoRemesaCreditoCuenta1/REMITTANCE_ID) }</ns1:PV_CLAVE>
            <ns1:PV_FECHAEMISION>{ data($pagoRemesaCreditoCuenta1/REMITTANCE_DATE) }</ns1:PV_FECHAEMISION>
            <ns1:PN_MONTOREFERENCIA>{ data($pagoRemesaCreditoCuenta1/REF_AMOUNT) }</ns1:PN_MONTOREFERENCIA>
            <ns1:PN_CODIGO_REMESADORA>{ data($codigoRemesa) }</ns1:PN_CODIGO_REMESADORA>
            <ns1:PN_MONTO>{ data($pagoRemesaCreditoCuenta1/AMOUNT) }</ns1:PN_MONTO>
        </ns1:InputParameters>
};

declare variable $pagoRemesaCreditoCuenta1 as element(ns0:pagoRemesaCreditoCuenta) external;
declare variable $codigoRemesa as xs:string external;

xf:pagoRemesaCredCuentaGTIn($pagoRemesaCreditoCuenta1,
    $codigoRemesa)