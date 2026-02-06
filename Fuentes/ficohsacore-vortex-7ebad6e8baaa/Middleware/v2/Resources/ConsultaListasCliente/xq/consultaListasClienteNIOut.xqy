xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaListasClienteResponse" location="../xsd/consultaListasClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/consultaListasClienteNIOut/";

declare function xf:consultaListasClienteNIOut($outputParameters1 as node(), $customerId1 as xs:string) 
	as element(ns0:consultaListasClienteResponse){

    	<ns0:consultaListasClienteResponse>     
			<CUSTOMER_ID> { $customerId1 } </CUSTOMER_ID>
			<CUSTOMER_NAME></CUSTOMER_NAME>
			<ASSOCIATIONS_LIST>
			{				
				for $ASSOCIATION in $outputParameters1/LISTAS
				return
					<ASSOCIATION>        
		    			<ASSOCIATION_NAME>{ $ASSOCIATION/LISTA/text() }</ASSOCIATION_NAME>
		    			<CUSTOMER_STATUS>{ $ASSOCIATION/ESTADO/text() }</CUSTOMER_STATUS>
		    		</ASSOCIATION>
			}
			</ASSOCIATIONS_LIST>
		</ns0:consultaListasClienteResponse>	

};

declare variable $customerId as xs:string external;
declare variable $outputParameters as node() external;

xf:consultaListasClienteNIOut($outputParameters, $customerId)