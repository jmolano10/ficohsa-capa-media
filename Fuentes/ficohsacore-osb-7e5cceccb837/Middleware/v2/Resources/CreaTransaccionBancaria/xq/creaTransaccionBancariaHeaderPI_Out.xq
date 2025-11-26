(:: pragma bea:global-element-parameter parameter="$creatransaccionACHPIResponse1" element="ns0:CreatransaccionACHPIResponse" location="../../../BusinessServices/T24/CreaTransaccionBancariaACH/xsd/creaTransaccionBancariaACH.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionBancariaHeaderPI_Out/";

declare function xf:creaTransaccionBancariaHeaderPI_Out($creatransaccionACHPIResponse1 as element(ns0:CreatransaccionACHPIResponse))
    as element(ns1:ResponseHeader) {
    
        if (fn:upper-case(data($creatransaccionACHPIResponse1/Status/successIndicator)) = 'SUCCESS')then 
        (
			if (fn:upper-case(data($creatransaccionACHPIResponse1/FICOHNPIONLINEType/STATUS)) = 'SUCCESS')then 
			(       
			<ns1:ResponseHeader>
			    {
			        for $transactionId in $creatransaccionACHPIResponse1/Status/transactionId
			        return
			            <transactionId>{ data($transactionId) }</transactionId>
			    }
			    {
			        for $messageId in $creatransaccionACHPIResponse1/Status/messageId
			        return
			            <messageId>{ data($messageId) }</messageId>
			    }
			    {			       
			            <successIndicator>{ 'SUCCESS' }</successIndicator>
			    }
			    {
			        for $application in $creatransaccionACHPIResponse1/Status/application
			        return
			            <application>{ data($application) }</application>
			    }
			    {
			        for $messages in $creatransaccionACHPIResponse1/Status/messages
			        return
			            <messages>{ data($messages) }</messages>
			    }
			    {
			        for $STATUS in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/STATUS,
			            $IDREJECTION in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/IDREJECTION
			        return
			            <valueDate>{ concat($STATUS , $IDREJECTION) }</valueDate>
			    }
			</ns1:ResponseHeader>
			)
			else
			(
			 <ns1:ResponseHeader>
			    {
			        for $transactionId in $creatransaccionACHPIResponse1/Status/transactionId
			        return
			            <transactionId>{ data($transactionId) }</transactionId>
			    }
			    {
			        for $messageId in $creatransaccionACHPIResponse1/Status/messageId
			        return
			            <messageId>{ data($messageId) }</messageId>
			    }
			    {
			            <successIndicator>{ 'ERROR'  }</successIndicator>
			    }
			    {
			        for $application in $creatransaccionACHPIResponse1/Status/application
			        return
			            <application>{ data($application) }</application>
			    }
			    {
			        for $IDREJECTION in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/IDREJECTION
			        return
			            <messages>{ data($IDREJECTION) }</messages>
			    }			    
			</ns1:ResponseHeader>        
			)
        )
        else if (fn:upper-case(data($creatransaccionACHPIResponse1/Status/successIndicator)) = 'T24ERROR')then 
        (
			<ns1:ResponseHeader>
			    {
			        for $transactionId in $creatransaccionACHPIResponse1/Status/transactionId
			        return
			            <transactionId>{ data($transactionId) }</transactionId>
			    }
			    {
			        for $messageId in $creatransaccionACHPIResponse1/Status/messageId
			        return
			            <messageId>{ data($messageId) }</messageId>
			    }
			    {			       
			            <successIndicator>{ 'ERROR' }</successIndicator>
			    }
			    {
			        for $application in $creatransaccionACHPIResponse1/Status/application
			        return
			            <application>{ data($application) }</application>
			    }
			    {
			        for $messages in $creatransaccionACHPIResponse1/Status/messages
			        return
			            <messages>{ data($messages) }</messages>
			    }		
			</ns1:ResponseHeader>
        )
        else if (fn:upper-case(data($creatransaccionACHPIResponse1/Status/successIndicator)) = 'TWSERROR')then 
        (
			<ns1:ResponseHeader>
			    {
			        for $transactionId in $creatransaccionACHPIResponse1/Status/transactionId
			        return
			            <transactionId>{ data($transactionId) }</transactionId>
			    }
			    {
			        for $messageId in $creatransaccionACHPIResponse1/Status/messageId
			        return
			            <messageId>{ data($messageId) }</messageId>
			    }
			    {			       
			            <successIndicator>{ 'PENDING' }</successIndicator>
			    }
			    {
			        for $application in $creatransaccionACHPIResponse1/Status/application
			        return
			            <application>{ data($application) }</application>
			    }
			    {
			        for $messages in $creatransaccionACHPIResponse1/Status/messages
			        return
			            <messages>{ data($messages) }</messages>
			    }		
			</ns1:ResponseHeader>
        )
        else
        (
			<ns1:ResponseHeader>
			    {
			        for $transactionId in $creatransaccionACHPIResponse1/Status/transactionId
			        return
			            <transactionId>{ data($transactionId) }</transactionId>
			    }
			    {
			        for $messageId in $creatransaccionACHPIResponse1/Status/messageId
			        return
			            <messageId>{ data($messageId) }</messageId>
			    }
			    {			       
			            <successIndicator>{ 'ERROR' }</successIndicator>
			    }
			    {
			        for $application in $creatransaccionACHPIResponse1/Status/application
			        return
			            <application>{ data($application) }</application>
			    }
			    {
			        for $messages in $creatransaccionACHPIResponse1/Status/messages
			        return
			            <messages>{ data($messages) }</messages>
			    }		
			</ns1:ResponseHeader>
        )
};

declare variable $creatransaccionACHPIResponse1 as element(ns0:CreatransaccionACHPIResponse) external;

xf:creaTransaccionBancariaHeaderPI_Out($creatransaccionACHPIResponse1)
