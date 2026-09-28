(:: pragma bea:global-element-parameter parameter="$bloqueodeanticiposenctaahorrosResponse1" element="ns0:BloqueodeanticiposenctaahorrosResponse" location="../../../BusinessServices/T24/AnticiposCliente/xsd/XMLSchema_-361259320.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoAnticipoCTAHN/xq/BloqueoAnticipioCtaHnOUT/";

declare function xf:BloqueoAnticipioCtaHnOUT($bloqueodeanticiposenctaahorrosResponse1 as element(ns0:BloqueodeanticiposenctaahorrosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        
        
            {
                for $successIndicator in $bloqueodeanticiposenctaahorrosResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
	  
		   <messages>
			{
			  for $messages in $bloqueodeanticiposenctaahorrosResponse1/Status/messages
			  let $messagesStr := ""
			  return concat($messagesStr, $messages) 
			}
			</messages>
        </ns1:ResponseHeader>
};

declare variable $bloqueodeanticiposenctaahorrosResponse1 as element(ns0:BloqueodeanticiposenctaahorrosResponse) external;

xf:BloqueoAnticipioCtaHnOUT($bloqueodeanticiposenctaahorrosResponse1)