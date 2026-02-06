xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRemesaPorNombreYMetodo" element="ns0:consultaRemesaPorNombreYMetodo" location="../xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultarRemPorNombre/xsd/consultarRemPorNombre_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreBDRemesasIn/";

declare function xf:consultaRemesaPorNombreBDRemesasIn($consultaRemesaPorNombreYMetodo as element(ns0:consultaRemesaPorNombreYMetodo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $BENEFICIARY_FIRSTNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTNAME,
                    $BENEFICIARY_MIDDLENAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_MIDDLENAME,
                    $BENEFICIARY_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTSURNAME,
                    $BENEFICIARY_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_SECONDSURNAME
                return
                    <ns1:PV_NOMBREBENEFICIARIO>{ concat($BENEFICIARY_FIRSTNAME, " " , $BENEFICIARY_MIDDLENAME, " " , $BENEFICIARY_FIRSTSURNAME, " " , $BENEFICIARY_SECONDSURNAME) }</ns1:PV_NOMBREBENEFICIARIO>
            }
            {
                for $REMITTER_FIRSTNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTNAME,
                    $REMITTER_MIDDLENAME in $consultaRemesaPorNombreYMetodo/REMITTER_MIDDLENAME,
                    $REMITTER_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTSURNAME,
                    $REMITTER_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_SECONDSURNAME
                return
                    <ns1:PV_NOMBREREMITENTE>{ concat($REMITTER_FIRSTNAME, " " , $REMITTER_MIDDLENAME, " " , $REMITTER_FIRSTSURNAME, " " , $REMITTER_SECONDSURNAME) }</ns1:PV_NOMBREREMITENTE>
            }
            {
                for $REMITTANCES_ALLOWED in $consultaRemesaPorNombreYMetodo/REMITTANCES_ALLOWED
                return
                    <ns1:PV_REMESASPERMITIDAS>{ data($REMITTANCES_ALLOWED) }</ns1:PV_REMESASPERMITIDAS>
            }
            {
                for $IDPAYER in $consultaRemesaPorNombreYMetodo/IDPAYER
                return
                    <ns1:PV_PAGADORDESTINO>{ data($IDPAYER) }</ns1:PV_PAGADORDESTINO>
            }
        </ns1:InputParameters>
};

declare variable $consultaRemesaPorNombreYMetodo as element(ns0:consultaRemesaPorNombreYMetodo) external;

xf:consultaRemesaPorNombreBDRemesasIn($consultaRemesaPorNombreYMetodo)