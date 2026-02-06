xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDeudores1" element="ns0:consultaDeudores" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABK/consultarDeudoresClienteDepRef/xsd/consultarDeudoresClienteDepRef_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarDeudoresClienteDepRef";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDeudoresDepRef/xq/consultarDeudoresClienteDepRefIn/";

declare function xf:consultarDeudoresClienteDepRefIn($consultaDeudores1 as element(ns0:consultaDeudores))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CODIGOCLIENTE>{ data($consultaDeudores1/CUSTOMER_ID) }</ns2:PV_CODIGOCLIENTE>
            <ns2:PV_NROCUENTA>{ data($consultaDeudores1/ACCOUNT_NUMBER) }</ns2:PV_NROCUENTA>
            {
            	let $paging := $consultaDeudores1/PAGING_INFO/PAGING
	            let $INITIAL_RECORD := $consultaDeudores1/PAGING_INFO/INITIAL_RECORD
	            let $RECORD_COUNT := $consultaDeudores1/PAGING_INFO/RECORD_COUNT
	            return
	            	if ($paging = 'YES') then
		            	(<ns2:PN_REGINICIAL>{ data($INITIAL_RECORD) }</ns2:PN_REGINICIAL>,
		                 <ns2:PN_CANTREGISTROS>{ data($RECORD_COUNT) }</ns2:PN_CANTREGISTROS>)	                    
		            else 
		            	()
            }
        </ns2:InputParameters>
};

declare variable $consultaDeudores1 as element(ns0:consultaDeudores) external;

xf:consultarDeudoresClienteDepRefIn($consultaDeudores1)