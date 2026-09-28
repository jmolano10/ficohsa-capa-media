(:: pragma bea:global-element-parameter parameter="$consultaRemesaPorNombreYMetodo" element="ns1:consultaRemesaPorNombreYMetodo" location="../xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Remesas/ConsultaRemesaPorNombreBDRemesas/xsd/consultaRemesaPorNombreBDRemesas_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRemesaPorNombreBDRemesas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreBDRemesasIn/";

declare function xf:consultaRemesaPorNombreBDRemesasIn($consultaRemesaPorNombreYMetodo as element(ns1:consultaRemesaPorNombreYMetodo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $BENEFICIARY_FIRSTNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTNAME
                return
                    <ns0:V_PRIMER_NOMBRE_B>{ data($BENEFICIARY_FIRSTNAME) }</ns0:V_PRIMER_NOMBRE_B>
            }
            {
                for $BENEFICIARY_MIDDLENAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_MIDDLENAME
                return
                    <ns0:V_SEGUNDO_NOMBRE_B>{ data($BENEFICIARY_MIDDLENAME) }</ns0:V_SEGUNDO_NOMBRE_B>
            }
            {
                for $BENEFICIARY_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTSURNAME
                return
                    <ns0:V_PRIMER_APELLIDO_B>{ data($BENEFICIARY_FIRSTSURNAME) }</ns0:V_PRIMER_APELLIDO_B>
            }
            {
                for $BENEFICIARY_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_SECONDSURNAME
                return
                    <ns0:V_SEGUNDO_APELLIDO_B>{ data($BENEFICIARY_SECONDSURNAME) }</ns0:V_SEGUNDO_APELLIDO_B>
            }
            {
                for $REMITTER_FIRSTNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTNAME
                return
                    <ns0:V_PRIMER_NOMBRE_R>{ data($REMITTER_FIRSTNAME) }</ns0:V_PRIMER_NOMBRE_R>
            }
            {
                for $REMITTER_MIDDLENAME in $consultaRemesaPorNombreYMetodo/REMITTER_MIDDLENAME
                return
                    <ns0:V_SEGUNDO_NOMBRE_R>{ data($REMITTER_MIDDLENAME) }</ns0:V_SEGUNDO_NOMBRE_R>
            }
            {
                for $REMITTER_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTSURNAME
                return
                    <ns0:V_PRIMER_APELLIDO_R>{ data($REMITTER_FIRSTSURNAME) }</ns0:V_PRIMER_APELLIDO_R>
            }
            {
                for $REMITTER_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_SECONDSURNAME
                return
                    <ns0:V_SEGUNDO_APELLIDO_R>{ data($REMITTER_SECONDSURNAME) }</ns0:V_SEGUNDO_APELLIDO_R>
            }
        </ns0:InputParameters>
};

declare variable $consultaRemesaPorNombreYMetodo as element(ns1:consultaRemesaPorNombreYMetodo) external;

xf:consultaRemesaPorNombreBDRemesasIn($consultaRemesaPorNombreYMetodo)