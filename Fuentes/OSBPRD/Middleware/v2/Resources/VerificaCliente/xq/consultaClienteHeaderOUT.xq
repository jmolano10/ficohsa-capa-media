(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaCliente/xq/consultaClienteHeaderOUT/";

declare function xf:consultaClienteHeaderOUT($successIndicator as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $successIndicator }</successIndicator>
            {        
	        	if ($successIndicator != 'SUCCESS') then 
	        	(
	             <messages>CLIENTE NO ENCONTRADO</messages>
	            )else (
	             <messages>CLIENTE ENCONTRADO</messages>            
	            )
            }
        </ns0:ResponseHeader>
};

declare variable $successIndicator as xs:string external;

xf:consultaClienteHeaderOUT($successIndicator)