xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActividadesEconomicasResponse" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaActividadesEconomicas/xsd/consultaActividadesEconomicas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActividadesEconomicas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActividadesEconomicas/xq/consultaActividadesEconomicasHNHeaderOut/";

declare function xf:consultaActividadesEconomicasHNHeaderOut($consultaActividadesEconomicasResponse as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            	let $errorCode := $consultaActividadesEconomicasResponse/ns1:P_SUCCESSINDICATOR/text()
            	let $validationMessage := $consultaActividadesEconomicasResponse/ns1:P_MESSAGES/text()
                return
	            	if ($errorCode != 'SUCCESS') then (
						<successIndicator>{ $errorCode }</successIndicator>,
						<messages>{ $validationMessage }</messages>
					)else(
						<successIndicator>Success</successIndicator>
					) 
            }
        </ns0:ResponseHeader>
};

declare variable $consultaActividadesEconomicasResponse as element(ns1:OutputParameters) external;

xf:consultaActividadesEconomicasHNHeaderOut($consultaActividadesEconomicasResponse)