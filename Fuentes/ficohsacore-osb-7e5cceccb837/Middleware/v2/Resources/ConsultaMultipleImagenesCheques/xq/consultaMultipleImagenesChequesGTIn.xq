(:: pragma bea:global-element-parameter parameter="$consultaMultipleImagenesChequesRequest" element="ns1:consultaMultipleImagenesChequesRequest" location="../xsd/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaMultipleImagenesCheques/xsd/consultaRutaInfoCheques_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaInfoCheques";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaMultipleImagenesChequesGTIn/";

declare function xf:consultaMultipleImagenesChequesGTIn($consultaMultipleImagenesChequesRequest as element(ns1:consultaMultipleImagenesChequesRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ACCOUNT_NUMBER>{ data($consultaMultipleImagenesChequesRequest/ACCOUNT_NUMBER) }</ns0:PV_ACCOUNT_NUMBER>
            {
                for $CHEQUE_NUMBER in $consultaMultipleImagenesChequesRequest/CHEQUE_NUMBER
                return
                    <ns0:PV_CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</ns0:PV_CHEQUE_NUMBER>
            }
            {
                for $START_DATE in $consultaMultipleImagenesChequesRequest/START_DATE
                return
                    <ns0:PV_START_DATE>{ data($START_DATE) }</ns0:PV_START_DATE>
            }
            {
                for $END_DATE in $consultaMultipleImagenesChequesRequest/END_DATE
                return
                    <ns0:PV_END_DATE>{ data($END_DATE) }</ns0:PV_END_DATE>
            }
            {
                for $MAX_CHEQUES in $consultaMultipleImagenesChequesRequest/MAX_CHEQUES
                return
                    <ns0:PN_MAX_CHEQUES>{ data($MAX_CHEQUES) }</ns0:PN_MAX_CHEQUES>
            }
            {
                for $INITIAL_POSITION_RETURNED in $consultaMultipleImagenesChequesRequest/INITIAL_POSITION_RETURNED
                return
                    <ns0:PN_INITIAL_POSITION>{ data($INITIAL_POSITION_RETURNED) }</ns0:PN_INITIAL_POSITION>
            }
        </ns0:InputParameters>
};

declare variable $consultaMultipleImagenesChequesRequest as element(ns1:consultaMultipleImagenesChequesRequest) external;

xf:consultaMultipleImagenesChequesGTIn($consultaMultipleImagenesChequesRequest)