(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns0:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultarRemPorNombre/xsd/consultarRemPorNombre_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemPorNombre/";

declare function xf:consultaRemPorNombre($consultaRemesas1 as element(ns0:consultaRemesas),
    $PAYER as xs:string,
    $REMALLOWED as xs:string)
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
            <ns1:PV_REMESASPERMITIDAS>{ $REMALLOWED }</ns1:PV_REMESASPERMITIDAS>
            <ns1:PV_PAGADORDESTINO>{ $PAYER }</ns1:PV_PAGADORDESTINO>
        </ns1:InputParameters>
};

declare variable $consultaRemesas1 as element(ns0:consultaRemesas) external;
declare variable $PAYER as xs:string external;
declare variable $REMALLOWED as xs:string external;

xf:consultaRemPorNombre($consultaRemesas1,
    $PAYER,
    $REMALLOWED)