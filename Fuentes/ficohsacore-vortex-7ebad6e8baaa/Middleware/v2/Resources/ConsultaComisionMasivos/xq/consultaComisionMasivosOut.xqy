xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/consultaComisionMasivos/xsd/ConsultaComisionMasivos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaComisionMasivosResponse" location="../xsd/consultaComisionMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaComisionMasivos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionMasivos/xq/consultaComisionMasivosOut/";

declare function xf:consultaComisionMasivosOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ConsultaComisionMasivosResponse) {
        <ns0:ConsultaComisionMasivosResponse>
            <TOTAL_AMOUNT>{ data($outputParameters1/ns1:PV_TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            <TOTAL_AMOUNT_ERROR>{ data($outputParameters1/ns1:PV_TOTAL_AMOUNT_ERROR) }</TOTAL_AMOUNT_ERROR>
            <TOTAL_AMOUNT_TSP>{ data($outputParameters1/ns1:PV_TOTAL_AMOUNT_TSP) }</TOTAL_AMOUNT_TSP>
            <TOTAL_TSP>{ data($outputParameters1/ns1:PV_TOTAL_TSP) }</TOTAL_TSP>
            <NUMBER_OF_TRANS_APPLY_TSP>{ data($outputParameters1/ns1:PV_NUMBER_OF_TRANS_APPLY_TSP) }</NUMBER_OF_TRANS_APPLY_TSP>
            <NUMBER_OF_TRANS_NOAPPLY_TSP>{ data($outputParameters1/ns1:PV_NUMBER_OF_TRANS_NOAPPLY_TSP) }</NUMBER_OF_TRANS_NOAPPLY_TSP>
            <NUMBER_OF_TRANS_ERROR>{ data($outputParameters1/ns1:PV_NUMBER_OF_TRANS_ERROR) }</NUMBER_OF_TRANS_ERROR>
            <NUMBER_OF_TRANS_SUCCESS>{ data($outputParameters1/ns1:PV_NUMBER_OF_TRANS_SUCCESS) }</NUMBER_OF_TRANS_SUCCESS>
        </ns0:ConsultaComisionMasivosResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaComisionMasivosOut($outputParameters1)