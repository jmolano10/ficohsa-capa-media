xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraTarjetaDebitoResponse" element="ns0:ConsultaMaestraTarjetaDebitoResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/consultaCuentasAfiliadasTarjetaDebitoHeaderOut/";

declare function xf:consultaCuentasAfiliadasTarjetaDebitoHeaderOut($consultaMaestraTarjetaDebitoResponse as element(ns0:ConsultaMaestraTarjetaDebitoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
	        {
	       		if(empty($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/ZERORECORDS/text())) then(
	    			<successIndicator>{ data($consultaMaestraTarjetaDebitoResponse/Status/successIndicator) }</successIndicator>,
	    			
                	for $messages in $consultaMaestraTarjetaDebitoResponse/Status/messages
                	return
                    	<messages>{ data($messages) }</messages>
	    			 )
	    		 else(
	    			<successIndicator>NO RECORDS</successIndicator>,
	    			<messages>{ data($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/ZERORECORDS) } </messages>
	    		 )
	        }
        </ns1:ResponseHeader>
};

declare variable $consultaMaestraTarjetaDebitoResponse as element(ns0:ConsultaMaestraTarjetaDebitoResponse) external;

xf:consultaCuentasAfiliadasTarjetaDebitoHeaderOut($consultaMaestraTarjetaDebitoResponse)