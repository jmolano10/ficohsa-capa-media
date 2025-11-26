(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns0:consultaRemesas" location="consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resoruces/ConsultarRemLocalNombre/consultarRemLocalNombre_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalNomIn/";

declare function xf:consultaRemLocalNomIn($consultaRemesas1 as element(ns0:consultaRemesas))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $BENEFICIARY_NAME in $consultaRemesas1/BENEFICIARY_NAME
                return
                    <ns1:PV_NOMBREBENEFICIARIO>{ data($BENEFICIARY_NAME) }</ns1:PV_NOMBREBENEFICIARIO>
            }
            {
                for $REMITTER_NAME in $consultaRemesas1/REMITTER_NAME
                return
                    <ns1:PV_NOMBREREMITENTE>{ data($REMITTER_NAME) }</ns1:PV_NOMBREREMITENTE>
            }
        </ns1:InputParameters>
};

declare variable $consultaRemesas1 as element(ns0:consultaRemesas) external;

xf:consultaRemLocalNomIn($consultaRemesas1)