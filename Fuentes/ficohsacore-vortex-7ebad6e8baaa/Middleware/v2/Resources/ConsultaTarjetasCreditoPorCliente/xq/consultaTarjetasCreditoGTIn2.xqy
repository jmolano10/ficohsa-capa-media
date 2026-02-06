xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorCliente" element="ns0:consultaTarjetasCreditoPorCliente" location="../xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarTarjetasCredito_v2" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetasCreditoPorCliente/xq/consultaTarjetasCreditoGTIn/";

declare function xf:consultaTarjetasCreditoGTIn($consultaTarjetasCreditoPorCliente as element(ns0:consultaTarjetasCreditoPorCliente))
    as element(ns1:ConsultarTarjetasCredito_v2) {
        <ns1:ConsultarTarjetasCredito_v2>
            <ns1:Tipo>
	            { 
	            	let $customerIdType := data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_TYPE)
	            	return
		            	if($customerIdType = "CUSTOMER_ID") then (
			            	1
						) else if($customerIdType = "LEGAL_ID") then (
							2
						) else() 
	            }
            </ns1:Tipo>
            <ns1:Parametro>{ data($consultaTarjetasCreditoPorCliente/CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</ns1:Parametro>
            <ns1:Saldos>NONE</ns1:Saldos>
        </ns1:ConsultarTarjetasCredito_v2>
};

declare variable $consultaTarjetasCreditoPorCliente as element(ns0:consultaTarjetasCreditoPorCliente) external;

xf:consultaTarjetasCreditoGTIn($consultaTarjetasCreditoPorCliente)