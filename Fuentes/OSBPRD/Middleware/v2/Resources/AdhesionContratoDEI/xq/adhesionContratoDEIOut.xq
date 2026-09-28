(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/adhesionContrato/xsd/adhesionContrato_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:adhesionContratoResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/adhesionContrato";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AdhesionContrato/xq/adhesionContratoDEIOut/";

declare function xf:adhesionContratoDEIOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:adhesionContratoResponse) {
        <ns0:adhesionContratoResponse>
            {
                for $PV_IDPROCESO in $outputParameters/ns1:PV_IDPROCESO
                return
                    <PROCESS_ID>{ data($PV_IDPROCESO) }</PROCESS_ID>
            }
            {
                for $RTN in $outputParameters/ns1:PT_AUDITORIAINFO/ns1:RTN
                return
                    <RTN>{ data($RTN) }</RTN>
            }
            {
                for $PV_RAZONSOCIAL in $outputParameters/ns1:PV_RAZONSOCIAL
                return
                    <BUSINESS_NAME>{ data($PV_RAZONSOCIAL) }</BUSINESS_NAME>
            }
            {
                for $PV_IDREPLEGAL in $outputParameters/ns1:PV_IDREPLEGAL
                return
                    <LEGAL_REP_ID>{ data($PV_IDREPLEGAL) }</LEGAL_REP_ID>
            }
            {
                for $PV_EMAIL in $outputParameters/ns1:PV_EMAIL
                return
                    <EMAIL>{ data($PV_EMAIL) }</EMAIL>
            }
            {
                for $PV_NOMBREREPLEGAL in $outputParameters/ns1:PV_NOMBREREPLEGAL
                return
                    <LEGAL_REP_NAME>{ data($PV_NOMBREREPLEGAL) }</LEGAL_REP_NAME>
            }
            {
                for $PV_NUMEROESCRITURA in $outputParameters/ns1:PV_NUMEROESCRITURA
                return
                    <DEED_NUMBER>{ data($PV_NUMEROESCRITURA) }</DEED_NUMBER>
            }
            <DEED_DATE>{ data($outputParameters/ns1:PD_FECHAESCRITURA) }</DEED_DATE>
        </ns0:adhesionContratoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:adhesionContratoDEIOut($outputParameters)