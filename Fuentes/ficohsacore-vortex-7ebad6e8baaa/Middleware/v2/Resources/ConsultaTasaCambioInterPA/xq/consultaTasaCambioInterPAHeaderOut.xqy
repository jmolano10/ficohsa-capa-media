xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaTasaCambioInterPA/xsd/consultaTasaCambioInterPA_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambioInterPA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaTasaCambioInterPA/xq/consultaTasaCambioInterPAHeaderOut/";

declare function xf:consultaTasaCambioInterPAHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $ERROR_CODE in $outputParameters1/ns1:ERROR_CODE
                return
                   if (($outputParameters1/ns1:ERROR_CODE="SUCCESS")) then
                (
                 	<successIndicator>Success</successIndicator>
                ) 
                else(
                 	<successIndicator>{ data($ERROR_CODE) }</successIndicator>
                )
            }
            {
                for $ERROR_MESSAGE in $outputParameters1/ns1:ERROR_MESSAGE
                return
                   if (($outputParameters1/ns1:ERROR_MESSAGE="")) then
                (
                    <messages></messages>
                )
                else(
                	<messages>{ data($ERROR_MESSAGE) }</messages>
                )
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaTasaCambioInterPAHeaderOut($outputParameters1)