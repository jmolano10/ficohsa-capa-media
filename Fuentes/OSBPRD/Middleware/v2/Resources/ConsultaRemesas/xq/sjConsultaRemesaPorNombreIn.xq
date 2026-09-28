(:: pragma bea:global-element-parameter parameter="$consultaRemesas" element="ns0:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaRemesaPorNombreRequest" location="../../../BusinessServices/SJS/consultaRemesaPorNombre/xsd/sjConsultaRemesaPorNombre.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRemesaPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/sjConsultaRemesaPorNombreIn/";

declare function xf:sjConsultaRemesaPorNombreIn($consultaRemesas as element(ns0:consultaRemesas),
    $remittancesAllowed as xs:string,
    $idPayer as xs:string)
    as element(ns1:sjConsultaRemesaPorNombreRequest) {
        <ns1:sjConsultaRemesaPorNombreRequest>
            {
                for $REMITTER_FIRSTNAME in $consultaRemesas/REMITTER_FIRSTNAME
                return
                    <ns1:REMITTER_FIRSTNAME>{ data($REMITTER_FIRSTNAME) }</ns1:REMITTER_FIRSTNAME>
            }
            {
                for $REMITTER_MIDDLENAME in $consultaRemesas/REMITTER_MIDDLENAME
                return
                    <ns1:REMITTER_MIDDLENAME>{ data($REMITTER_MIDDLENAME) }</ns1:REMITTER_MIDDLENAME>
            }
            {
                for $REMITTER_FIRSTSURNAME in $consultaRemesas/REMITTER_FIRSTSURNAME
                return
                    <ns1:REMITTER_FIRSTSURNAME>{ data($REMITTER_FIRSTSURNAME) }</ns1:REMITTER_FIRSTSURNAME>
            }
            {
                for $REMITTER_SECONDSURNAME in $consultaRemesas/REMITTER_SECONDSURNAME
                return
                    <ns1:REMITTER_SECONDSURNAME>{ data($REMITTER_SECONDSURNAME) }</ns1:REMITTER_SECONDSURNAME>
            }
            {
                for $BENEFICIARY_FIRSTNAME in $consultaRemesas/BENEFICIARY_FIRSTNAME
                return
                    <ns1:BENEFICIARY_FIRSTNAME>{ data($BENEFICIARY_FIRSTNAME) }</ns1:BENEFICIARY_FIRSTNAME>
            }
            {
                for $BENEFICIARY_MIDDLENAME in $consultaRemesas/BENEFICIARY_MIDDLENAME
                return
                    <ns1:BENEFICIARY_MIDDLENAME>{ data($BENEFICIARY_MIDDLENAME) }</ns1:BENEFICIARY_MIDDLENAME>
            }
            {
                for $BENEFICIARY_FIRSTSURNAME in $consultaRemesas/BENEFICIARY_FIRSTSURNAME
                return
                    <ns1:BENEFICIARY_FIRSTSURNAME>{ data($BENEFICIARY_FIRSTSURNAME) }</ns1:BENEFICIARY_FIRSTSURNAME>
            }
            {
                for $BENEFICIARY_SECONDSURNAME in $consultaRemesas/BENEFICIARY_SECONDSURNAME
                return
                    <ns1:BENEFICIARY_SECONDSURNAME>{ data($BENEFICIARY_SECONDSURNAME) }</ns1:BENEFICIARY_SECONDSURNAME>
            }
            <ns1:REMITTANCES_ALLOWED>{ $remittancesAllowed }</ns1:REMITTANCES_ALLOWED>
            <ns1:IDPAYER>{ $idPayer }</ns1:IDPAYER>
        </ns1:sjConsultaRemesaPorNombreRequest>
};

declare variable $consultaRemesas as element(ns0:consultaRemesas) external;
declare variable $remittancesAllowed as xs:string external;
declare variable $idPayer as xs:string external;

xf:sjConsultaRemesaPorNombreIn($consultaRemesas,
    $remittancesAllowed,
    $idPayer)