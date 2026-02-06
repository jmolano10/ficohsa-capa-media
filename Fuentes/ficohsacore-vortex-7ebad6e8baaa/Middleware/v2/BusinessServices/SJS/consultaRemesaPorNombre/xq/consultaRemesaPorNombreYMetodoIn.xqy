xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaRemesaPorNombreRequest" element="ns2:sjConsultaRemesaPorNombreRequest" location="../xsd/sjConsultaRemesaPorNombre.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../MDW/consultaRemesadorasPorPrioridad/xsd/consultaRemesadorasPorPrioridad_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRemesaPorNombreYMetodo" location="../../../../Resources/ConsultaRemesaPorNombreYMetodo/xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRemesaPorNombre";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRemesadorasPorPrioridad";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRemesaPorNombre/xq/consultaRemesaPorNombreYMetodoIn/";

declare function xf:consultaRemesaPorNombreYMetodoIn($nroGrupoPrioridad as xs:int,$nroRemesadora as xs:int,
    $sjConsultaRemesaPorNombreRequest as element(ns2:sjConsultaRemesaPorNombreRequest),
    $outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaRemesaPorNombreYMetodo) {
        <ns1:consultaRemesaPorNombreYMetodo>
            {
                for $REMITTER_FIRSTNAME in $sjConsultaRemesaPorNombreRequest/ns2:REMITTER_FIRSTNAME
                return
                    <REMITTER_FIRSTNAME>{ data($REMITTER_FIRSTNAME) }</REMITTER_FIRSTNAME>
            }
            {
                for $REMITTER_MIDDLENAME in $sjConsultaRemesaPorNombreRequest/ns2:REMITTER_MIDDLENAME
                return
                    <REMITTER_MIDDLENAME>{ data($REMITTER_MIDDLENAME) }</REMITTER_MIDDLENAME>
            }
            {
                for $REMITTER_FIRSTSURNAME in $sjConsultaRemesaPorNombreRequest/ns2:REMITTER_FIRSTSURNAME
                return
                    <REMITTER_FIRSTSURNAME>{ data($REMITTER_FIRSTSURNAME) }</REMITTER_FIRSTSURNAME>
            }
            {
                for $REMITTER_SECONDSURNAME in $sjConsultaRemesaPorNombreRequest/ns2:REMITTER_SECONDSURNAME
                return
                    <REMITTER_SECONDSURNAME>{ data($REMITTER_SECONDSURNAME) }</REMITTER_SECONDSURNAME>
            }
            {
                for $BENEFICIARY_FIRSTNAME in $sjConsultaRemesaPorNombreRequest/ns2:BENEFICIARY_FIRSTNAME
                return
                    <BENEFICIARY_FIRSTNAME>{ data($BENEFICIARY_FIRSTNAME) }</BENEFICIARY_FIRSTNAME>
            }
            {
                for $BENEFICIARY_MIDDLENAME in $sjConsultaRemesaPorNombreRequest/ns2:BENEFICIARY_MIDDLENAME
                return
                    <BENEFICIARY_MIDDLENAME>{ data($BENEFICIARY_MIDDLENAME) }</BENEFICIARY_MIDDLENAME>
            }
            {
                for $BENEFICIARY_FIRSTSURNAME in $sjConsultaRemesaPorNombreRequest/ns2:BENEFICIARY_FIRSTSURNAME
                return
                    <BENEFICIARY_FIRSTSURNAME>{ data($BENEFICIARY_FIRSTSURNAME) }</BENEFICIARY_FIRSTSURNAME>
            }
            {
                for $BENEFICIARY_SECONDSURNAME in $sjConsultaRemesaPorNombreRequest/ns2:BENEFICIARY_SECONDSURNAME
                return
                    <BENEFICIARY_SECONDSURNAME>{ data($BENEFICIARY_SECONDSURNAME) }</BENEFICIARY_SECONDSURNAME>
            }
            {
                for $REMITTANCES_ALLOWED in $sjConsultaRemesaPorNombreRequest/ns2:REMITTANCES_ALLOWED
                return
                    <REMITTANCES_ALLOWED>{ data($REMITTANCES_ALLOWED) }</REMITTANCES_ALLOWED>
            }
            {
                for $IDPAYER in $sjConsultaRemesaPorNombreRequest/ns2:IDPAYER
                return
                    <IDPAYER>{ data($IDPAYER) }</IDPAYER>
            }
        	<REMITTANCE_ID>{ fn:string($outputParameters/ns0:GRUPOS/ns0:GRUPO_PRIORIDAD[$nroGrupoPrioridad]/ns0:REMESADORAS/ns0:REMESADORA[$nroRemesadora]/ns0:ID_CONVENIO_T24/text()) }</REMITTANCE_ID>;
            <REMITTANCE_NAME>{ fn:string($outputParameters/ns0:GRUPOS/ns0:GRUPO_PRIORIDAD[$nroGrupoPrioridad]/ns0:REMESADORAS/ns0:REMESADORA[$nroRemesadora]/ns0:NOMBRE/text()) }</REMITTANCE_NAME>;
            <REMITTANCE_IDENTIFIER>{ fn:string($outputParameters/ns0:GRUPOS/ns0:GRUPO_PRIORIDAD[$nroGrupoPrioridad]/ns0:REMESADORAS/ns0:REMESADORA[$nroRemesadora]/ns0:ABREVIATURA/text()) }</REMITTANCE_IDENTIFIER>;
            <REMITTANCE_TYPE>{ fn:string($outputParameters/ns0:GRUPOS/ns0:GRUPO_PRIORIDAD[$nroGrupoPrioridad]/ns0:REMESADORAS/ns0:REMESADORA[$nroRemesadora]/ns0:TIPO/text()) }</REMITTANCE_TYPE>;
            <OPERATION_CODE>{ fn:string($outputParameters/ns0:GRUPOS/ns0:GRUPO_PRIORIDAD[$nroGrupoPrioridad]/ns0:REMESADORAS/ns0:REMESADORA[$nroRemesadora]/ns0:CODIGO_OPERACION/text()) }</OPERATION_CODE>;
            <BRANCH_CODE>{ fn:string($outputParameters/ns0:GRUPOS/ns0:GRUPO_PRIORIDAD[$nroGrupoPrioridad]/ns0:REMESADORAS/ns0:REMESADORA[$nroRemesadora]/ns0:CODIGO_AGENCIA/text()) }</BRANCH_CODE>
        </ns1:consultaRemesaPorNombreYMetodo>
};

declare variable $nroGrupoPrioridad as xs:int external;
declare variable $nroRemesadora as xs:int external;
declare variable $sjConsultaRemesaPorNombreRequest as element(ns2:sjConsultaRemesaPorNombreRequest) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaRemesaPorNombreYMetodoIn(
	$nroGrupoPrioridad,
	$nroRemesadora,
    $sjConsultaRemesaPorNombreRequest,
    $outputParameters
)