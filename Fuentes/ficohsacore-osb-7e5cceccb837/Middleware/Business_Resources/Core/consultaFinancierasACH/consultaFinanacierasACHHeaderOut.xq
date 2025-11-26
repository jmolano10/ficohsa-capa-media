(:: pragma bea:global-element-parameter parameter="$consultadedestinosACHResponse1" element="ns0:ConsultadedestinosACHResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinanacierasACHHeaderOut/";

declare function xf:consultaFinanacierasACHHeaderOut($consultadedestinosACHResponse1 as element(ns0:ConsultadedestinosACHResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>        	
        {
       		if(empty($consultadedestinosACHResponse1/WSACHBANKLISTType[1]/ZERORECORDS/text())) then(
    			<successIndicator>{ data($consultadedestinosACHResponse1/Status/successIndicator) }</successIndicator>,
    			<messages>{ data($consultadedestinosACHResponse1/Status/messages) }</messages>
    			 )
    		 else(
    			<successIndicator>NO RECORDS</successIndicator>,
    			<messages>{ data($consultadedestinosACHResponse1/WSACHBANKLISTType[1]/ZERORECORDS) } </messages>
    		 )
        }
        </ns1:ResponseHeader>
};

declare variable $consultadedestinosACHResponse1 as element(ns0:ConsultadedestinosACHResponse) external;

xf:consultaFinanacierasACHHeaderOut($consultadedestinosACHResponse1)