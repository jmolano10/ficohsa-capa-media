(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizaEstadoTDSwitch" location="../../ActualizaEstadoTDSwitch/xsd/actualizaEstadoTDSwitchTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoTDSwitchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTDSwitchFacade/xq/actualizaEstadoTDSwitchIn/";

declare function xf:actualizaEstadoTDSwitchIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:actualizaEstadoTDSwitch) {
        <ns1:actualizaEstadoTDSwitch>
        	{
        		<HEADER_MESSAGE_DETAILS>
	        		{
	        			for $message at $i in fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE), '@FM')
	        			return(
	        				if($i <= 7 and $message != '') then(
				        		<ITEM>
				        			<KEY>{ fn:tokenize($message, '@@')[1] }</KEY>
				            		<VALUE>{ fn:tokenize($message, '@@')[2] }</VALUE>
				        		</ITEM>
			        		)else()
			        	)
			        }
				</HEADER_MESSAGE_DETAILS>,
        		<BODY_MESSAGE_DETAILS>
		            {    	
		        		for $message at $i in fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE), '@FM')
		        		return(
		        			if($i > 7 and $message != '') then(
		        				<ITEM>
		                    		<KEY>{ fn:tokenize($message, '@@')[1] }</KEY>
		                    		<VALUE>{ fn:tokenize($message, '@@')[2] }</VALUE>
		                		</ITEM>	
		        			)else()
		        		)
	        		}
        		</BODY_MESSAGE_DETAILS>
        	}
        </ns1:actualizaEstadoTDSwitch>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:actualizaEstadoTDSwitchIn($procesaMensajeGenericoT24)