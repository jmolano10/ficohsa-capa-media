(:: pragma bea:global-element-parameter parameter="$editarEstadoRegistroLote" element="ns0:editarEstadoRegistroLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/editarRegistroLote/xsd/editarRegistroLote_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/editarRegistroLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EditarEstadoRegistroLote/xq/editarEstadoRegistroLoteIn/";

declare function xf:editarEstadoRegistroLoteIn($editarEstadoRegistroLote as element(ns0:editarEstadoRegistroLote))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_AUDITORIAINFO>
                <ns1:CODIGO_CLIENTE>{ data($editarEstadoRegistroLote/CUSTOMER_ID) }</ns1:CODIGO_CLIENTE>
                <ns1:CODIGO_USUARIO>{ data($editarEstadoRegistroLote/USER_ID) }</ns1:CODIGO_USUARIO>
            </ns1:PT_AUDITORIAINFO>
            <ns1:PN_BANK_BATCH_ID>{ data($editarEstadoRegistroLote/BANK_BATCH_ID) }</ns1:PN_BANK_BATCH_ID>
            <ns1:PD_UPLOAD_DATE>{ data($editarEstadoRegistroLote/UPLOAD_DATE) }</ns1:PD_UPLOAD_DATE>
            {	
            	let $transactions := string-join($editarEstadoRegistroLote/TRANSACTIONS/TRANSACTION/ID,",")
            	return
            	if(data($editarEstadoRegistroLote/STATUS)="VALID")then
            	(
                	<ns1:PV_TRANSACTIONS>{concat("1",",",$transactions,",")}</ns1:PV_TRANSACTIONS>
                )
                else
                (
                	<ns1:PV_TRANSACTIONS>{concat("0",",",$transactions,",")}</ns1:PV_TRANSACTIONS>
                )
            }
        </ns1:InputParameters>
};

declare variable $editarEstadoRegistroLote as element(ns0:editarEstadoRegistroLote) external;

xf:editarEstadoRegistroLoteIn($editarEstadoRegistroLote)