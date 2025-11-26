(:: pragma bea:global-element-parameter parameter="$validacionCuenta1" element="ns1:validacionCuenta" location="../ValidacionCuenta/validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaCuentaEquivalente/xsd/ConsultaCuentaEquivalente_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCuentaEquivalente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ConsultaCuentaEquivalente/ConsultaCuentaEquivalenteIn/";

declare function xf:ConsultaCuentaEquivalenteIn($validacionCuenta1 as element(ns1:validacionCuenta))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:PV_ACCION>C</ns0:PV_ACCION>
            <ns0:PV_NUMERO_CUENTA_ORI>{ data($validacionCuenta1/ACCOUNT_NUMBER) }</ns0:PV_NUMERO_CUENTA_ORI>
        </ns0:InputParameters>
};

declare variable $validacionCuenta1 as element(ns1:validacionCuenta) external;

xf:ConsultaCuentaEquivalenteIn($validacionCuenta1)