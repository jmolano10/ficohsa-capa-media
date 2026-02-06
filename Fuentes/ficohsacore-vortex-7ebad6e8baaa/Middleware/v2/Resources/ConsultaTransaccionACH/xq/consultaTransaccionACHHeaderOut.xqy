xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeTxnACHRecibidaResponse1" element="ns0:ConsultadeTxnACHRecibidaResponse" location="../../../../Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/consultaTransaccionACHHeaderOut/";

declare function xf:consultaTransaccionACHHeaderOut($consultadeTxnACHRecibidaResponse1 as element(ns0:ConsultadeTxnACHRecibidaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
       	{
        	if (fn:string($consultadeTxnACHRecibidaResponse1/Status/successIndicator/text()) = "Success") then (
	            if (fn:string($consultadeTxnACHRecibidaResponse1/WSACHINCOMINGType/ZERORECORDS/text()) = "") then (
	            	<successIndicator>Success</successIndicator>
	            ) else (
	            	<successIndicator>NO RECORDS</successIndicator>,
	            	<messages>0 RECORDS RETURNED</messages>
	            )
	        ) else (
                <successIndicator>{ fn:string($consultadeTxnACHRecibidaResponse1/Status/successIndicator/text()) }</successIndicator>,
                <messages>{ fn:string($consultadeTxnACHRecibidaResponse1/Status/messages/text()) }</messages>
            )
        }
        </ns1:ResponseHeader>
};

declare variable $consultadeTxnACHRecibidaResponse1 as element(ns0:ConsultadeTxnACHRecibidaResponse) external;

xf:consultaTransaccionACHHeaderOut($consultadeTxnACHRecibidaResponse1)