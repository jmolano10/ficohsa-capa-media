(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoMultiple/xq/consRecaudoMultipleHdrOut/";

declare function xf:consRecaudoMultipleHdrOut($responseHeader1 as element(ns0:ResponseHeader))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $successIndicator in $responseHeader1/successIndicator
                return
                    <successIndicator>{
	                    if(upper-case(data($successIndicator))= "SUCCESS") then
	               		     ("Success")
	                    else
	                   		 ("ERROR")
                    }</successIndicator>
            }
            {
                for $messages in $responseHeader1/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $responseHeader1 as element(ns0:ResponseHeader) external;

xf:consRecaudoMultipleHdrOut($responseHeader1)