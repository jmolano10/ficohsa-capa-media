xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaLote1" element="ns0:consultaLote" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/consultarLoteDepRef/xsd/consultarLoteDepRef_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLoteDepRef";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLoteDepRef/xq/ConsultaLoteDepRefIn/";

declare function xf:ConsultaLoteDepRefIn($consultaLote1 as element(ns0:consultaLote))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGOCLIENTE>{ data($consultaLote1/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTE>
            <ns2:PV_NROCUENTA>{ data($consultaLote1/ACCOUNT_NUMBER) }</ns2:PV_NROCUENTA>
            <ns2:PN_NROLOTE>{ data($consultaLote1/BANK_BATCH_ID) }</ns2:PN_NROLOTE>
            <ns2:PN_REGINICIAL>
	            { 
	            	if (data($consultaLote1/PAGING_INFO/PAGING/text()) = "YES") then
	            		data($consultaLote1/PAGING_INFO/INITIAL_RECORD)
	            	else
	            		("")
	            }
            </ns2:PN_REGINICIAL>
            <ns2:PN_CANTREGISTROS>
	            { 
	            	if (data($consultaLote1/PAGING_INFO/PAGING/text()) = "YES") then
	            		data($consultaLote1/PAGING_INFO/RECORD_COUNT)
	            	else
	            		("")
	            }
            </ns2:PN_CANTREGISTROS>      
        </ns2:InputParameters>
};

declare variable $consultaLote1 as element(ns0:consultaLote) external;

xf:ConsultaLoteDepRefIn($consultaLote1)