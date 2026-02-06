xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFinancierasACH1" element="ns1:consultaFinancierasACH" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFinancierasACH";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaFinancierasACH/xq/consultaFinancierasACHIn/";

declare function xf:consultaFinancierasACHIn($consultaFinancierasACH1 as element(ns1:consultaFinancierasACH))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $DESTINATION_CODE in $consultaFinancierasACH1/DESTINATION_CODE
                return
                    <ns0:DESTINATION_CODE>{ data($DESTINATION_CODE) }</ns0:DESTINATION_CODE>
            }
        </ns0:InputParameters>
};

declare variable $consultaFinancierasACH1 as element(ns1:consultaFinancierasACH) external;

xf:consultaFinancierasACHIn($consultaFinancierasACH1)