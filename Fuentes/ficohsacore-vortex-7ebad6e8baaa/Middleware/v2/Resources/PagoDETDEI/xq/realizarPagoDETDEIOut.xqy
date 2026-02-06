xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/pagoDET/realizarPagoDET/xsd/realizarPagoDET_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoDETResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/realizarPagoDET";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDETDEI/xq/realizarPagoDETDEIOut/";

declare function xf:realizarPagoDETDEIOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:pagoDETResponse) {
        <ns1:pagoDETResponse>
            <BILL_NUMBER>{ data($outputParameters/ns0:PN_CODIGORECIBO) }</BILL_NUMBER>
            {
                let $PV_REFERENCIAFENIX := fn:string($outputParameters/ns0:PV_REFERENCIAFENIX/text())
                return
                	if($PV_REFERENCIAFENIX != '') then (
                    	<EXTERNAL_REFERENCE>{ data($PV_REFERENCIAFENIX) }</EXTERNAL_REFERENCE>
                    ) else()
            }
        </ns1:pagoDETResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:realizarPagoDETDEIOut($outputParameters)