(:: pragma bea:global-element-parameter parameter="$consultaanticiposdisponiblesctaResponse1" element="ns0:ConsultaanticiposdisponiblesctaResponse" location="../../../BusinessServices/T24/AnticiposCliente/xsd/XMLSchema_-361259320.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAnticiposCliente/xq/ConsultaAnticiposHN_HOut/";

declare function xf:ConsultaAnticiposHN_HOut($consultaanticiposdisponiblesctaResponse1 as element(ns0:ConsultaanticiposdisponiblesctaResponse))
    as element(ns1:ResponseHeader) {
	
	if (fn:string($consultaanticiposdisponiblesctaResponse1/FICOECARELIEFWSType[1]/ZERONORECORDS/text()) != "") then
    	(	       
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultaanticiposdisponiblesctaResponse1/Status/successIndicator
                return
                    <successIndicator>NO RECORDS</successIndicator>
            }
	    			       
            {
                for $messages in $consultaanticiposdisponiblesctaResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
	)else (
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultaanticiposdisponiblesctaResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultaanticiposdisponiblesctaResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }            
        </ns1:ResponseHeader>

)        
};

declare variable $consultaanticiposdisponiblesctaResponse1 as element(ns0:ConsultaanticiposdisponiblesctaResponse) external;

xf:ConsultaAnticiposHN_HOut($consultaanticiposdisponiblesctaResponse1)